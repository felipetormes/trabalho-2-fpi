function quantizacao_c_kmeans(Img, L)
tic;
K = 256; % tamanho do dicionário

% Leitura da imagem de entrada

Img2D_rows = size(Img, 1);
Img2D_cols = size(Img, 2);
figure, imshow(Img), title('Imagem de Entrada');

% Computa Kmeans para achar o dicionário
r1 = floor(rem(Img2D_rows, sqrt(L)));
r2 = floor(rem(Img2D_rows, sqrt(L)));
Img1 = zeros(Img2D_rows + r1, Img2D_cols + r2);

% Monta a imagem
Img1(1:Img2D_rows, 1:Img2D_cols) = Img;
if r1 ~= 0
    Pad_rows = Img(end, :);
    for j = 1:r1
        Pad_rows(j, :) = Pad_rows(1, :);
    end
    Img1(1:Img2D_rows, 1:Img2D_cols) = Img;
    Img1(Img2D_rows + 1:end, 1:Img2D_cols) = Pad_rows;
end
if r1 ~= 0 && r2 ~= 0
    Pad_cols = Img1(:, Img2D_cols);
    for j = 1:r2
        Pad_cols(:, j) = Pad_cols(:, 1);
    end
    Img1(1:end, Img2D_cols + 1:end) = Pad_cols;
elseif r2 ~= 0
    Pad_cols = Img(:, Img2D_cols);
    for j = 1:sqrt(L) - r2
        Pad_cols(:, j) = Pad_cols(:, 1);
    end
    Img1(1:Img2D_rows, 1:Img2D_cols) = Img;
    Img1(1:Img2D_rows, Img2D_cols + 1:end) = Pad_cols;
end

% prepara os dados e chama o algoritmo do kmeans 
l_re = kmeans_pre_post(Img1, L, K);

% mostra o resultado da quantização vetorial com o kmeans
% para a imagem de entrada
l_re = uint8(l_re);
figure, imshow(l_re);
title('imagem comprimida por quantizacao vetorial (kmeans)');

% mostra a area de memoria ocupada pelas imagens de entrada e saida
fprintf('tamanho da memoria da imagem de entrada = %d bytes\n', numel(Img));
fprintf('tamanho da memoria da imagem de saida = %d bytes\n', K * L +...
    numel(Img1) / L);

% mostra a taxa de compressão: bits entrada x bits saida
fprintf('taxa de compressão (bits de entrada x bits de saida): %.2f x %d\n',...
    double(numel(Img)) / double(K * L + numel(Img1) / L), 1);

% mostra o SNR e o PSNR
SNR = 10 * log10(std2(double(Img))^2 / std2(double(Img) - double(l_re))^2);
I_max = max(max(double(Img)));
I_min = min(min(double(Img)));
A = (I_max - I_min);
PSNR = 10 * log10((A^2) / (std2(double(Img) - double(l_re))^2));
fprintf('SNR = %.2f (dB)\n', SNR);
fprintf('PSNR = %.2f (dB)\n', PSNR);
toc;
end
