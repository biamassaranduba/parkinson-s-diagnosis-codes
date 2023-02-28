clear, clc

fid = fopen('on.txt');       % Abre o arquivo names_temp.txt apenas para leitura
C = textscan(fid,'%s');        % Cria uma cell baseado no arquivo aberto (fid) e organiza a primera coluna em string e a segunda em inteiros
fclose(fid);                   % Apenas fechando o que foi aberto com fopen
INC = size(C{1},1);            % Cria uma variÃ¡vel INC com a quantidade de nomes presentes no arquivo names_temp.txt


for i=1:25
    
    arraytotalalfa = [];
    arraytotalbeta = [];
    arraytotalgama = [];
    auxstr = cell2mat(C{1}(i));
    filepath = strcat('C:\Users\biama\Desktop\UNIVASF\Mestrado\Semestre4\Dados_preprocessados\on\',auxstr);
    
     for j = 1:60
    
        %Dados do canal
        dado = load(filepath);
        canal = j;
        sinal= (dado.EEG.data(canal,:));
        tempo = 1:length(sinal);

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
   
     arrayindalfa(i,:) = [arraytotalalfa];
    arrayindbeta(i,:) = [arraytotalbeta];
    arrayindgama(i,:) = [arraytotalgama];
    
    
end

 %coisas para salvar alfa
    nome = strcat('C:\Users\biama\Desktop\UNIVASF\Mestrado\Semestre4\', 'on', 'alfa');
    nome = string(nome);
    save(nome, 'arrayindalfa');
    
      %coisas para salvar beta
    nome = strcat('C:\Users\biama\Desktop\UNIVASF\Mestrado\Semestre4\', 'on', 'beta');
    nome = string(nome);
    save(nome, 'arrayindbeta');
    
    %coisas para salvar gama
    nome = strcat('C:\Users\biama\Desktop\UNIVASF\Mestrado\Semestre4\', 'on', 'gama');
    nome = string(nome);
    save(nome, 'arrayindgama');
    
    
