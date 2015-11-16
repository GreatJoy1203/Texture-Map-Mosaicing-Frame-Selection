% author: Jiyang Gao, from Tsinghua University,8/28/2014
% if the point is inside the quadrangle
function inQuadrangle=pointInQuadrangle(source_quadrangle, x, y)
x1=source_quadrangle(1,1);
y1=source_quadrangle(1,2);
x2=source_quadrangle(2,1);
y2=source_quadrangle(2,2);
x3=source_quadrangle(3,1);
y3=source_quadrangle(3,2);
x4=source_quadrangle(4,1);
y4=source_quadrangle(4,2);
 inQuadrangle=pointInTriangle(x1, y1, x2, y2,x3, y3,x,y)||pointInTriangle(x2, y2, x3, y3, x4, y4,x,y);
end