%lê as imagens escolhidas
img = imread('fabric.png');
img2 = imread('peppers.png');

%converte para tons de cinza
imgG = rgb2gray(img);
imgG2 = rgb2gray(img2);

%obtem o melhor valor de limiar pelo metodo de otsu
Timg = otsu(imgG);
img_limiarizada = imgG >= Timg;
Timg2 = otsu(imgG2);
img2_limiarizada = imgG2 >= Timg;

figure, imshow(img);
figure, imshow(img_limiarizada);

figure, imshow(img2);
figure, imshow(img2_limiarizada);

