function cameraCentric
hAxes=173;
wpConvexHull=[0,225,225,0,0;0,0,200,200,0;0,0,0,0,0];
        numBoards=70;
        boardColorLookup = im2double(label2rgb(1:numBoards, 'lines','c','shuffle'));
        plotFixedCam;
                
        set(hAxes,'XAxisLocation','top','YAxisLocation',...
            'left','ZDir','reverse');
        
        for boardIdx = 1:numBoards
            
            rotationVec = cameraParameters.RotationVectors(boardIdx, :)';
            translationVec = cameraParameters.TranslationVectors(boardIdx, :)';
            
            RotationMat = vision.internal.calibration.rodriguesVectorToMatrix(rotationVec);
          
            worldBoardCoords = bsxfun(@plus, RotationMat * ...
                wpConvexHull, translationVec);

            color = squeeze(boardColorLookup(1,boardIdx,:))';

            % We are going to swap y and z coordinates because the 3-d plot
            % rotates around the MATLAB's z-axis by default. Thus the
            % camera can be displayed horizontally and the 3-d plot will
            % rotate conveniently around the newly defined vertical y-axis.
            xIdx = 1; yIdx = 3; zIdx = 2;
            
            wX = worldBoardCoords(xIdx,:);
            wY = worldBoardCoords(yIdx,:);
            wZ = worldBoardCoords(zIdx,:);

            h = patch(wX,wY,wZ, color, 'Parent', hAxes);
            
            if highlightIndex(boardIdx)
                set(h,'FaceColor',color,'FaceAlpha',highlightAlpha);
                set(h,'EdgeColor',color,'LineWidth',2.0);
            else
                set(h,'FaceColor',color,'FaceAlpha',normalAlpha);
                set(h,'EdgeColor',color,'LineWidth',1.0);                
            end
            
            % label each board
            ulCorner = translationVec - 0.3*[offset; offset; 0];
            text(ulCorner(xIdx),ulCorner(yIdx),ulCorner(zIdx),...
                num2str(boardIdx),'fontsize',14,'color',color, ...
                'Parent', hAxes);
        end;

        % label the figure
        xlabel(hAxes, addUnits('X'));
        ylabel(hAxes, addUnits('Z'));
        zlabel(hAxes, addUnits('Y'));
    end