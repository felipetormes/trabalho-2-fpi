% Imagem 900x600
Img_1 = imread('./b&w_1.jpg');
Img_1 = rgb2gray(Img_1);
quantizacao_c_kmeans(Img_1, 4);
quantizacao_c_kmeans(Img_1, 9);

% Imagem 800x800
Img_2 = imread('./b&w_2.jpg');
Img_2 = rgb2gray(Img_2);
quantizacao_c_kmeans(Img_2, 4);
% Como o tamanho do bloco eh 3x3, necessario deixar a imagem com um tamanho
% multiplo de 3
Img_2 = Img_2(1:798, 1:798);
quantizacao_c_kmeans(Img_2, 9);