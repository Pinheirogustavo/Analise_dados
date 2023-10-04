#Octave 7.1.0
#Autor: Gustavo Pinheiro

%%%%%%%%%%%%%%%%%%%%%%%%%%%% Descricao do codigo %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%{
xxxxxxxx
%}

#pre-defifinicoes do octave
#clear all; more off;clc; close all; %limpa o ambiente de trabalho
clearvars -except A ##### apaga todas as variaveis, menos a tabela A
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

hf = figure(1); %figura 1

#padrao de injecao 8->1
#frequencia fixa 200k

x = 6:6:6*13; #numero de pontos

y1 = F(2 , 1:5:5*13);    # media eletrodo 2-1
error1 = F(2 , 2:5:5*13);

y2 = F(3 , 1:5:5*13);    # media eletrodo 3-1
error2 = F(3 , 2:5:5*13);

y3 = F(4 , 1:5:5*13);    # media eletrodo 4-1
error3 = F(4 , 2:5:5*13);

y4 = F(5 , 1:5:5*13);    # media eletrodo 5-1
error4 = F(5 , 2:5:5*13);

y5 = F(6 , 1:5:5*13);    # media eletrodo 6-1
error5 = F(6 , 2:5:5*13);

y6 = F(7 , 1:5:5*13);    # media eletrodo 7-1
error6 = F(7 , 2:5:5*13);

y7 = F(8 , 1:5:5*13);    # media eletrodo 8-1
error7 = F(8 , 2:5:5*13);

errorbar(x,y1,error1,'o');
hold on;

errorbar(x,y2,error2,'o');
errorbar(x,y3,error3,'o');
errorbar(x,y4,error4,'o');
errorbar(x,y5,error5,'o');
errorbar(x,y6,error6,'o');
errorbar(x,y7,error7,'o');


hold off;

title('freq 200k injecao 8->1');
xlabel('Numero de pontos');
ylabel('Amplitude (real)');

legend('eletrodo 2 - eletrodo 1','eletrodo 3 - eletrodo 1','eletrodo 4 - eletrodo 1'
,'eletrodo 5 - eletrodo 1','eletrodo 6 - eletrodo 1','eletrodo 7 - eletrodo 1'
,'eletrodo 8 - eletrodo 1');

saveas (hf, "resultado.jpeg");

