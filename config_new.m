function cnnConfig=config_new()
cnnConfig.layer{1}.type='input';%% ÀÔ·ÂÃþ
cnnConfig.layer{1}.dimension=[28 28 1];

cnnConfig.layer{2}.type='conv';%%ÄÜº¼·ç¼Ç Ãþ
cnnConfig.layer{2}.filtdim=[9 9];
cnnConfig.layer{2}.filtnum=20;
cnnConfig.layer{2}.nonLinear='relu';
cnnConfig.layer{2}.convMask=ones(1,20);

cnnConfig.layer{3}.type='pool';%%Ç®¸µÃþ
cnnConfig.layer{3}.poolDim=[2 2];
cnnConfig.layer{3}.pooltype='maxpool';

cnnConfig.layer{4}.type='stack2line';%%??

cnnConfig.layer{5}.type='relu';%%relu
cnnConfig.layer{5}.dimension=360;

cnnConfig.layer{6}.type='relu';
cnnConfig.layer{6}.dimension=60;

cnnConfig.layer{7}.type='softmax';
cnnConfig.layer{7}.dimension=10;

cnnConfig.costFunc='cross_entropy';
end