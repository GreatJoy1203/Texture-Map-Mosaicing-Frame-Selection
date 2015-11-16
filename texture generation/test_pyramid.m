img1=imread('test.png');
img1= imresize(img1, [1025 1025]);
pyramid_img=impyramid(img1, 'reduce');
img2=impyramid(pyramid_img, 'expand');
img3=img1-img2;
imshow(img3);

