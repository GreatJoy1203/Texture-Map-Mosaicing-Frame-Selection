% author: Jiyang Gao, from Tsinghua University,8/28/2014
% [x1 y1] [x2 y2] [x3 y3] are the vertexes' coordinates of the triangle
% [x y] is the coordinate of the detecting point.
% determine if the point is inside the triangle
function inTriangle=pointInTriangle(x1, y1, x2, y2, x3, y3, x, y)

  denominator = ((y2 - y3)*(x1 - x3) + (x3 - x2)*(y1 - y3));
  a = ((y2 - y3)*(x - x3) + (x3 - x2)*(y - y3)) / denominator;
  b = ((y3 - y1)*(x - x3) + (x1 - x3)*(y - y3)) / denominator;
  c = 1 - a - b;
 
 inTriangle= 0<= a && a <= 1 && 0 <= b && b <= 1 && 0 <= c && c <= 1;
end
