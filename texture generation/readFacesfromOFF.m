% author: Jiyang Gao, from Tsinghua University,8/28/2014
function [faces,vertexes]=readFacesfromOFF(filename)
 fileId=fopen(filename);
 str = fscanf(fileId, '%s\n',1);
 num = fscanf(fileId, '%d',3);

 vertexes= fscanf(fileId, '%f', [3,num(1)]);
 faces=fscanf(fileId, '%d', [4,num(2)]);
 faces=faces(2:4,:);
 faces=faces';
     
    % for k=1:num(2)
    %     faces(k,:)=sort(faces(k,:));
    % end
    % faces=sort(faces,1);
end