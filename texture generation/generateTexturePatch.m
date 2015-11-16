% author: Jiyang Gao, from Tsinghua University,8/28/2014
% do not use this one
function texture_patch=generateTexturePatch(img,source_quadrangle,target_quadrangle)
x1_3_4=source_quadrangle;
x2_3_4=target_quadrangle;
%x1_4_3=[368,184,1;389,387,1;512,268,1;493,418,1];
x1_4_3=transpose(x1_3_4);
%x2_4_3=[0,0,1;0,100,1;100,0,1;100,100,1];
x2_4_3=transpose(x2_3_4);
H=homography2d(x1_3_4,x2_3_4);
figure;
imshow(img);
hold on;
scatter(x1_4_3(1,2),x1_4_3(1,1));
scatter(x1_4_3(2,2),x1_4_3(2,1));
scatter(x1_4_3(3,2),x1_4_3(3,1));
scatter(x1_4_3(4,2),x1_4_3(4,1));

source_quadrangle=[x1_4_3(:,2),x1_4_3(:,1)];
texture_patch=transformImage(H,img,source_quadrangle);
figure;
imshow(texture_patch);
hold on;
scatter(x2_4_3(1,2),x2_4_3(1,1));
scatter(x2_4_3(2,2),x2_4_3(2,1));
scatter(x2_4_3(3,2),x2_4_3(3,1));
scatter(x2_4_3(4,2),x2_4_3(4,1));

end



