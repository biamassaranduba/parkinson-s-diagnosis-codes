clear all, clc

kFoldCV = 10;
kScale = 'auto';
svmStd = true;
svmKernel = 'rbf';
svmorder = [];
bxConst = 1;
acuracias = [];
dados = [];

featsel = false;

load('HOS\bootshossubctrlonalfa.mat');
Inputs = matriz1(:,1:end-1);
Labels = [ones(25,1); zeros(25,1)]; 

% [rho, pval] = corr(Inputs,Labels); ind = find(pval<0.05);
% Inputs = Inputs(:,ind);

% Number of samples for each valence
n=max(find(Labels == 1));

% Split into CTRL and OFF 
CTRL_Inputs = Inputs(1:n,:); OFF_Inputs = Inputs((n+1):end,:);
CTRL_Labels = Labels(1:n,:); OFF_Labels = Labels((n+1):end,:); n2 = length(OFF_Inputs(:,1));

% Compute 2/3 of the samples as the train data
n_train_1 = round(2*n/3);
n_train_2 = round(2*n2/3);

iter = 50;
accuracy_svm = zeros(1,iter); accuracy_knn = zeros(1,iter); accuracy_RF = zeros(1,iter);
sensibility_svm = zeros(1,iter); sensibility_knn = zeros(1,iter); sensibility_RF = zeros(1,iter); 
specificity_svm = zeros(1,iter); specificity_knn = zeros(1,iter); specificity_RF = zeros(1,iter); 
cm = zeros(2);

for k = 1:50
    % Randomly selected indices to build folders
    ind_1 = randperm(n);
    ind_2 = randperm(n2);

    % Training set (2/3 of each iteration data)
    train = [CTRL_Inputs(ind_1(1:n_train_1),:);OFF_Inputs(ind_2(1:n_train_2),:)];
    test = [CTRL_Inputs(ind_1(n_train_1+1:end),:);OFF_Inputs(ind_2(n_train_2+1:end),:)];

    % Class labels for the training step
    labels_train = [ones(length(CTRL_Inputs(ind_1(1:n_train_1),1)),1);2*ones(length(OFF_Inputs(ind_2(1:n_train_2),1)),1)];
    labels_train = labels_train<2;
    % Class labels for the test step
    labels_test = [ones(length(CTRL_Inputs(ind_1(n_train_1+1:end),1)),1);2*ones(length(OFF_Inputs(ind_2(n_train_2+1:end),1)),1)];
    labels_test = labels_test<2;

    if featsel
        idx = feat_selec(train,labels_train,test,labels_test,kFoldCV);
        features = train(:,idx);
        % Train SVM classifier - Feature selection
        svm = fitcsvm(train,labels_train,'Standardize',svmStd,'KernelFunction',svmKernel,'KernelScale', kScale, 'BoxConstraint',bxConst,'PolynomialOrder',svmorder);        
    else
        % Train SVM classifier - Feature selection
        svm = fitcsvm(train,labels_train,'Standardize',svmStd,'KernelFunction',svmKernel,'KernelScale', kScale, 'BoxConstraint',bxConst,'PolynomialOrder',svmorder);
        knn = fitcknn(train,labels_train,'Distance','minkowski','Exponent', [],'NumNeighbors', 10,'DistanceWeight', 'Equal','Standardize', true);
        template = templateTree('MaxNumSplits', 47);
        RF = fitcensemble(train,labels_train,'Method','Bag','NumLearningCycles',100,'Learners', template);
    end
    
%     % Crossvalidation partition folders
%     cp = cvpartition(labels_train,'KFold',kFoldCV);
%     % Run crossvalidation
%     cv1 = crossval(svm,'CVPartition',cp);    
    
    
    if featsel
        pred_c1 = predict(svm,test);        
    else
        % Test with unknown data
        pred_c1 = predict(svm,test);
        pred_c2 = predict(knn,test);
        pred_c3 = predict(RF,test);
    end
    
    cm(1,1) = cm(1,1) + sum((pred_c1(1:end/2)==labels_test(1:end/2)));
    cm(2,1) = cm(2,1) + length(pred_c1)/2 - sum((pred_c1(1:end/2)==labels_test(1:end/2)));
    
    cm(2,2) = cm(2,2) + sum((pred_c1(end/2 + 1:end)==labels_test(end/2 + 1:end)));
    cm(1,2) = cm(1,2) + length(pred_c1)/2 - sum((pred_c1(end/2 + 1:end)==labels_test(end/2 + 1:end)));
    
    (cm(1,1)+cm(2,2))/sum(sum(cm));
    
    % Compute accuracy vector for each iteration
    accuracy_svm(k) = mean(pred_c1==labels_test);    
    sensibility_svm(k) = (sum((pred_c1(1:end/2)==labels_test(1:end/2))))/(length(labels_test)/2);
    specificity_svm(k) = (sum((pred_c1(end/2 + 1:end)==labels_test(end/2 + 1:end))))/(length(labels_test)/2);
    
    accuracy_knn(k) = mean(pred_c2==labels_test);    
    sensibility_knn(k) = (sum((pred_c2(1:end/2)==labels_test(1:end/2))))/(length(labels_test)/2);
    specificity_knn(k) = (sum((pred_c2(end/2 + 1:end)==labels_test(end/2 + 1:end))))/(length(labels_test)/2);
        
    accuracy_RF(k) = mean(pred_c3==labels_test);    
    sensibility_RF(k) = (sum((pred_c3(1:end/2)==labels_test(1:end/2))))/(length(labels_test)/2);
    specificity_RF(k) = (sum((pred_c3(end/2 + 1:end)==labels_test(end/2 + 1:end))))/(length(labels_test)/2);
end

acuracias = [accuracy_knn; accuracy_svm; accuracy_RF];
mediaknn = mean(accuracy_knn)
mediasvm = mean(accuracy_svm)
mediarf = mean(accuracy_RF)
desvioknn = std(accuracy_knn);
desviosvm = std(accuracy_svm);
desviorf = std(accuracy_RF);
[hknnrf, pknnrf] = ttest(accuracy_knn, accuracy_RF);
[hknnsvm, pknnsvm] = ttest(accuracy_knn, accuracy_svm);
[hrfsvm, prfsvm] = ttest(accuracy_RF, accuracy_svm);
dados = [mediaknn mediasvm mediarf desvioknn desviosvm desviorf pknnrf prfsvm prfsvm];

 %coisas para salvar gama
    nome = strcat('C:\Users\biama\Desktop\UNIVASF\Mestrado\Semestre4\', 'acuracias', 'bootsesqctrloffgama');
    nome = string(nome);
    save(nome, 'acuracias');
    nome = strcat('C:\Users\biama\Desktop\UNIVASF\Mestrado\Semestre4\', 'dados', 'bootsesqctrloffgama');
    nome = string(nome);
    save(nome, 'dados');
    

classlabels = ["0"; "1"];
CM = confusionchart(cm, classlabels);
%CM.Normalization = 'column-normalized';
CM.Title = 'Matriz de Confusão';
CM.YLabel = 'Classe real';
CM.XLabel = 'Classe predita';
% Collect mean accuracy and std
%res1 = [mean(accuracy_RF) std(accuracy_RF)]
%res2 = [mean(accuracy_nb) std(accuracy_nb)]

set(gcf, 'PaperPosition', [0 0 7.5 4.5]); %Position plot at left hand corner with width 5 and height 5.
set(gcf, 'PaperSize', [7.5 4.5]); %Set the paper to have width 5 and height 5.
% saveas(gcf, './CTRL_OFF_Faster_MF', 'pdf') %Save figure

save('Resultados_CTRL_OFF_Faster','cm','accuracy_svm','sensibility_svm','specificity_svm','svm');

