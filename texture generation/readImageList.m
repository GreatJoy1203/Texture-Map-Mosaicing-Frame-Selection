% author: Jiyang Gao, from Tsinghua University,8/28/2014
function imagelist=readImageList(filename)
fileId=fopen(filename);
imagelist = textscan(fileId, '%s');
end