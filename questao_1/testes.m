function first_Task()

img1 = imread('cameraman.tif');
img2 = imread('circuit.tif');
%%%%
img1_comp_1 = compressao(img1, 1);
img1_comp_2 = compressao(img1, 3);
img1_comp_3 = compressao(img1, 5);
img1_comp_4 = compressao(img1, 7);
img1_comp_5 = compressao(img1, 10);

img2_comp_1 = compressao(img2, 1);
img2_comp_2 = compressao(img2, 3);
img2_comp_3 = compressao(img2, 5);
img2_comp_4 = compressao(img2, 7);
img2_comp_5 = compressao(img2, 10);
%%%%
img1_desc_1 = descompressao(img1_comp_1);
img1_desc_2 = descompressao(img1_comp_2);
img1_desc_3 = descompressao(img1_comp_3);
img1_desc_4 = descompressao(img1_comp_4);
img1_desc_5 = descompressao(img1_comp_5);

img2_desc_1 = descompressao(img2_comp_1);
img2_desc_2 = descompressao(img2_comp_2);
img2_desc_3 = descompressao(img2_comp_3);
img2_desc_4 = descompressao(img2_comp_4);
img2_desc_5 = descompressao(img2_comp_5);
%%%%
psnr_img1_1 = PSNR(img1, img1_desc_1);
psnr_img1_2 = PSNR(img1, img1_desc_2);
psnr_img1_3 = PSNR(img1, img1_desc_3);
psnr_img1_4 = PSNR(img1, img1_desc_4);
psnr_img1_5 = PSNR(img1, img1_desc_5);

psnr_img2_1 = PSNR(img2, img2_desc_1);
psnr_img2_2 = PSNR(img2, img2_desc_2);
psnr_img2_3 = PSNR(img2, img2_desc_3);
psnr_img2_4 = PSNR(img2, img2_desc_4);
psnr_img2_5 = PSNR(img2, img2_desc_5);

%%%%

figure, subplot(1,2,1);
imshow(img1);

subplot(1,2,2);
imshow(img1_desc_1);
title([strcat('PSNR: ', num2str(psnr_img1_1)), 'Q: 1']);

%%%%
figure, subplot(1,2,1);
imshow(img1);

subplot(1,2,2);
imshow(img1_desc_2);
title([strcat('PSNR: ', num2str(psnr_img1_2)), 'Q: 3']);

%%%%
figure, subplot(1,2,1);
imshow(img1);

subplot(1,2,2);
imshow(img1_desc_3);
title([strcat('PSNR: ', num2str(psnr_img1_3)), 'Q: 5']);

%%%%
figure, subplot(1,2,1);
imshow(img1);

subplot(1,2,2);
imshow(img1_desc_4);
title([strcat('PSNR: ', num2str(psnr_img1_4)), 'Q: 7']);

%%%%
figure, subplot(1,2,1);
imshow(img1);

subplot(1,2,2);
imshow(img1_desc_5);
title([strcat('PSNR: ', num2str(psnr_img1_5)), 'Q: 10']);


figure, subplot(1,2,1);
imshow(img2);

subplot(1,2,2);
imshow(img2_desc_1);
title([strcat('PSNR: ', num2str(psnr_img2_1)), 'Q: 1']);

%%%%
figure, subplot(1,2,1);
imshow(img2);

subplot(1,2,2);
imshow(img2_desc_2);
title([strcat('PSNR: ', num2str(psnr_img2_2)), 'Q: 3']);

%%%%
figure, subplot(1,2,1);
imshow(img2);

subplot(1,2,2);
imshow(img2_desc_3);
title([strcat('PSNR: ', num2str(psnr_img2_3)), 'Q: 5']);

%%%%
figure, subplot(1,2,1);
imshow(img2);

subplot(1,2,2);
imshow(img2_desc_4);
title([strcat('PSNR: ', num2str(psnr_img2_4)), 'Q: 7']);

%%%%
figure, subplot(1,2,1);
imshow(img2);

subplot(1,2,2);
imshow(img2_desc_5);
title([strcat('PSNR: ', num2str(psnr_img2_5)), 'Q: 10']);

