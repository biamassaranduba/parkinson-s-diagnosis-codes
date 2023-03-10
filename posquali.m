clear, clc

fid = fopen('off.txt');       % Abre o arquivo names_temp.txt apenas para leitura
C = textscan(fid,'%s');        % Cria uma cell baseado no arquivo aberto (fid) e organiza a primera coluna em string e a segunda em inteiros
fclose(fid);                   % Apenas fechando o que foi aberto com fopen
INC = size(C{1},1);            % Cria uma variável INC com a quantidade de nomes presentes no arquivo names_temp.txt 
arraytotalalfa = [];
arraytotalbeta = [];
arraytotalgama = [];

for i = 1:25
    
    auxstr = cell2mat(C{1}(i));
    filepath = strcat('C:\Users\biama\Desktop\UNIVASF\Mestrado\Selecao_das_bases\oddball\',auxstr); 
    
    for j = 1:64
    
        %Dados do canal
        [EEG] = pop_loadset(filepath);
        canal = j;
        EEGext = pop_select(EEG, 'time',[399 501]);
        sinal= (EEGext.data(canal,:));
        tempo = 1:length(sinal);

         %Comprimento do sinal
        L1 = length (sinal);
        %Frequ?ncia de amostragem
        Fs = 200;
        %Novo comprimento de entrada que seja a pr?xima pot?ncia de 2 a partir do comprimento do sinal original
        n1 = 2^nextpow2(L1);
        %Transformada de Fourier
        Y1 = fft(sinal,n1);
        %M?dulo da transformada ao quadrado
        Ynovo1 = normalize((abs(Y1)).^2);

         %ajuste dos par?metros para frequ?ncia em hz
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

        %Medidas estat?sticas de alfa
        medianaalfa = median(alfa);
        mediaalfa = mean(alfa);
        potenciaalfa = bandpower(alfa);
        desvioalfa = std(alfa);
        curtosealfa = kurtosis(alfa);
        assimetriaalfa = skewness(alfa);

        %matriz
        arrayalfa = [medianaalfa mediaalfa potenciaalfa desvioalfa curtosealfa assimetriaalfa];
        arraytotalalfa = [arrayalfa arraytotalalfa];

          %Medidas estat?sticas de beta
        medianabeta = median(beta);
        mediabeta = mean(beta);
        potenciabeta = bandpower(beta);
        desviobeta = std(beta);
        curtosebeta = kurtosis(beta);
        assimetriabeta = skewness(beta);

        %matriz
        arraybeta =[medianabeta mediabeta potenciabeta desviobeta curtosebeta assimetriabeta];
        arraytotalbeta = [arraybeta arraytotalbeta];

         %Medidas estat?sticas de gama
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
    
    arrayindalfa(i,:) = [arraytotalalfa];
    arrayindbeta(i,:) = [arraytotalbeta];
    arrayindgama(i,:) = [arraytotalgama];
    
    
    
   
end

 %coisas para salvar alfa
    file = extractBetween(auxstr,'eeg\','task'); %extrai o n?mero da pasta
    file = string(file);
    %canalnome2 = int2str(canal);
    nome = strcat('C:\Users\biama\Desktop\UNIVASF\Mestrado\Semestre3\eeglab2021.1\Testes\Teste5\canais1_32\alfa\off\', file, 'canal32_1', 'alfa');
    nome = string(nome);
    save(nome, arrayindalfa);
    
      %coisas para salvar beta
    file = extractBetween(auxstr,'eeg\','task'); %extrai o n?mero da pasta
    file = string(file);
    %canal2 = int2str(canal);
    nome = strcat('C:\Users\biama\Desktop\UNIVASF\Mestrado\Semestre3\eeglab2021.1\Testes\Teste5\canais1_32\beta\off\', file, 'canal32_1', 'beta');
    nome = string(nome);
    save(nome, arrayindbeta);
    
    %coisas para salvar gama
    file = extractBetween(auxstr,'eeg\','task'); %extrai o n?mero da pasta
    file = string(file);
    %canal2 = int2str(canal);
    nome = strcat('C:\Users\biama\Desktop\UNIVASF\Mestrado\Semestre3\eeglab2021.1\Testes\Teste5\canais1_32\gama\off\', file, 'canal32_1', 'gama');
    nome = string(nome);
    save(nome, arrayindgama);
    
    