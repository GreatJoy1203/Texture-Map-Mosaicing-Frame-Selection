% author: Jiyang Gao, from Tsinghua University,8/28/2014
%x_img=(x,y) temporary for 1024*1024
function in=inFOV(x_img)
x=x_img(1);
y=x_img(2);
center_x=536;
center_y=602;
radius=326;
dis=sqrt((x-center_x)^2+(y-center_y)^2);
%if y>340&&y<850&&x>260&&x<790
if dis<radius
    in=1;
else
    in=0;
end

end