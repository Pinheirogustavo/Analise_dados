#Octave 7.1.0
#Autor: Gustavo Pinheiro

%%%%%%%%%%%%%%%%%%%%%%%%%%%% Descricao do codigo %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%{
xxxxxxxx
%}

#pre-defifinicoes do octave
#clear all; more off;clc; close all; %limpa o ambiente de trabalho
clearvars -except A; close all; ##### apaga todas as variaveis, menos a tabela A

#pkg load control; pkg load signal;  %carrega pacotes
 pkg load io;  %carrega pacotes

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Dados %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

#A = xlsread('desvio_padrao_temp_temp.xlsx');                %abre o arquivo de dados txt


#Ampl1_f200 = A(1:101,2);
#Ampl1_f200_DesvPad = std(Ampl1_f200);
#Ampl1_f200_Med = mean(Ampl1_f200);



#### primeira coluna de F: desvio padrao da parte real
#### segunda coluna de F: desvio padrao da parte imaginaria


###### dados de desvio padrão para
##### Frequencia 200 kHz 6 pontos tempo demodulação = 2


s=1;
r=1;
dimenA = size(A);
gapDados = 106; #numero de linhas para cada conjunto de dados de freqX e coletasY
# 100 linhas de dados + 6 linhas de cabecalho

for t=1:1:dimenA(1)/gapDados;


i = 1;
ii = 0;
d = 1;

  for j = 4:5:dimenA(2)-45
# 45 == tamanho de passo entre o eletrodo n e n+1 quando o padrao de injecao
#pula um passa para o proximo par de eletrodos

    F(i,s) = mean( A(r:r+100,j) - A(r:r+100,4+ii*45) );
    F(i,s+1) = std( A(r:r+100,j) - A(r:r+100,4+ii*45) );
#parte real
#FreqX numero_pontosY injecao 8-1;1-2;2-3...

    F(i,s+2) = mean( A(r:r+100,j+1) - A(r:r+100,5+ii*45) );
    F(i,s+3) = std( A(r:r+100,j+1) - A(r:r+100,5+ii*45) );
#parte imaginaria
#FreqX numero_pontosY injecao 8-1;1-2;2-3...

    i = i+1;
    d = d+1;
    if d>8
      ii = ii+1;
      d=1;
    endif
  end

s = s+5;
r = r+gapDados;

end


csvwrite ('resultados.txt', F);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hf1 = figure(1); %figura 1

#padrao de injecao 1->2
#frequencia fixa 200k

x_200k = [6 12 18 24 30 48 60 72  102]; #numero de pontos coletados

a = 1;
b = a+1;
t = length(x_200k);
c = 5*t;

y1 = F(9 , a:5:c);    # media eletrodo 2-1
error1 = F(9 , b:5:c);

y2 = F(11 , a:5:c);    # media eletrodo 3-1
error2 = F(11 , b:5:c);

y3 = F(12 , a:5:c);    # media eletrodo 4-1
error3 = F(12 , b:5:c);

y4 = F(13 , a:5:c);    # media eletrodo 5-1
error4 = F(13,b:5:c);

y5 = F(14 , a:5:c);    # media eletrodo 6-1
error5 = F(14 , b:5:c);

y6 = F(15 , a:5:c);    # media eletrodo 7-1
error6 = F(15 , b:5:c);

y7 = F(16 , a:5:c);    # media eletrodo 8-1
error7 = F(16 , b:5:c);

a = c+1;
b = a+1;

w=errorbar(x_200k,y1,error1,'o');
set(w,'linewidth',1);

hold on;

w=errorbar(x_200k,y2,error2,'o');
set(w,'linewidth',1);

w=errorbar(x_200k,y3,error3,'o');
set(w,'linewidth',1);

w=errorbar(x_200k,y4,error4,'o');
set(w,'linewidth',1);

w=errorbar(x_200k,y5,error5,'o');
set(w,'linewidth',1);

w=errorbar(x_200k,y6,error6,'o');
set(w,'linewidth',1);

w=errorbar(x_200k,y7,error7,'o');
set(w,'linewidth',1);



hold off;

title('Frequência 200 kHz - Injeção de corrente de eletrodo 1 para eletrodo 2');
xlabel('Numero de pontos');
ylabel('Amplitude (mV)');

legend('eletrodo 1 - eletrodo 2','eletrodo 3 - eletrodo 2','eletrodo 4 - eletrodo 2'
,'eletrodo 5 - eletrodo 2','eletrodo 6 - eletrodo 2','eletrodo 7 - eletrodo 2'
,'eletrodo 8 - eletrodo 2','location', 'northeastoutside');

saveas (hf1, "resultado_freq200_padrao_1_2.jpeg");
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hf2 = figure(2);

#padrao de injecao 1->2
#frequencia fixa 125k

x_125k = [24 48 72 96]; #numero de pontos coletados

t = length(x_125k);
c = c+5*t;

y1 = F(9 , a:5:c);    # media eletrodo 2-1
error1 = F(9 , b:5:c);

y2 = F(11 , a:5:c);    # media eletrodo 3-1
error2 = F(11 , b:5:c);

y3 = F(12 , a:5:c);    # media eletrodo 4-1
error3 = F(12 , b:5:c);

y4 = F(13 , a:5:c);    # media eletrodo 5-1
error4 = F(13,b:5:c);

y5 = F(14 , a:5:c);    # media eletrodo 6-1
error5 = F(14 , b:5:c);

y6 = F(15 , a:5:c);    # media eletrodo 7-1
error6 = F(15 , b:5:c);

y7 = F(16 , a:5:c);    # media eletrodo 8-1
error7 = F(16 , b:5:c);

a = c+1;
b = a+1;

w=errorbar(x_125k,y1,error1,'o');
set(w,'linewidth',1);

hold on;

w=errorbar(x_125k,y2,error2,'o');
set(w,'linewidth',1);
w=errorbar(x_125k,y3,error3,'o');
set(w,'linewidth',1);
w=errorbar(x_125k,y4,error4,'o');
set(w,'linewidth',1);
w=errorbar(x_125k,y5,error5,'o');
set(w,'linewidth',1);
w=errorbar(x_125k,y6,error6,'o');
set(w,'linewidth',1);
w=errorbar(x_125k,y7,error7,'o');
set(w,'linewidth',1);



hold off;

title('Frequência 125 kHz - Injeção de corrente de eletrodo 1 para eletrodo 2');
xlabel('Numero de pontos');
ylabel('Amplitude (mV)');

legend('eletrodo 1 - eletrodo 2','eletrodo 3 - eletrodo 2','eletrodo 4 - eletrodo 2'
,'eletrodo 5 - eletrodo 2','eletrodo 6 - eletrodo 2','eletrodo 7 - eletrodo 2'
,'eletrodo 8 - eletrodo 2','location', 'northeastoutside');

saveas (hf2, "resultado_freq125_padrao_1_2.jpeg");
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hf3 = figure(3);

#padrao de injecao 1->2
#frequencia fixa 100k

x_100k = [12 18 24 30 36 42 48 54 60 72 102]; #numero de pontos coletados

t = length(x_100k);
c = c+5*t;

y1 = F(9 , a:5:c);    # media eletrodo 2-1
error1 = F(9 , b:5:c);

y2 = F(11 , a:5:c);    # media eletrodo 3-1
error2 = F(11 , b:5:c);

y3 = F(12 , a:5:c);    # media eletrodo 4-1
error3 = F(12 , b:5:c);

y4 = F(13 , a:5:c);    # media eletrodo 5-1
error4 = F(13,b:5:c);

y5 = F(14 , a:5:c);    # media eletrodo 6-1
error5 = F(14 , b:5:c);

y6 = F(15 , a:5:c);    # media eletrodo 7-1
error6 = F(15 , b:5:c);

y7 = F(16 , a:5:c);    # media eletrodo 8-1
error7 = F(16 , b:5:c);

a = c+1;
b = a+1;

w=errorbar(x_100k,y1,error1,'o');
set(w,'linewidth',1);
hold on;

w=errorbar(x_100k,y2,error2,'o');
set(w,'linewidth',1);
w=errorbar(x_100k,y3,error3,'o');
set(w,'linewidth',1);
w=errorbar(x_100k,y4,error4,'o');
set(w,'linewidth',1);
w=errorbar(x_100k,y5,error5,'o');
set(w,'linewidth',1);
w=errorbar(x_100k,y6,error6,'o');
set(w,'linewidth',1);
w=errorbar(x_100k,y7,error7,'o');
set(w,'linewidth',1);

hold off;

title('Frequência 100 kHz - Injeção de corrente de eletrodo 1 para eletrodo 2');
xlabel('Numero de pontos');
ylabel('Amplitude (mV)');

legend('eletrodo 1 - eletrodo 2','eletrodo 3 - eletrodo 2','eletrodo 4 - eletrodo 2'
,'eletrodo 5 - eletrodo 2','eletrodo 6 - eletrodo 2','eletrodo 7 - eletrodo 2'
,'eletrodo 8 - eletrodo 2','location', 'northeastoutside');

saveas (hf3, "resultado_freq100_padrao_1_2.jpeg");
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hf4 = figure(4);

#padrao de injecao 1->2
#frequencia fixa 50k

x_50k = [24 36 48 60 72 96]; #numero de pontos coletados

t = length(x_50k);
c = c+5*t;

y1 = F(9 , a:5:c);    # media eletrodo 2-1
error1 = F(9 , b:5:c);

y2 = F(11 , a:5:c);    # media eletrodo 3-1
error2 = F(11 , b:5:c);

y3 = F(12 , a:5:c);    # media eletrodo 4-1
error3 = F(12 , b:5:c);

y4 = F(13 , a:5:c);    # media eletrodo 5-1
error4 = F(13,b:5:c);

y5 = F(14 , a:5:c);    # media eletrodo 6-1
error5 = F(14 , b:5:c);

y6 = F(15 , a:5:c);    # media eletrodo 7-1
error6 = F(15 , b:5:c);

y7 = F(16 , a:5:c);    # media eletrodo 8-1
error7 = F(16 , b:5:c);

a = c+1;
b = a+1;

w=errorbar(x_50k,y1,error1,'o');
set(w,'linewidth',1);
hold on;

w=errorbar(x_50k,y2,error2,'o');
set(w,'linewidth',1);
w=errorbar(x_50k,y3,error3,'o');
set(w,'linewidth',1);
w=errorbar(x_50k,y4,error4,'o');
set(w,'linewidth',1);
w=errorbar(x_50k,y5,error5,'o');
set(w,'linewidth',1);
w=errorbar(x_50k,y6,error6,'o');
set(w,'linewidth',1);
w=errorbar(x_50k,y7,error7,'o');
set(w,'linewidth',1);

hold off;

title('Frequência 50 kHz - Injeção de corrente de eletrodo 1 para eletrodo 2');
xlabel('Numero de pontos');
ylabel('Amplitude (mV)');

legend('eletrodo 1 - eletrodo 2','eletrodo 3 - eletrodo 2','eletrodo 4 - eletrodo 2'
,'eletrodo 5 - eletrodo 2','eletrodo 6 - eletrodo 2','eletrodo 7 - eletrodo 2'
,'eletrodo 8 - eletrodo 2','location', 'northeastoutside');

saveas (hf4, "resultado_freq50_padrao_1_2.jpeg");
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





%}
