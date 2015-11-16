% author: Jiyang Gao, from Tsinghua University,8/28/2014
% write to .obj file
function writeOBJ(faces,vertexes,normals,uvmaps,output_filename)
fid=fopen(output_filename,'w');
fprintf(fid,'#OBJ file\n');
fprintf(fid,['mtllib ./', output_filename,'.mtl \n']);
fprintf(fid,'v %f %f %f\n',vertexes);
fprintf(fid,'vn %f %f %f\n',normals);
uvmaps(2,:)=1-uvmaps(2,:);
fprintf(fid,'vt %f %f\n',uvmaps);
%obj file: vertex index of face is 1-based.
faces_output=[faces(:,1),faces(:,1),faces(:,1),faces(:,2),faces(:,2),faces(:,2),faces(:,3),faces(:,3),faces(:,3)];
faces_output=faces_output+1;
fprintf(fid,'usemtl material_0 \n');
fprintf(fid,'f %d/%d/%d %d/%d/%d %d/%d/%d \n',faces_output');

fidmtl=fopen([output_filename,'.mtl'],'w');
fprintf(fidmtl,'newmtl material_0\n');
fprintf(fidmtl,'Ka 0.200000 0.200000 0.200000 \n');
fprintf(fidmtl,'Kd 1.000000 1.000000 1.000000 \n');
fprintf(fidmtl,'Ka 1.000000 1.000000 1.000000 \n');
fprintf(fidmtl,'Ka 1.000000 1.000000 1.000000 \n');
fprintf(fidmtl,'Tr 1.000000 \n');
fprintf(fidmtl,'illum 2 \n');
fprintf(fidmtl,'Ns 0.000000 \n');
fprintf(fidmtl,'map_Kd test.png \n');
fclose(fidmtl);
end