% author: Jiyang Gao, from Tsinghua University,8/28/2014
%calculate the difference of current texture and final texture
function diffsum=calculateDifference(texture_patch,texture_final)
[M,N]=size(texture_patch);
diffsum=0;
for m=1:M
    for n=1:N
        if texture_patch(m,n)~=0&&texture_final(m,n)~=0
            diff=texture_patch(m,n)-texture_final(m,n);
            diffsum=diffsum+diff;
        end
    end
end
end