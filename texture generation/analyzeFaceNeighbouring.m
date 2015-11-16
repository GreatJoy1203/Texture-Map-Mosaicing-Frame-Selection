% author: Jiyang Gao, from Tsinghua University,8/28/2014
% analyze the nrighbourings of the face
function faces_neighbourings=analyzeFaceNeighbouring(faces)
    [length,d]=size(faces);
    right=zeros(length,3)-1;
    faces_neighbourings=[faces,right,right];
    for k=1:length
        count=0;
        for m=1:length           
            if(m~=k)
                [result,neighbouring]=have2CommonVertexes(faces(k,:),faces(m,:));
                if result==1 
                    faces_neighbourings(k,count+3+1)=neighbouring;
                    faces_neighbourings(k,count+3+3+1)=m;
                    count=count+1;
                end
            end
        end           
    end

end





