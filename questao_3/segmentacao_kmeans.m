clc;
clear all;
close all;
tic;
%le imagem de entrada
img = imread('fabric.png');
figure ,subplot(3,4,1), imshow(img)
title('imagem de entrada');

cform = makecform('srgb2lab');
lab_img = applycform(img,cform);

ab = double(lab_img(:,:,2:3));
nrows = size(ab,1);
ncols = size(ab,2);
ab = reshape(ab,nrows*ncols,2);
nColors = 6;
[cluster_idx,cluster_center] = kmeans(ab,nColors,'distance','sqEuclidean','Replicates',16);

%rotula cada pixel com resultados
pixel_labels = reshape(cluster_idx,nrows,ncols);
subplot(3,4,2), imshow(pixel_labels,[]),
title('imagem rotulada pelo indice do agrupamento');

%cria uma imagem para cada cord da imagem de entrada
segmented_images = cell(1,3);
rgb_label = repmat(pixel_labels,[1 1 3]);

for k=1:nColors
    color = img;
    color(rgb_label ~=k) = 0;
    segmented_images{k} = color;
end

subplot(3,4,3), imshow(segmented_images{1}),title('objetos no agrupamento 1');
subplot(3,4,4), imshow(segmented_images{2}),title('objetos no agrupamento 2');
subplot(3,4,5), imshow(segmented_images{3}),title('objetos, no agrupamento 3');
subplot(3,4,6), imshow(segmented_images{4}),title('objetos no agrupamento 4');
subplot(3,4,7), imshow(segmented_images{5}),title('objetos no agrupamento 5');
subplot(3,4,8), imshow(segmented_images{6}),title('objetos no agrupamento 6');
%subplot(3,4,9), imshow(segmented_images{7}),title('objetos no agrupamento 7');
%subplot(3,4,10), imshow(segmented_images{8}),title('objetos no agrupamento 8');
%subplot(3,4,11), imshow(segmented_images{9}),title('objetos no agrupamento 9');
%subplot(3,4,12), imshow(segmented_images{10}),title('objetos no agrupamento 10');



