config=config_new();
numlayer = size(config.layer,2);
theta=cell(numlayer,1);
numParams = zeros(numlayer,2);

meta.layersize=cell(numlayer,1);
meta.paramsize=cell(numlayer,1);
theta{1}.W=[];
row = row + 1 - config.layer{2}.filtdim(1);
col=config.layer{1}.dimension(2);