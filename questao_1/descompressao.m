% -----------------------------------
% FUNÇÒES PRINCIPAIS DA DESCOMPRESSÃO
% -----------------------------------
function img = descompressao(acs)
% Pega o Quality Factor
q = acs.quality;
% Decodifica o DPCM
DPCM = DPCM_Decode(acs.DPCM);
img = [];
V = [];
% Para cada Bloco 8x8
for i = 1 : acs.size8X * acs.size8Y
    % Desfaz o zigzag
    m = zigzag_Undo(acs.ZigZag{1,i});
    m(1,1) = DPCM(1, i);
    % Desfaz a Quantização e depois o DCT
    V = [V, DCT_Undo(quantization_Undo(m, q))];
    if mod(i, acs.size8Y) == 0
        img = [img; V];
        V = [];
    end
end
% Desfaz a substração de 128 bits da imagem
img = img + 128;
% Cast para uint8 para ser printavel a imagem
img = uint8(img);
end
% -----------------------------------
% FUNÇÒES AUXILIARES DA DESCOMPRESSÃO
% -----------------------------------

function encoded = DPCM_Decode(source)

% Decodificando DPCM com predecessor linearmente
for i = 2 : size(source, 2)
    source(i) = source(i) - source(i-1);
end

encoded = source;
end

function I = zigzag_Undo(v)
% N of a NxN matrix.
N = sqrt(size(v, 2));
% Start zigzag going up.
mode = 1;
I = [];
for counter = 1 : N
    I = diagonal_Write(I, v, counter, 1, mode);
    v(1 : counter) = [];
    mode = mode * -1;
end
for counter = 2 : N
    I = diagonal_Write(I, v, N, counter, mode);
    v(1 : N - counter + 1) = [];
    mode = mode * -1;
end
end

function vector = diagonal_Read(I, lin, col, mode)
lenght = lin - col + 1;
if mode == -1
    i = col;
    j = lin;
else
    i = lin;
    j = col;
end
vector = [];
for k = 1 : lenght
    vector(end + 1) = I(i,j);
    i = i - 1*mode;
    j = j + 1*mode;
end
end

function I = diagonal_Write(I, vector, lin, col, mode)
N = size(I,1);
lenght = lin - col + 1;
if mode == -1
    i = col;
    j = lin;
else
    i = lin;
    j = col;
end
for k = 1 : lenght
    I(i,j) = vector(1);
    vector(1) = [];
    i = i - 1*mode;
    j = j + 1*mode;
end
end




function output = DCT_Undo(bloco)
N = size(bloco,1);
% Constantes para auxiliar nas equações
sqrtN = sqrt(N);
sqrt2 = sqrt(2);
n = 0:N-1;
C(1,n+1) = 1 / sqrtN;
% Operações inversas ao DCT
for x = 1:N-1
	C(x+1,n+1) = cos(pi*(2*n+1)*x/2/N) / sqrtN*sqrt2;
end
A = C';
output = A*bloco*C;
end

function imageOut = quantization_Undo(image, q)
% Matrix para quantizar
quantMatrix = [ 16 11 10 16 24 40 51 61; 
                12 12 14 19 26 58 60 55;
                14 13 16 24 40 57 69 56; 
                14 17 22 29 51 87 80 62;
                18 22 37 56 68 109 103 77;
                24 35 55 64 81 104 113 92;
                49 64 78 87 103 121 120 101;
                72 92 95 98 112 100 103 99];

% Utilizando o Q-Factor para multiplicar a matriz quantificadora
quantMatrix = quantMatrix .* q;
% Desquantificando a imagem
imageOut = image .*quantMatrix;
end



