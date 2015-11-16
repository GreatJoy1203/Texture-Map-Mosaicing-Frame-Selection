% author: Jiyang Gao, from Tsinghua University,8/28/2014
%read view infomation from .txt file
function views_info=readViewsInfo(filename)
fileId=fopen(filename);
pointNum=fscanf(fileId, '%d\n',1);
views_info=cell(1,pointNum);
for k=1:pointNum
    viewNum=fscanf(fileId, '%d',1);
    viewinfo= fscanf(fileId, '%f', [4,viewNum]);
    views_info{k}=viewinfo;
end

end