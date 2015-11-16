% author: Jiyang Gao, from Tsinghua University,8/28/2014
function [result,neighbouring]=have2CommonVertexes(tri_source,tri_target)
result=0;
neighbouring=-1;
count=0;
source_check=[0,0,0];
target_check=[0,0,0];
for s=1:3
    for t=1:3 
     if(tri_source(s)==tri_target(t))
         count=count+1;
         source_check(s)=1;
         target_check(t)=1;
     end
    end
end
if count==2
    result=1;
    for n=1:3
        if target_check(n)==0
            neighbouring=tri_target(n);
        end
    end     
end
