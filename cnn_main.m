%% step0
rng(1);
cnnConfig=config_new();

[theta,meta] =cnnParam(cnnConfig);
%% mnist data load
images = load_image('\mnist_image\train-images-idx3-ubyte\train-images.idx3-ubyte');

d=cnnConfig.layer{1}.dimension;
images=reshape(images,d(1),d(2),d(3),[]);
labels=load_label('\mnist_image\train-labels-idx1-ubyte\train-labels.idx1-ubyte');
labels(labels==0)=10;