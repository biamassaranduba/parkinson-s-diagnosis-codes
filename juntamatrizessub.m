clear, clc

matrizctrlalfa = load('C:\Users\biama\Desktop\UNIVASF\Mestrado\Semestre4\subctrlalfa');
matrizonalfa = load('C:\Users\biama\Desktop\UNIVASF\Mestrado\Semestre4\subonalfa');
matrizoffalfa = load('C:\Users\biama\Desktop\UNIVASF\Mestrado\Semestre4\suboffalfa');

subctrlonalfa = [struct2array(matrizctrlalfa); struct2array(matrizonalfa)];
subctrloffalfa = [struct2array(matrizctrlalfa); struct2array(matrizoffalfa)];
subonoffalfa = [struct2array(matrizonalfa); struct2array(matrizoffalfa)];

matrizctrlbeta = load('C:\Users\biama\Desktop\UNIVASF\Mestrado\Semestre4\subctrlbeta');
matrizonbeta = load('C:\Users\biama\Desktop\UNIVASF\Mestrado\Semestre4\subonbeta');
matrizoffbeta = load('C:\Users\biama\Desktop\UNIVASF\Mestrado\Semestre4\suboffbeta');

subctrlonbeta = [struct2array(matrizctrlbeta); struct2array(matrizonbeta)];
subctrloffbeta = [struct2array(matrizctrlbeta); struct2array(matrizoffbeta)];
subonoffbeta = [struct2array(matrizonbeta); struct2array(matrizoffbeta)];

matrizctrlgama = load('C:\Users\biama\Desktop\UNIVASF\Mestrado\Semestre4\subctrlgama');
matrizongama = load('C:\Users\biama\Desktop\UNIVASF\Mestrado\Semestre4\subongama');
matrizoffgama = load('C:\Users\biama\Desktop\UNIVASF\Mestrado\Semestre4\suboffgama');

subctrlongama = [struct2array(matrizctrlgama); struct2array(matrizongama)];
subctrloffgama = [struct2array(matrizctrlgama); struct2array(matrizoffgama)];
subonoffgama = [struct2array(matrizongama); struct2array(matrizoffgama)];

 %coisas para salvar alfa
    nome = strcat('C:\Users\biama\Desktop\UNIVASF\Mestrado\Semestre4\', 'sub', 'ctrlon', 'alfa');
    nome = string(nome);
    save(nome, 'subctrlonalfa');
    nome = strcat('C:\Users\biama\Desktop\UNIVASF\Mestrado\Semestre4\', 'sub', 'ctrloff', 'alfa');
    nome = string(nome);
    save(nome, 'subctrloffalfa');
    nome = strcat('C:\Users\biama\Desktop\UNIVASF\Mestrado\Semestre4\', 'sub', 'onoff', 'alfa');
    nome = string(nome);
    save(nome, 'subonoffalfa');
    
     %coisas para salvar beta
    nome = strcat('C:\Users\biama\Desktop\UNIVASF\Mestrado\Semestre4\', 'sub', 'ctrlon', 'beta');
    nome = string(nome);
    save(nome, 'subctrlonbeta');
    nome = strcat('C:\Users\biama\Desktop\UNIVASF\Mestrado\Semestre4\', 'sub', 'ctrloff', 'beta');
    nome = string(nome);
    save(nome, 'subctrloffbeta');
    nome = strcat('C:\Users\biama\Desktop\UNIVASF\Mestrado\Semestre4\', 'sub', 'onoff', 'beta');
    nome = string(nome);
    save(nome, 'subonoffbeta')
    
     %coisas para salvar gama
    nome = strcat('C:\Users\biama\Desktop\UNIVASF\Mestrado\Semestre4\', 'sub', 'ctrlon', 'gama');
    nome = string(nome);
    save(nome, 'subctrlongama');
    nome = strcat('C:\Users\biama\Desktop\UNIVASF\Mestrado\Semestre4\', 'sub', 'ctrloff', 'gama');
    nome = string(nome);
    save(nome, 'subctrloffgama');
    nome = strcat('C:\Users\biama\Desktop\UNIVASF\Mestrado\Semestre4\', 'sub', 'onoff', 'gama');
    nome = string(nome);
    save(nome, 'subonoffgama');