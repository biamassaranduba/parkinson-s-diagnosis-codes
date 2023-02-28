clear, clc

fid = fopen('todos.txt');       % Abre o arquivo names_temp.txt apenas para leitura
C = textscan(fid,'%s');        % Cria uma cell baseado no arquivo aberto (fid) e organiza a primera coluna em string e a segunda em inteiros
fclose(fid);                   % Apenas fechando o que foi aberto com fopen
INC = size(C{1},1);            % Cria uma variÃ¡vel INC com a quantidade de nomes presentes no arquivo names_temp.txt 

for i = 1:75
    
    auxstr = cell2mat(C{1}(i));
    filepath = strcat('C:\Users\biama\Desktop\UNIVASF\Mestrado\Selecao_das_bases\oddball\',auxstr); 

    %filepath = ('C:\Users\biama\Desktop\UNIVASF\Mestrado\Selecao_das_bases\oddball\sub-001\ses-01\eeg\sub-001_ses-01_task-Rest_eeg.set');
    [EEG] = pop_loadset(filepath);
    canal = 19;
    EEGext = pop_select(EEG, 'time',[0 85]);
    sinal= (EEGext.data(canal,:));
    tempo = 1:length(sinal);
    %Comprimento do sinal
    L = length (sinal);
    %Frequência de amostragem
    Fs = 200;
    %Novo comprimento de entrada que seja a próxima potência de 2 a partir do comprimento do sinal original
    n = 2^nextpow2(L);
    %Transformada de Fourier
    Y = fft(sinal,n);
    
    %ajuste dos parâmetros para frequência em hz
    ind = [0:65335];
    nind = round(ind*(Fs/n));
    kalfa1 = find(nind==8);
    kalfa2 = find(nind==13);
    alfa = Y(kalfa1(1):kalfa2(end));
    kbeta1 = kalfa2;
    kbeta2 = find(nind==30);
    beta = Y(kbeta1(end):kbeta2(end));
    kgama1 = kbeta2;
    kgama2 = find(nind==70);
    gama = Y(kgama1(end):kgama2(end));
    
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
    canal2 = int2str(canal);
    nome = strcat('C:\Users\biama\Desktop\UNIVASF\Mestrado\Semestre3\eeglab2021.1\canal19\alfa\', file, canal2, 'alfa');
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
    canal2 = int2str(canal);
    nome = strcat('C:\Users\biama\Desktop\UNIVASF\Mestrado\Semestre3\eeglab2021.1\canal19\beta\', file, canal2, 'beta');
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
    canal2 = int2str(canal);
    nome = strcat('C:\Users\biama\Desktop\UNIVASF\Mestrado\Semestre3\eeglab2021.1\canal19\gama\', file, canal2, 'gama');
    nome = string(nome);
    save(nome, 'medianagama', 'mediagama', 'potenciagama', 'desviogama', 'curtosegama', 'assimetriagama');
end