clear, clc

fid = fopen('off.txt');       % Abre o arquivo names_temp.txt apenas para leitura
C = textscan(fid,'%s');        % Cria uma cell baseado no arquivo aberto (fid) e organiza a primera coluna em string e a segunda em inteiros
fclose(fid);                   % Apenas fechando o que foi aberto com fopen
INC = size(C{1},1);            % Cria uma variÃ¡vel INC com a quantidade de nomes presentes no arquivo names_temp.txt 

for i = 1:25
    
    auxstr = cell2mat(C{1}(i));
    filepath = strcat('C:\Users\biama\Desktop\UNIVASF\Mestrado\Selecao_das_bases\oddball\',auxstr); 
    
    %Dados do primeiro canal
    [EEG] = pop_loadset(filepath);
    canal1 = 1;
    EEGext = pop_select(EEG, 'time',[399 501]);
    sinal1= (EEGext.data(canal1,:));
    tempo1 = 1:length(sinal1);
    
    %Dados do segundo canal
    [EEG] = pop_loadset(filepath);
    canal2 = 32;
    EEGext = pop_select(EEG, 'time',[399 501]);
    sinal2= (EEGext.data(canal2,:));
    tempo2 = 1:length(sinal2);
    
    %Subtração
    sinal = sinal2 - sinal1;
    
    %Comprimento do sinal
    L1 = length (sinal);
    %Frequência de amostragem
    Fs = 200;
    %Novo comprimento de entrada que seja a próxima potência de 2 a partir do comprimento do sinal original
    n1 = 2^nextpow2(L1);
    %Transformada de Fourier
    Y1 = fft(sinal,n1);
    %Módulo da transformada ao quadrado
    Ynovo1 = normalize((abs(Y1)).^2);
    
     %ajuste dos parâmetros para frequência em hz
    ind = [0:65335];
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
    
     %coisas para salvar alfa
    file = extractBetween(auxstr,'eeg\','task'); %extrai o número da pasta
    file = string(file);
    %canalnome2 = int2str(canal);
    nome = strcat('C:\Users\biama\Desktop\UNIVASF\Mestrado\Semestre3\eeglab2021.1\Testes\Teste5\canais1_32\alfa\off\', file, 'canal32_1', 'alfa');
    nome = string(nome);
    save(nome, 'medianaalfa', 'mediaalfa', 'potenciaalfa', 'desvioalfa', 'curtosealfa', 'assimetriaalfa');
    
     %Medidas estatísticas de beta
    medianabeta = median(beta);
    mediabeta = mean(beta);
    potenciabeta = bandpower(beta);
    desviobeta = std(beta);
    curtosebeta = kurtosis(beta);
    assimetriabeta = skewness(beta);
    
     %coisas para salvar beta
    file = extractBetween(auxstr,'eeg\','task'); %extrai o número da pasta
    file = string(file);
    %canal2 = int2str(canal);
    nome = strcat('C:\Users\biama\Desktop\UNIVASF\Mestrado\Semestre3\eeglab2021.1\Testes\Teste5\canais1_32\beta\off\', file, 'canal32_1', 'beta');
    nome = string(nome);
    save(nome, 'medianabeta', 'mediabeta', 'potenciabeta', 'desviobeta', 'curtosebeta', 'assimetriabeta');
    
     
     %Medidas estatísticas de gama
    medianagama = median(gama);
    mediagama = mean(gama);
    potenciagama = bandpower(gama);
    desviogama = std(gama);
    curtosegama = kurtosis(gama);
    assimetriagama = skewness(gama);
    
     %coisas para salvar gama
    file = extractBetween(auxstr,'eeg\','task'); %extrai o número da pasta
    file = string(file);
    %canal2 = int2str(canal);
    nome = strcat('C:\Users\biama\Desktop\UNIVASF\Mestrado\Semestre3\eeglab2021.1\Testes\Teste5\canais1_32\gama\off\', file, 'canal32_1', 'gama');
    nome = string(nome);
    save(nome, 'medianagama', 'mediagama', 'potenciagama', 'desviogama', 'curtosegama', 'assimetriagama');
end