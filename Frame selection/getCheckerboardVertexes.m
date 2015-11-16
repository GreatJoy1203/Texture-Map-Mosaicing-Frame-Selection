function vertexes = getCheckerboardVertexes (imagePoints, boardSize)

vertexes=zeros(4,2);
vertexes(1,:)=imagePoints(1,:);
vertexes(2,:)=imagePoints(boardSize(1)-1,:);
vertexes(3,:)=imagePoints(length(imagePoints)-boardSize(1)+2,:);
vertexes(4,:)=imagePoints(length(imagePoints),:);



end