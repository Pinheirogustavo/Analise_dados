# Conjunto de funções implementadas em Octave para análise de dados obtidos por osciloscópio

As funções aqui apresentadas servem para uma visualização geral dos dados obtidos e para análise espectral desses sinais.

Descrições e modos de chamá-las podem ser consultados com o comando help'nome_da_função'.

## abre_dados.m

Em geral os dados gravados em .csv a partir de osciloscópios de n canais são salvos no seguinte formado:

![Arquivo cvs - osciloscópio](https://github.com/Pinheirogustavo/Analise_dados/blob/main/funcoes%20octave%20analise%20oscilocopio/prints/table_csv.png)

Ao chamar a função 'abre_dados' os seguintes parâmetros são retornados:

#### vetores
-dados_original: matriz com dados de tempos e tensoes adquiridas pelo osciloscopio;

-vetor_tempo: vetor coluna com os tempos adquiridos pelo osciloscopio;

-vetor_tempo_plot: vetor coluna com os tempos (em microssegundos)adquiridos pelo osciloscopio;

-vetor_tensao: vetor coluna com as tensoes adquiridas pelo osciloscopio;

-vetor_tensao_plot:vetor coluna com as tensoes (em milivolts) adquiridas pelo osciloscopio;

#### Variaveis
-Ts: periodo de amostragem;

-Fs: frequencia de amostragem;

-L: tamanho do vetor de tensoes;

-MinPeakHeight: tamanho minimo para o pico de frequencia (componente) ser detectado (2% tensao maxima);

-nome_arquivo: nome com o qual o arquivo de dados foi salvo.

### Tamanho mínimo do pico a ser detectado na fft

Na linha 57 é possível definir o tamanho mínimo para que uma banda obtida da fft seja considerada para detecção das componentes do sinal estudado. Esse tamanho é dado como porcentagem em relação ao tamanho do maior valor do sinal captado (default 2%).

    > 57 MinPeakHeight=(0.02*maximo(2)).*1000; %tamanho minimo para o pico de frequencia
                                                %(componente) ser detectado
                                                    %(2% tensao maxima)

#### saída do comando help

![help abre_dados](https://github.com/Pinheirogustavo/Analise_dados/blob/main/funcoes%20octave%20analise%20oscilocopio/prints/help_abre_dados.png)

## plot_dados.m

Esta função serve para obter uma visão geral dos dados capturados, imprimindo todos os canais no mesmo gráfico Amplitude(mV) X tempo(us) e salvando este em um arquivo pdf 'nome_do_arquivo_plot_dados_originais.pdf'

![graph plot_dados](https://github.com/Pinheirogustavo/Analise_dados/blob/main/funcoes%20octave%20analise%20oscilocopio/prints/gus_plot_dados_originais.png)


## plot_dados_fft.m

Esta função permite observar a FFT de cada canal obtido com o osciloscópio, onde é impresso o espectro do sinal e um arquivo pdf é gerado com o nome 'nome_do_arquivo_plot_fft.pdf'.

As componentes do sinal que são superiores ao mínimo definido na função 'abre_dados' são destacadas no gráfico gerado.

![graph plot_dados_fft](https://github.com/Pinheirogustavo/Analise_dados/blob/main/funcoes%20octave%20analise%20oscilocopio/prints/gus_plot_fft.png)

## plot_analise_grafica_completa

Essa função gera um gráfico que une o sinal em função do tempo (plot_dados.m), a fft e as componentes espectrais do sinal (plot_dados_fft.m). Gera um arquivo 'nome_do_arquivo_plot_analise_grafica_completa.pdf'.

![graph plot_analise_grafica_completa](https://github.com/Pinheirogustavo/Analise_dados/blob/main/funcoes%20octave%20analise%20oscilocopio/prints/gus_plot_analise_grafica_completa.png)


## plot_analise_grafica_sinal_e_fft

Função que sintetiza o sinal e suas componentes. Gera um gráfico apenas com a visualização do sinal original e as componentes espectrais presentes, gerando um arquivo de imagem 'nome_do_arquivo_plot_analise_grafica_sinal_e_fft.pdf'

![graph plot_analise_grafica_sinal_e_fft](https://github.com/Pinheirogustavo/Analise_dados/blob/main/funcoes%20octave%20analise%20oscilocopio/prints/gus_plot_analise_grafica_sinal_e_fft.png)


## sumariza_dados

Essa função retorna um sumário de parâmetros elétricos do sinal obtido por osciloscópio.

Ao chamar a função 'sumariza_dados' os seguintes parâmetros são retornados no prompt de comando:

- Tensao pico a pico (V);

- Amplitude do sinal(V);

- Tensao RMS(V);

- Tensao maxima(V);

- Tensao minima(V);

- Tensao media(V);

- Em relacao aos picos da fft considerados na analise (>2% tensao maxima):

    - Amplitude(V) e frequencia(kHz).

Também é gerado um arquivo de texto 'nome_do_arquivo_sumario.txt' com todos os dados exibidos no prompt de comando.

#### ATENÇÃO: O arquivo .txt gerado adiciona novos dados abaixo dos já existentes no arquivo .txt presente no mesmo diretorio.





![prompt sumariza_dados](https://github.com/Pinheirogustavo/Analise_dados/blob/main/funcoes%20octave%20analise%20oscilocopio/prints/xxx.png)


## sumariza_varios_dados

Essa função permite realizar a análise da função 'sumariza_dados' e salvar no mesmo arquivo de texto n canais de m sinais obtidos.

Exibe no prompt de comando os seguintes dados do canal desejado de cada dado:

 - Nome do dado analisado;

 - Canal analisado dentro do conjunto de dados considerado;

 - Tensao pico a pico (V);

 - Amplitude do sinal(V);

 - Tensao RMS(V);

 - Tensao maxima(V);

 - Tensao minima(V);

 - Tensao media(V).

 Gera um arquivo 'nome_do_arquivo_sumariza_varios_dados.txt' com todos os dados exibidos no prompt de comando.

#### ATENÇÃO: O arquivo .txt gerado adiciona novos dados abaixo dos ja existentes no arquivo .txt presente no mesmo diretorio.

![prompt sumariza_varios_dados](https://github.com/Pinheirogustavo/Analise_dados/blob/main/funcoes%20octave%20analise%20oscilocopio/prints/xxx.png)
