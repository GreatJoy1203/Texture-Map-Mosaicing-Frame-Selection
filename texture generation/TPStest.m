
st = tpaps(vertexes(1:2,:),vertexes(3,:)); fnplt(st), hold on
avals = fnval(st,vertexes(1:2,:));
plot3(vertexes(1,:),vertexes(2,:),vertexes(3,:),'wo','markerfacecolor','k')
%quiver3(vertexes_t(1,:),vertexes_t(2,:),avals,zeros(1,nxy),zeros(1,nxy), ...
 %        noisyvals-avals,'r'), hold off