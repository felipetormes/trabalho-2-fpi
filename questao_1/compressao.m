%------------------------------------- 
% Função principal da compressão
% ------------------------------------
function acs = compressao(img, quality)
% imagem para double
img = double(img);
img = img - 128;
% Número de blocos 8x8 na imagem
[acs.size8X, acs.size8Y] = getSizeOf8Blocks(img);
% Inicializa vetores DPCM e ZigZag
DPCM = [];
ZigZag = {};
for i = 1 : acs.size8X
    for j = 1 : acs.size8Y
        % Pega um Bloco 8x8
        tempMatrix = img(i*8 - 7 : i*8, j*8 - 7 : j*8);
        % DCT no bloco
        DCTMatrix = DCT(tempMatrix);
        % Quantiza o bloco
        QMatrix = quantizar(DCTMatrix, quality);
        DPCM(end + 1) = QMatrix(1,1);
        % ZigZag no bloco
        ZigZag{end + 1} = zigzag(QMatrix); 
    end
end

% DPCM no DC
DPCM = DPCM_Encode(DPCM);

% Guarda informações importantes
acs.DPCM = DPCM;
acs.ZigZag = ZigZag;
acs.quality = quality;

end


%------------------------------------- 
% Função auxiliares da compressão
% ------------------------------------

function [size8X, size8Y] = getSizeOf8Blocks(image)
% Calcula quantos blocos a imagem tem para serem criados
size8X = floor(size(image, 1)) / 8;
size8Y = floor(size(image, 2)) / 8;
end

function output = DCT(bloco)
output = zeros(8, 8);
% Constantes para facilitar as fórmulas
pi8 = pi/8;
sqrt1 = sqrt(1/8);
sqrt2 = sqrt(2/8);
for u = 0:7
   for v = 0:7
      totalSum = 0;
      for x = 0:7
         for y = 0:7
             % Somatorio da Formula do DCT-2
            totalSum = totalSum + cos( (pi8)*(x+1/2)*u) * cos( (pi8)*(y+1/2)*v) * bloco(x+1,y+1);
         end
      end
      % Hack para obedecer as condições
      if u==0
         alpha1 = sqrt1;
      else
         alpha1 = sqrt2;
      end
      if v==0
         alpha2 = sqrt1;
      else
         alpha2 = sqrt2;
      end
      % Final da formula do DCT com os alphas
      output(u+1,v+1) = alpha1 * alpha2 * totalSum;      
   end
end
end

function quantizedImage = quantizar(image, q)

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

% Quantificando a imagem
quantizedImage = round(image ./quantMatrix);
end

function v = zigzag(I)
% N of a NxN matrix.
N = size(I,1);
% Start zigzag going up.
mode = 1;
v = [];
    for counter = 1 : N
        v = addElements(v, diagonal_Read(I, counter, 1, mode));
        mode = mode * -1;
    end
    for counter = 2 : N
        v = addElements(v, diagonal_Read(I, N, counter, mode));
        mode = mode * -1;
    end
end

function v2 = addElements(v1, v3)

v2 = v1;
for i = 1 : size(v3, 2)
    v2(end + 1) = v3(i);
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

function encoded = DPCM_Encode(source)
sizeSource =  size(source, 2);
% Codificando DPCM com predecessor linearmente
for i = sizeSource : -1 : 2
    source(i) = source(i) + source(i-1);
end
encoded = source;
end
