clear all, clc

fid = fopen('on.txt');       % Abre o arquivo names_temp.txt apenas para leitura
C = textscan(fid,'%s');        % Cria uma cell baseado no arquivo aberto (fid) e organiza a primera coluna em string e a segunda em inteiros
fclose(fid);                   % Apenas fechando o que foi aberto com fopen
INC = size(C{1},1);            % Cria uma variÃ¡vel INC com a quantidade de nomes presentes no arquivo names_temp.txt
matriz=[];

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
        L = length (sinal);
        %Frequência de amostragem
        Fs = 200;
        %Novo comprimento de entrada que seja a próxima potência de 2 a partir do comprimento do sinal original
        %n = 2^nextpow2(L);
        n = 64;
       
          % bicoherence
        segsamp = 100;
        wind = length (segsamp);
        figure('visible','off')
        [bic,waxis] = bicoher (sinal,  n, wind, segsamp, 50);
        %fig = gcf;
        %savefile3 = strcat('C:\Users\biama\Desktop\UNIVASF\Pesquisa_HOS\material\v6\bicoh\','bicoh_',file,'_',nome,'_0010');
        %savefile3 = string(savefile3);
        %print(fig,savefile3,'-dpng')
        %desnormaliza frequência
        w_hz = waxis*Fs/2;
        %Separa índices das frequências
        indalfa = find(w_hz>=8 & w_hz<=13);
        indbeta = find(w_hz>13 & w_hz<=23);
        indgama = find(w_hz>30 & w_hz<=40);
        %Separa a parte da matriz referente à cada frquência
        bic_wposalfa = bic(indalfa(1):indalfa(end),indalfa(1):indalfa(end));
        bic_wposbeta = bic(indbeta(1):indbeta(end),indbeta(1):indbeta(end));
        bic_wposgama = bic(indgama(1):indgama(end),indgama(1):indgama(end));
        %Extrai matriz triangular inferior
        Lalfa = tril(bic_wposalfa);
        Lbeta = tril(bic_wposbeta);
        Lgama = tril(bic_wposgama);
        %Pega a parte diferente de zero
        nozalfa = find(Lalfa~=0);
        nozbeta = find(Lbeta~=0);
        nozgama = find(Lgama~=0);
        %Vetoriza
        vetoralfa = Lalfa(nozalfa)';
        vetorbeta = Lbeta(nozbeta)';
        vetorgama = Lgama(nozgama)';
        %vetores por canal
        arraytotalalfa = [vetoralfa arraytotalalfa];
        arraytotalbeta = [vetorbeta arraytotalbeta];
        arraytotalgama = [vetorgama arraytotalgama];
        
     end 
    arrayindalfa(i,:) = [arraytotalalfa, 1];
    arrayindbeta(i,:) = [arraytotalbeta, 1];
    arrayindgama(i,:) = [arraytotalgama, 1];
    
end

    %coisas para salvar alfa
    nome = strcat('C:\Users\biama\Desktop\UNIVASF\Mestrado\Semestre4\HOS\', 'hos', 'on', 'alfa');
    nome = string(nome);
    save(nome, 'arrayindalfa');
    
    %coisas para salvar beta
    nome = strcat('C:\Users\biama\Desktop\UNIVASF\Mestrado\Semestre4\HOS\', 'hos', 'on', 'beta');
    nome = string(nome);
    save(nome, 'arrayindbeta');
    
    %coisas para salvar gama
    nome = strcat('C:\Users\biama\Desktop\UNIVASF\Mestrado\Semestre4\HOS\', 'hos', 'on', 'gama');
    nome = string(nome);
    save(nome, 'arrayindgama');
    
    


    