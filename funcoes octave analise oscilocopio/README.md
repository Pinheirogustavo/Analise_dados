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

![graph plot_dados_fft](https://github.com/Pinheirogustavo/Analise_dados/blob/main/funcoes%20octave%20analise%20oscilocopio/prints/gus_plot_fft.png)
