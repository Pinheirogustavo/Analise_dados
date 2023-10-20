#Octave 7.1.0
#Autor: Gustavo Pinheiro

%%%%%%%%%%%%%%%%%%%%%%%%%%%% Descricao do codigo %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%{
xxxxxxxx
%}

#pre-defifinicoes do octave
clear all; more off;clc; close all; %limpa o ambiente de trabalho
#clearvars -except A; close all; ##### apaga todas as variaveis, menos a tabela A

#pkg load control; pkg load signal;  %carrega pacotes
 pkg load io;  %carrega pacotes

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Dados %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

A = xlsread('Grafico_Defesa.xlsx');                %abre o arquivo de dados txt
dimenA = size(A);




frq = [1:4]; # 50k 100k 125k 200k

#grafico 1

for t = 1:1:length(frq)
    X_1(1,t) = mean( A(t,1:dimenA(2)));
    X_1(2,t) = std( A(t,1:dimenA(2)));
end
X_1 = flip(X_1,2);

figure(1);
w=errorbar(frq,X_1(1,:),X_1(2,:),"-**");
set(w,'color','r','linewidth',2);
xticks([1 2 3 4])
xticklabels({'50','100','125','200'})

title('Erro relativo na injeção de corrente entre os eletrodos 4 e 5');
xlabel('frequência (kHz)');
ylabel('Erro relativo (%)');
ylim([-2 22])


#grafico 2

for t = 1:1:length(frq)
    X_2(1,t) = mean( A(7+t,1:dimenA(2)));
    X_2(2,t) = std( A(7+t,1:dimenA(2)));
end
X_2 = flip(X_2,2);

figure(2);
y=errorbar(frq,X_2(1,:),X_2(2,:),"-*");
set(y,'color','r','linewidth',2);
xticks([1 2 3 4])
xticklabels({'50','100','125','200'})

title('Erro relativo na injeção de corrente entre os eletrodos 5 e 6');
xlabel('frequência (kHz)');
ylabel('Erro relativo (%)');

#grafico 3

for t = 1:1:length(frq)
    X_3(1,t) = mean( A(14+t,1:dimenA(2)));
    X_3(2,t) = std( A(14+t,1:dimenA(2)));
end
X_3 = flip(X_3,2);

figure(3);
z=errorbar(frq,X_3(1,:),X_3(2,:),"-*");
set(z,'color','r','linewidth',2);
xticks([1 2 3 4])
xticklabels({'50','100','125','200'})

title('Erro relativo na injeção de corrente entre os eletrodos 7 e 8');
xlabel('frequência (kHz)');
ylabel('Erro relativo (%)');




%{


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

    F(i,s) = mean( A(r:r+100,j)  );
    F(i,s+1) = std( A(r:r+100,j) );
#parte real
#FreqX numero_pontosY injecao 8-1;1-2;2-3...

    F(i,s+2) = mean( A(r:r+100,j+1)  );
    F(i,s+3) = std( A(r:r+100,j+1)  );
#parte imaginaria
#FreqX numero_pontosY injecao 8-1;1-2;2-3...

    i = i+1;
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

y1 = F(9 , a:5:c-5);    # media eletrodo 1
error1 = F(9 , b:5:c-5);

y2 = F(11 , a:5:c-5);    # media eletrodo 3
error2 = F(11 , b:5:c-5);

y3 = F(12 , a:5:c-5);    # media eletrodo 4
error3 = F(12 , b:5:c-5);

y4 = F(13 , a:5:c-5);    # media eletrodo 5
error4 = F(13,b:5:c-5);

y5 = F(14 , a:5:c-5);    # media eletrodo 6
error5 = F(14 , b:5:c-5);

y6 = F(15 , a:5:c-5);    # media eletrodo 7
error6 = F(15 , b:5:c-5);

y7 = F(16 , a:5:c-5);    # media eletrodo 8
error7 = F(16 , b:5:c-5);

y0 = F(10 , a:5:c-5);    # media eletrodo 2
error0 = F(10 , b:5:c-5);

a = c+1;
b = a+1;

w=errorbar(x_200k(1:8),y1,error1,'o');
set(w,'color','r','linewidth',1);

hold on;

w=errorbar(x_200k(1:8),y0,error0,'o');
set(w,'color','#6116ED','linewidth',1);

w=errorbar(x_200k(1:8),y2,error2,'o');
set(w,'color','#ED9816','linewidth',1);

w=errorbar(x_200k(1:8),y3,error3,'o');
set(w,'color','g','linewidth',1);

w=errorbar(x_200k(1:8),y4,error4,'o');
set(w,'color','#ED16A2','linewidth',1);

w=errorbar(x_200k(1:8),y5,error5,'o');
set(w,'color','b','linewidth',1);

w=errorbar(x_200k(1:8),y6,error6,'o');
set(w,'color','k','linewidth',1);

w=errorbar(x_200k(1:8),y7,error7,'o');
set(w,'color','#EDE316','linewidth',1);




hold off;

title('Frequência 200 kHz - Injeção de corrente de eletrodo 1 para eletrodo 2');
xlabel('Numero de pontos');
ylabel('Amplitude (mV)');

legend('eletrodo 1','eletrodo 2','eletrodo 3 ','eletrodo 4 '
,'eletrodo 5','eletrodo 6 ','eletrodo 7 '
,'eletrodo 8 ','location', 'northeastoutside');

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

y0 = F(10 , a:5:c);    # media eletrodo 2
error0 = F(10 , b:5:c);

a = c+1;
b = a+1;

w=errorbar(x_125k,y1,error1,'o');
set(w,'color','r','linewidth',1);

hold on;

w=errorbar(x_125k,y0,error0,'o');
set(w,'color','#6116ED','linewidth',1);

w=errorbar(x_125k,y2,error2,'o');
set(w,'color','#ED9816','linewidth',1);
w=errorbar(x_125k,y3,error3,'o');
set(w,'color','g','linewidth',1);
w=errorbar(x_125k,y4,error4,'o');
set(w,'color','#ED16A2','linewidth',1);
w=errorbar(x_125k,y5,error5,'o');
set(w,'color','b','linewidth',1);
w=errorbar(x_125k,y6,error6,'o');
set(w,'color','k','linewidth',1);
w=errorbar(x_125k,y7,error7,'o');
set(w,'color','#EDE316','linewidth',1);



hold off;

title('Frequência 125 kHz - Injeção de corrente de eletrodo 1 para eletrodo 2');
xlabel('Numero de pontos');
ylabel('Amplitude (mV)');

legend('eletrodo 1','eletrodo 2','eletrodo 3 ','eletrodo 4 '
,'eletrodo 5','eletrodo 6 ','eletrodo 7 '
,'eletrodo 8 ','location', 'northeastoutside');

saveas (hf2, "resultado_freq125_padrao_1_2.jpeg");
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hf3 = figure(3);

#padrao de injecao 1->2
#frequencia fixa 100k

x_100k = [12 18 24 30 36 42 48 54 60 72 102]; #numero de pontos coletados

t = length(x_100k);
c = c+5*t;

y1 = F(9 , a:5:c-5);    # media eletrodo 2-1
error1 = F(9 , b:5:c-5);

y2 = F(11 , a:5:c-5);    # media eletrodo 3-1
error2 = F(11 , b:5:c-5);

y3 = F(12 , a:5:c-5);    # media eletrodo 4-1
error3 = F(12 , b:5:c-5);

y4 = F(13 , a:5:c-5);    # media eletrodo 5-1
error4 = F(13,b:5:c-5);

y5 = F(14 , a:5:c-5);    # media eletrodo 6-1
error5 = F(14 , b:5:c-5);

y6 = F(15 , a:5:c-5);    # media eletrodo 7-1
error6 = F(15 , b:5:c-5);

y7 = F(16 , a:5:c-5);    # media eletrodo 8-1
error7 = F(16 , b:5:c-5);

y0 = F(10 , a:5:c-5);    # media eletrodo 2
error0 = F(10 , b:5:c-5);

a = c+1;
b = a+1;

w=errorbar(x_100k(1:10),y1,error1,'o');
set(w,'color','r','linewidth',1);
hold on;

w=errorbar(x_100k(1:10),y0,error0,'o');
set(w,'color','#6116ED','linewidth',1);

w=errorbar(x_100k(1:10),y2,error2,'o');
set(w,'color','#ED9816','linewidth',1);
w=errorbar(x_100k(1:10),y3,error3,'o');
set(w,'color','g','linewidth',1);
w=errorbar(x_100k(1:10),y4,error4,'o');
set(w,'color','#ED16A2','linewidth',1);
w=errorbar(x_100k(1:10),y5,error5,'o');
set(w,'color','b','linewidth',1);
w=errorbar(x_100k(1:10),y6,error6,'o');
set(w,'color','k','linewidth',1);
w=errorbar(x_100k(1:10),y7,error7,'o');
set(w,'color','#EDE316','linewidth',1);


hold off;

title('Frequência 100 kHz - Injeção de corrente de eletrodo 1 para eletrodo 2');
xlabel('Numero de pontos');
ylabel('Amplitude (mV)');

legend('eletrodo 1','eletrodo 2','eletrodo 3 ','eletrodo 4 '
,'eletrodo 5','eletrodo 6 ','eletrodo 7 '
,'eletrodo 8 ','location', 'northeastoutside');

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

y0 = F(10 , a:5:c);    # media eletrodo 2
error0 = F(10 , b:5:c);

a = c+1;
b = a+1;

w=errorbar(x_50k,y1,error1,'o');
set(w,'color','r','linewidth',1);
hold on;

w=errorbar(x_50k,y0,error0,'o');
set(w,'color','#6116ED','linewidth',1);

w=errorbar(x_50k,y2,error2,'o');
set(w,'color','#ED9816','linewidth',1);
w=errorbar(x_50k,y3,error3,'o');
set(w,'color','g','linewidth',1);
w=errorbar(x_50k,y4,error4,'o');
set(w,'color','#ED16A2','linewidth',1);
w=errorbar(x_50k,y5,error5,'o');
set(w,'color','b','linewidth',1);
w=errorbar(x_50k,y6,error6,'o');
set(w,'color','k','linewidth',1);
w=errorbar(x_50k,y7,error7,'o');
set(w,'color','#EDE316','linewidth',1);


hold off;

title('Frequência 50 kHz - Injeção de corrente de eletrodo 1 para eletrodo 2');
xlabel('Numero de pontos');
ylabel('Amplitude (mV)');

legend('eletrodo 1','eletrodo 2','eletrodo 3 ','eletrodo 4 '
,'eletrodo 5','eletrodo 6 ','eletrodo 7 '
,'eletrodo 8 ','location', 'northeastoutside');

saveas (hf4, "resultado_freq50_padrao_1_2.jpeg");
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





%}
