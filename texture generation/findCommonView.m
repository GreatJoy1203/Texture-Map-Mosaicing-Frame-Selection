% author: Jiyang Gao, from Tsinghua University,8/28/2014
function [index, pts,uvs]=findCommonView(v0,v1,v2,v3,views_info,uvmap,texture_size)
viewinfo0=views_info{v0};
viewinfo1=views_info{v1};
viewinfo2=views_info{v2};
viewinfo3=views_info{v3};

[M0,N0]=size(viewinfo0);
[M1,N1]=size(viewinfo1);
[M2,N2]=size(viewinfo2);
[M3,N3]=size(viewinfo3);
pts=ones(3,4);
 uvs=ones(3,4);
for n0=1:N0
    for n1=1:N1
        for n2=1:N2
            for n3=1:N3
                if viewinfo0(1,n0)==viewinfo1(1,n1)&&viewinfo1(1,n1)==viewinfo2(1,n2)&&viewinfo2(1,n2)==viewinfo3(1,n3)
                    index=viewinfo0(1,n0);
                    pts(1:2,1)=viewinfo0(3:4,n0);
                    pts(1:2,2)=viewinfo1(3:4,n1);
                    pts(1:2,3)=viewinfo2(3:4,n2);
                    pts(1:2,4)=viewinfo3(3:4,n3);
                    uvs(1:2,1)=uvmap(:,v0)*texture_size;
                    uvs(1:2,2)=uvmap(:,v1)*texture_size;
                    uvs(1:2,3)=uvmap(:,v2)*texture_size;
                    uvs(1:2,4)=uvmap(:,v3)*texture_size;
                    return;
                end
            end
        end
    end
end
index=-1;
end