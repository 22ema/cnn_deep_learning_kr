function newTheta = thetaChange(oldTheta,meta,type,cnnConfig)

if ~exist('type','var')
    type = 'stack2vec';
end


switch type
    case 'stack2vec'
        new
        