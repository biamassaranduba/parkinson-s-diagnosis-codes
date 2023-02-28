clear, clc

matrizctrlalfa = load('C:\Users\biama\Desktop\UNIVASF\Mestrado\Semestre4\ctrlalfa');
matrizonalfa = load('C:\Users\biama\Desktop\UNIVASF\Mestrado\Semestre4\onalfa');
matrizoffalfa = load('C:\Users\biama\Desktop\UNIVASF\Mestrado\Semestre4\offalfa');

ctrlonalfa = [struct2array(matrizctrlalfa); struct2array(matrizonalfa)];
ctrloffalfa = [struct2array(matrizctrlalfa); struct2array(matrizoffalfa)];
onoffalfa = [struct2array(matrizonalfa); struct2array(matrizoffalfa)];

matrizctrlbeta = load('C:\Users\biama\Desktop\UNIVASF\Mestrado\Semestre4\ctrlbeta');
matrizonbeta = load('C:\Users\biama\Desktop\UNIVASF\Mestrado\Semestre4\onbeta');
matrizoffbeta = load('C:\Users\biama\Desktop\UNIVASF\Mestrado\Semestre4\offbeta');

ctrlonbeta = [struct2array(matrizctrlbeta); struct2array(matrizonbeta)];
ctrloffbeta = [struct2array(matrizctrlbeta); struct2array(matrizoffbeta)];
onoffbeta = [struct2array(matrizonbeta); struct2array(matrizoffbeta)];

matrizctrlgama = load('C:\Users\biama\Desktop\UNIVASF\Mestrado\Semestre4\ctrlgama');
matrizongama = load('C:\Users\biama\Desktop\UNIVASF\Mestrado\Semestre4\ongama');
matrizoffgama = load('C:\Users\biama\Desktop\UNIVASF\Mestrado\Semestre4\offgama');

ctrlongama = [struct2array(matrizctrlgama); struct2array(matrizongama)];
ctrloffgama = [struct2array(matrizctrlgama); struct2array(matrizoffgama)];
onoffgama = [struct2array(matrizongama); struct2array(matrizoffgama)];

 %coisas para salvar alfa
    nome = strcat('C:\Users\biama\Desktop\UNIVASF\Mestrado\Semestre4\', 'ctrlon', 'alfa');
    nome = string(nome);
    save(nome, 'ctrlonalfa');
    nome = strcat('C:\Users\biama\Desktop\UNIVASF\Mestrado\Semestre4\', 'ctrloff', 'alfa');
    nome = string(nome);
    save(nome, 'ctrloffalfa');
    nome = strcat('C:\Users\biama\Desktop\UNIVASF\Mestrado\Semestre4\', 'onoff', 'alfa');
    nome = string(nome);
    save(nome, 'onoffalfa');
    
     %coisas para salvar beta
    nome = strcat('C:\Users\biama\Desktop\UNIVASF\Mestrado\Semestre4\', 'ctrlon', 'beta');
    nome = string(nome);
    save(nome, 'ctrlonbeta');
    nome = strcat('C:\Users\biama\Desktop\UNIVASF\Mestrado\Semestre4\', 'ctrloff', 'beta');
    nome = string(nome);
    save(nome, 'ctrloffbeta');
    nome = strcat('C:\Users\biama\Desktop\UNIVASF\Mestrado\Semestre4\', 'onoff', 'beta');
    nome = string(nome);
    save(nome, 'onoffbeta');
    
     %coisas para salvar gama
    nome = strcat('C:\Users\biama\Desktop\UNIVASF\Mestrado\Semestre4\', 'ctrlon', 'gama');
    nome = string(nome);
    save(nome, 'ctrlongama');
    nome = strcat('C:\Users\biama\Desktop\UNIVASF\Mestrado\Semestre4\', 'ctrloff', 'gama');
    nome = string(nome);
    save(nome, 'ctrloffgama');
    nome = strcat('C:\Users\biama\Desktop\UNIVASF\Mestrado\Semestre4\', 'onoff', 'gama');
    nome = string(nome);
    save(nome, 'onoffgama');