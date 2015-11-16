function movement=analyseMovement(last, current)

movement.rotation=abs(current.bottom/current.top-last.bottom/last.bottom)+abs(current.height-last.height);
movement.translation=abs(current.center-last.center);
movement.scale=(current.bottom+current.top+current.height)/(last.bottom+last.top+last.height);
end