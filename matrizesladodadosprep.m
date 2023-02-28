clear, clc
%indivíduos com o lado esquerdo do cérebro mais afetado

fid = fopen('ctrldireito.txt');       % Abre o arquivo names_temp.txt apenas para leitura
C = textscan(fid,'%s');        % Cria uma cell baseado no arquivo aberto (fid) e organiza a primera coluna em string e a segunda em inteiros
fclose(fid);                   % Apenas fechando o que foi aberto com fopen
INC = size(C{1},1);            % Cria uma variÃ¡vel INC com a quantidade de nomes presentes no arquivo names_temp.txt


for i=1:12
    
    arraytotalalfa = [];
    arraytotalbeta = [];
    arraytotalgama = [];
    auxstr = cell2mat(C{1}(i));
    filepath = strcat('C:\Users\biama\Desktop\UNIVASF\Mestrado\Semestre4\Dados_preprocessados\ctrl\',auxstr);
    
    
        %Dados do canal
        dado = load(filepath);
        x = size(dado.EEG.data);
        sinal = zeros(26, x(2)*x(3));
        sinal(1,:)= (dado.EEG.data(1,:));
        sinal(2,:)= (dado.EEG.data(3,:));
        sinal(3,:)= (dado.EEG.data(4,:));
        sinal(4,:)= (dado.EEG.data(5,:));
        sinal(5,:)= (dado.EEG.data(6,:));
        sinal(6,:)= (dado.EEG.data(7,:));
        sinal(7,:)= (dado.EEG.data(8,:));
        sinal(8,:)= (dado.EEG.data(9,:));
        sinal(9,:)= (dado.EEG.data(10,:));
        sinal(10,:)= (dado.EEG.data(12,:));
        sinal(11,:)= (dado.EEG.data(13,:));
        sinal(12,:)= (dado.EEG.data(14,:));
        sinal(13,:)= (dado.EEG.data(29,:));
        sinal(14,:)= (dado.EEG.data(30,:));
        sinal(15,:)= (dado.EEG.data(32,:));
        sinal(16,:)= (dado.EEG.data(33,:));
        sinal(17,:)= (dado.EEG.data(34,:));
        sinal(18,:)= (dado.EEG.data(35,:));
        sinal(19,:)= (dado.EEG.data(37,:));
        sinal(20,:)= (dado.EEG.data(38,:));
        sinal(21,:)= (dado.EEG.data(39,:));
        sinal(22,:)= (dado.EEG.data(40,:));
        sinal(23,:)= (dado.EEG.data(41,:));
        sinal(24,:)= (dado.EEG.data(42,:));
        sinal(25,:)= (dado.EEG.data(43,:));
        sinal(26,:)= (dado.EEG.data(44,:));
        
        for j = 1:26
            
        sinal1 = sinal(j,:);
        tempo = 1:length(sinal1);

         %Comprimento do sinal
        L1 = length (sinal1);
        %Frequência de amostragem
        Fs = 200;
        %Novo comprimento de entrada que seja a próxima potência de 2 a partir do comprimento do sinal original
        n1 = 2^nextpow2(L1);
        %Transformada de Fourier
        Y1 = fft(sinal1,n1);
        %Módulo da transformada ao quadrado
        Ynovo1 = normalize((abs(Y1)).^2);

         %ajuste dos parâmetros para frequência em hz
        ind = [0:382000];
        nind = round(ind*(Fs/n1));
        kalfa1 = find(nind==8);
        kalfa2 = find(nind==13);
        alfa = Ynovo1(kalfa1(1):kalfa2(end));
        kbeta1 = kalfa2;
        kbeta2 = find(nind==30);
        beta = Ynovo1(kbeta1(end):kbeta2(end));
        kgama1 = kbeta2;
        kgama2 = find(nind==70);
        gama = Ynovo1(kgama1(end):kgama2(end));

        %Medidas estatísticas de alfa
        medianaalfa = median(alfa);
        mediaalfa = mean(alfa);
        potenciaalfa = bandpower(alfa);
        desvioalfa = std(alfa);
        curtosealfa = kurtosis(alfa);
        assimetriaalfa = skewness(alfa);

        %matriz
        arrayalfa = [medianaalfa mediaalfa potenciaalfa desvioalfa curtosealfa assimetriaalfa];
        arraytotalalfa = [arrayalfa arraytotalalfa];

          %Medidas estatísticas de beta
        medianabeta = median(beta);
        mediabeta = mean(beta);
        potenciabeta = bandpower(beta);
        desviobeta = std(beta);
        curtosebeta = kurtosis(beta);
        assimetriabeta = skewness(beta);

        %matriz
        arraybeta =[medianabeta mediabeta potenciabeta desviobeta curtosebeta assimetriabeta];
        arraytotalbeta = [arraybeta arraytotalbeta];

         %Medidas estatísticas de gama
        medianagama = median(gama);
        mediagama = mean(gama);
        potenciagama = bandpower(gama);
        desviogama = std(gama);
        curtosegama = kurtosis(gama);
        assimetriagama = skewness(gama);

          %matriz
        arraygama=[medianagama mediagama potenciagama desviogama curtosegama assimetriagama];
        arraytotalgama = [arraygama arraytotalgama];
        
        end
        
     arrayindalfaesq(i,:) = [arraytotalalfa 0];
    arrayindbetaesq(i,:) = [arraytotalbeta 0];
    arrayindgamaesq(i,:) = [arraytotalgama 0];
    
    
end

%indivíduos com o lado direito do cérebro mais afetado

fid = fopen('ctrlesquerdo.txt');       % Abre o arquivo names_temp.txt apenas para leitura
C = textscan(fid,'%s');        % Cria uma cell baseado no arquivo aberto (fid) e organiza a primera coluna em string e a segunda em inteiros
fclose(fid);                   % Apenas fechando o que foi aberto com fopen
INC = size(C{1},1);            % Cria uma variÃ¡vel INC com a quantidade de nomes presentes no arquivo names_temp.txt


for i=1:13
    
    arraytotalalfa = [];
    arraytotalbeta = [];
    arraytotalgama = [];
    auxstr = cell2mat(C{1}(i));
    filepath = strcat('C:\Users\biama\Desktop\UNIVASF\Mestrado\Semestre4\Dados_preprocessados\ctrl\',auxstr);
    
    
        %Dados do canal
        dado = load(filepath);
        x = size(dado.EEG.data);
        sinal = zeros(26, x(2)*x(3));
        sinal(1,:)= (dado.EEG.data(16,:));
        sinal(2,:)= (dado.EEG.data(17,:));
        sinal(3,:)= (dado.EEG.data(18,:));
        sinal(4,:)= (dado.EEG.data(19,:));
        sinal(5,:)= (dado.EEG.data(20,:));
        sinal(6,:)= (dado.EEG.data(22,:));
        sinal(7,:)= (dado.EEG.data(23,:));
        sinal(8,:)= (dado.EEG.data(24,:));
        sinal(9,:)= (dado.EEG.data(25,:));
        sinal(10,:)= (dado.EEG.data(26,:));
        sinal(11,:)= (dado.EEG.data(27,:));
        sinal(12,:)= (dado.EEG.data(28,:));
        sinal(13,:)= (dado.EEG.data(46,:));
        sinal(14,:)= (dado.EEG.data(47,:));
        sinal(15,:)= (dado.EEG.data(48,:));
        sinal(16,:)= (dado.EEG.data(49,:));
        sinal(17,:)= (dado.EEG.data(50,:));
        sinal(18,:)= (dado.EEG.data(51,:));
        sinal(19,:)= (dado.EEG.data(52,:));
        sinal(20,:)= (dado.EEG.data(53,:));
        sinal(21,:)= (dado.EEG.data(54,:));
        sinal(22,:)= (dado.EEG.data(55,:));
        sinal(23,:)= (dado.EEG.data(56,:));
        sinal(24,:)= (dado.EEG.data(57,:));
        sinal(25,:)= (dado.EEG.data(58,:));
        sinal(26,:)= (dado.EEG.data(59,:));
        
        for j = 1:26
            
        sinal1 = sinal(j,:);
        tempo = 1:length(sinal1);

         %Comprimento do sinal
        L1 = length (sinal1);
        %Frequência de amostragem
        Fs = 200;
        %Novo comprimento de entrada que seja a próxima potência de 2 a partir do comprimento do sinal original
        n1 = 2^nextpow2(L1);
        %Transformada de Fourier
        Y1 = fft(sinal1,n1);
        %Módulo da transformada ao quadrado
        Ynovo1 = normalize((abs(Y1)).^2);

         %ajuste dos parâmetros para frequência em hz
        ind = [0:382000];
        nind = round(ind*(Fs/n1));
        kalfa1 = find(nind==8);
        kalfa2 = find(nind==13);
        alfa = Ynovo1(kalfa1(1):kalfa2(end));
        kbeta1 = kalfa2;
        kbeta2 = find(nind==30);
        beta = Ynovo1(kbeta1(end):kbeta2(end));
        kgama1 = kbeta2;
        kgama2 = find(nind==70);
        gama = Ynovo1(kgama1(end):kgama2(end));

        %Medidas estatísticas de alfa
        medianaalfa = median(alfa);
        mediaalfa = mean(alfa);
        potenciaalfa = bandpower(alfa);
        desvioalfa = std(alfa);
        curtosealfa = kurtosis(alfa);
        assimetriaalfa = skewness(alfa);

        %matriz
        arrayalfa = [medianaalfa mediaalfa potenciaalfa desvioalfa curtosealfa assimetriaalfa];
        arraytotalalfa = [arrayalfa arraytotalalfa];

          %Medidas estatísticas de beta
        medianabeta = median(beta);
        mediabeta = mean(beta);
        potenciabeta = bandpower(beta);
        desviobeta = std(beta);
        curtosebeta = kurtosis(beta);
        assimetriabeta = skewness(beta);

        %matriz
        arraybeta =[medianabeta mediabeta potenciabeta desviobeta curtosebeta assimetriabeta];
        arraytotalbeta = [arraybeta arraytotalbeta];

         %Medidas estatísticas de gama
        medianagama = median(gama);
        mediagama = mean(gama);
        potenciagama = bandpower(gama);
        desviogama = std(gama);
        curtosegama = kurtosis(gama);
        assimetriagama = skewness(gama);

          %matriz
        arraygama=[medianagama mediagama potenciagama desviogama curtosegama assimetriagama];
        arraytotalgama = [arraygama arraytotalgama];
        
        end
        
    arrayindalfadir(i,:) = [arraytotalalfa 0];
    arrayindbetadir(i,:) = [arraytotalbeta 0];
    arrayindgamadir(i,:) = [arraytotalgama 0];
    
    
end

arrayindalfa = [arrayindalfaesq; arrayindalfadir];
arrayindbeta = [arrayindbetaesq; arrayindbetadir];
arrayindgama = [arrayindgamaesq; arrayindgamadir];

 %coisas para salvar alfa
    nome = strcat('C:\Users\biama\Desktop\UNIVASF\Mestrado\Semestre4\', 'ladooposto', 'ctrl', 'alfa');
    nome = string(nome);
    save(nome, 'arrayindalfa');
    
      %coisas para salvar beta
    nome = strcat('C:\Users\biama\Desktop\UNIVASF\Mestrado\Semestre4\', 'ladooposto', 'ctrl', 'beta');
    nome = string(nome);
    save(nome, 'arrayindbeta');
    
    %coisas para salvar gama
    nome = strcat('C:\Users\biama\Desktop\UNIVASF\Mestrado\Semestre4\', 'ladooposto', 'ctrl', 'gama');
    nome = string(nome);
    save(nome, 'arrayindgama');