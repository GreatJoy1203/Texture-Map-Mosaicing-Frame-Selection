%=====================================================================
% File: selectFrames.m 
% Original code written by Jiyang Gao
% Last Revised: 07/22/2014 by Jiyang Gao
%===================================================================== 


function selection = selectFrames(imgseq,showresult,threshold)


    'LKTranker analysis'
    [M N imgNum] = size(imgseq);
    selection=zeros(1,imgNum);
    %threshold=8;
    maxPtsNum = 20;
    currentFrame=1;
    [Y1 X1] = corner_ST(imgseq(230:800,230:800,1),maxPtsNum);
    X1=X1+230;
    Y1=Y1+230;

    Xseq = zeros(length(X1),imgNum);
    Yseq = zeros(length(X1),imgNum);
    Xseq(:,1) = X1;
    Yseq(:,1) = Y1;

    for p = 2:imgNum
        p
        [Xseq(:,p) Yseq(:,p)] = LKTrackPyr(imgseq(:,:,p-1),imgseq(:,:,p),...
            Xseq(:,p-1),Yseq(:,p-1));
        delta_X=Xseq(:,p)-Xseq(:,currentFrame);
        delta_Y=Yseq(:,p)-Yseq(:,currentFrame);
        meandX=mean(delta_X);
        meandY=mean(delta_Y);
        distance=sqrt(meandX*meandX+meandY*meandY);
        if(distance>threshold)
            currentFrame=p;
            [Y1 X1] = corner_ST(imgseq(230:800,230:800,1),maxPtsNum);
            X1=X1+230;
            Y1=Y1+230;
            Xseq(:,p) = X1;
            Yseq(:,p) = Y1;
            selection(p)=1;
        else
            selection(p)=0;
        end
    end

	if showresult == 1
		figure,pause % show the points
		sc = min(M,N)/30; % scale of the line indicating the speed
		for p = 1:imgNum
			imshow(imgseq(:,:,p)),hold on
            title(sprintf('Frame %d',p));
			X2p = Xseq(:,p); Y2p = Yseq(:,p);
			plot(X2p,Y2p,'go');
			if p > 1&&selection(p)~=1 % draw speed lines when the frame is not selected
				plot([X2p,X2p+(X2p-X2pl)*sc]',...
					[Y2p,Y2p+(Y2p-Y2pl)*sc]','m-');
			end
			pause;
			X2pl = X2p; Y2pl = Y2p;
		end
	end


end