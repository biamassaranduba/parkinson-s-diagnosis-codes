clear,clc
%[hdr,record] = edfread('A01_Homem1_neutral_segm01_fir.fdt');
Segm_signal = struct;
aux = struct;

fid = fopen('v6.txt');       % Abre o arquivo names_temp.txt apenas para leitura
C = textscan(fid,'%s');        % Cria uma cell baseado no arquivo aberto (fid) e organiza a primera coluna em string e a segunda em inteiros
fclose(fid);                   % Apenas fechando o que foi aberto com fopen
INC = size(C{1},1);            % Cria uma vari√°vel INC com a quantidade de nomes presentes no arquivo names_temp.txt 


for i = 1
    
    auxstr = cell2mat(C{1}(i));
    filepath = strcat('C:\Users\biama\Desktop\UNIVASF\Pesquisa_HOS\Dados_univasf\V6\',auxstr); 
  
    [EEG] = pop_loadset(filepath);
    
    for j = 1.
        
        nome=int2str(j);
        %if(EEG.xmax < 20)
            %EEGext = pop_select(EEG, 'time',[(EEG.xmax - 10) EEG.xmax]);
        %else  
        EEGext = pop_select(EEG, 'time',[0 10]);
        %end    
        %sinal = rand(1,1000);
        sinal= (EEGext.data(j,:));
        tempo = 1:length(sinal);

        %Comprimento do sinal
        L = length (sinal);
        %FrequÍncia de amostragem
        Fs = 200;

        %Novo comprimento de entrada que seja a prÛxima potÍncia de 2 a partir do comprimento do sinal original
        n = 2^nextpow2(L);
        %Transformada de Fourier
        Y = fft(sinal,n);
        %DomÌnio da frequÍncia
        f = Fs*(0:(n/2))/n;
        P = abs(Y/n);
        phaseY = unwrap(angle(Y/n));
        
        %coisas para salvar
        file = extractBetween(filepath,'V6\','p'); %extrai o n˙mero da pasta
        file = string(file);


        %bispectrum mÈtodo direto
        figure('visible','on')
        [Bspec,waxis] = bispecd(sinal, n, 5, 400, 50);
        fig = gcf;
        savefile1 = strcat('C:\Users\biama\Desktop\UNIVASF\Pesquisa_HOS\material\v6\bispecd\','bipecd_',file,'_',nome,'_0010');
        savefile1 = string(savefile1);
        print(fig,savefile1,'-dpng')
        

        % bispectrum mÈtodo indireto
        figure('visible','on')
        [Bspec,waxis] = bispeci(sinal ,10, 400, 0, 'unbiased', n, 0);
        fig = gcf;
        savefile2 = strcat('C:\Users\biama\Desktop\UNIVASF\Pesquisa_HOS\material\v6\bispeci\','bipeci_',file,'_',nome,'_0010');
        savefile2 = string(savefile2);
        print(fig,savefile2,'-dpng')
        
        
        % bicoherence
        segsamp = 400;
        wind = length (segsamp);
        figure('visible','on')
        [bic,waxis] = bicoher (sinal,  n, wind, segsamp, 50);
        fig = gcf;
        savefile3 = strcat('C:\Users\biama\Desktop\UNIVASF\Pesquisa_HOS\material\v6\bicoh\','bicoh_',file,'_',nome,'_0010');
        savefile3 = string(savefile3);
        print(fig,savefile3,'-dpng')
        

    end
end