Img = imread('cameraman.tif');
quantizacao_c_kmeans(Img, 4);

% Como o tamanho do bloco � 3x3, necess�rio deixar a imagem com um tamanho
% multiplo de 3
Img = Img(1:255, 1:255);
quantizacao_c_kmeans(Img, 9);