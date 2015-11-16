% author: Jiyang Gao, from Tsinghua University,8/28/2014
min=1;
index=-1;
for k=1:count
    u_avg=(common4point(k,1,1)+common4point(k,1,2)+common4point(k,1,3)+common4point(k,1,4))/4/texture_size;
    v_avg=(common4point(k,2,1)+common4point(k,2,2)+common4point(k,2,3)+common4point(k,2,4))/4/texture_size;
    distance=(u_avg-0.5)*(u_avg-0.5)+(v_avg-0.5)*(v_avg-0.5);
    distance=sqrt(distance);
    if(distance<min)
        min=distance;
        index=k;
    end
    center(k,:)=[u_avg,v_avg];
end

