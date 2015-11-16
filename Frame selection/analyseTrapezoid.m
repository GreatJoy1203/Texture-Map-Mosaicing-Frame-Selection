function attribute=analyseTrapezoid(vertexes)


%1 a-f,2 b-e,3 c-d
a=vertexes(1,:)-vertexes(2,:);
b=vertexes(1,:)-vertexes(3,:);
c=vertexes(1,:)-vertexes(4,:);
d=vertexes(2,:)-vertexes(3,:);
e=vertexes(2,:)-vertexes(4,:);
f=vertexes(3,:)-vertexes(4,:);
normala=a./norm(a);
normalb=b./norm(b);
normalc=c./norm(c);
normald=d./norm(d);
normale=e./norm(e);
normalf=f./norm(f);

parallel(1)=abs(dot(normala,normalf));
parallel(2)=abs(dot(normalb,normale));
parallel(3)=abs(dot(normalc,normald));
[value,index]=max(parallel);
attribute.center=sum(vertexes)./4;
if index==1
    attribute.top=min(norm(a),norm(f));
    attribute.bottom=max(norm(a),norm(f));
    attribute.height= abs(det([vertexes(4,:)-vertexes(3,:);vertexes(1,:)-vertexes(3,:)]))/norm(vertexes(4,:)-vertexes(3,:)); 
elseif index==2
    attribute.top=min(norm(b),norm(e));
    attribute.bottom=max(norm(b),norm(e));
    attribute.height= abs(det([vertexes(4,:)-vertexes(2,:);vertexes(1,:)-vertexes(2,:)]))/norm(vertexes(4,:)-vertexes(2,:)); 
else
    attribute.top=min(norm(c),norm(d));
    attribute.bottom=max(norm(c),norm(d));
    attribute.height= abs(det([vertexes(3,:)-vertexes(2,:);vertexes(1,:)-vertexes(2,:)]))/norm(vertexes(3,:)-vertexes(2,:)); 
end

end