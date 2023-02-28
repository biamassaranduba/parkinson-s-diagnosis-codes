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
    canal = 32;
    EEGext = pop_select(EEG, 'time',[0 85]);
    sinal= (EEGext.data(canal,:));
    tempo = 1:length(sinal);
    mediana = median(sinal);
    media = mean(sinal);
    potencia = bandpower(sinal);
    desvio = std(sinal);
    curtose = kurtosis(sinal);
    assimetria = skewness(sinal);
    %cruzamentos = zerocrossrate(x);
    picos = findpeaks(sinal);
    
     %coisas para salvar
    file = extractBetween(auxstr,'eeg\','task'); %extrai o número da pasta
    file = string(file);
    canal2 = int2str(canal);
    nome = strcat('C:\Users\biama\Desktop\UNIVASF\Mestrado\Semestre3\eeglab2021.1\canal32\', file, canal2);
    nome = string(nome);
    save(nome, 'mediana', 'media', 'potencia', 'desvio', 'curtose', 'assimetria', 'picos');
end