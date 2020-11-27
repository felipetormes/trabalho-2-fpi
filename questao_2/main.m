Img = imread('cameraman.tif');
quantizacao_c_kmeans(Img, 4);

% Como o tamanho do bloco é 3x3, necessário deixar a imagem com um tamanho
% multiplo de 3
Img = Img(1:255, 1:255);
quantizacao_c_kmeans(Img, 9);