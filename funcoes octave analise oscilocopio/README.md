# Conjunto de funções implementadas em Octave para análise de dados obtidos por osciloscópio

As funções aqui apresentadas servem para uma visualização geral dos dados obtidos e para análise espectral desses sinais.

Descrições e modos de chamá-las podem ser consultados com o comando help'nome_da_função'.

## abre_dados.m

Em geral os dados gravados em .csv a partir de osciloscópios de n canais são salvos no seguinte formado:

![Arquivo cvs - osciloscópio](xx)

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

![help abre_dados](xx)
