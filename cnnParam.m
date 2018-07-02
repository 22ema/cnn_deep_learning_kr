function [theta, meta]=cnnParam(cnnConfig)

numlayer=size(cnnConfig.layer,2);%cnnConfig.layer 2��° ������ ���� ���
theta=cell(numlayer,1);%% �� cell�� numlayer,1�� ������.
numParam=zeros(numlayer,2);%%0�� �迭 �� numlayer,2�� ũ��� ������.
meta.layersize=cell(numlayer,1); %% ��Ÿ�Լ��ȿ� cell�� �����.
meta.paramsize=cell(numlayer,1);

for i=1:numlayer
    templayer=cnnConfig.layer{i};%%cnnConfig.layer�� ������ 1������ 7������ �ݺ�
    
    switch templayer.type%%Ÿ���������� switch������ 
        case 'input'%%input �϶�
            theta{i}.W=[];%%theta�迭 1���ٰ� ����ġ�߰�
            theta{i}.b=[];%%theta�迭 1���ٰ� ���̾ �߰�
            row=templayer.dimension(1);%%dimension �迭�� 1�� 28
            col=templayer.dimension(2);%%dimension �迭�� 2�� 28
            channel=templayer.dimension(3);%%dimension �迭�� 3��  1
            meta.layersize{i}=[row col channel];%meta.layersize�ȿ� �迭 ����
        case 'conv'%%conv��
            row= row + 1 - templayer.filtdim(1);%%20
            col= col + 1 - templayer.filtdim(2);%%20
            meta.paramsize{i}=[templayer.filtdim channel templayer.filtnum];%%������ ũ���,ä�μ�,������ ���� �����Ѵ�.
            theta{i}.W=1e-2 * randn(meta.paramsize{i});%%����ġ�� �ʱⰪ����
            numParam(i,:)=[templayer.filtdim(1)*templayer.filtdim(2)*channel*templayer.filtnum templayer.filtnum];%%��簪���� ���Ѱ��� ������ ������ �迭�� �����.2���� �迭�� ����� ���ؼ�
            channel = templayer.filtnum;%%ä���� ������ �����̴�
            theta{i}.b=zeros(channel ,1 );%%���̳ʸ� �ʱ⼳��
            meta.layersize{i}=[row col channel];%%meta.layersize 2���ٰ� �� �� ä�μ��� �ִ´�.
        case 'pool'%%Ǯ�����̴�.
            theta{i}.W=[];%%����ġ �ֱ�
            theta{i}.b=[];%%���̾ �ֱ�
            row= int32(row/templayer.poolDim(1));%%2�� ����� ������ ��ȯ
            col=int32(col/templayer.poolDim(2));%%2�� ����� ������ ��ȯ
            meta.layersize{i}=[row col channel];%% ������� �����Ѵ�.
        case 'stack2line'%%vector �� ��ȯ ������������ �Ѱ��ֱ� ���ؼ�
            theta{i}.W=[];%%����ġ �ֱ�
            theta{i}.b=[];%%���̾ �ֱ�
            row=row*col*channel;%%���� ��� ���� ä���� ���Ѵ� ������ ���� ���������ٰ� �ֱ� ���ؼ�
            col=1;
            channel=1;
            dimension=row;
            meta.layersize{i}=dimension;%%���� �ִ´�. ���̾� ũ�� ���ϱ�
        case{'sigmoid','tanh','relu','softmax','softsign'}%% ��쿡 ���� ������ ���⼭�� relu�� softmax�� ����Ѵ�.
            meta.paramsize{i}=[templayer.dimension dimension];%% ������ dimension�� ����� dimension�� �����Ѵ�.
            r=sqrt(6) ./ sqrt(double(dimension)+templayer.dimension);%%demension�� ������ �������Ѱ��� 6�� ���������� ������.
            theta{i}.W=rand(templayer.dimension,dimension)*2.*r-r;%%����ġ�� ���� �ٲ۴�.
            numParam(i,:)=[templayer.dimension * dimension templayer.dimension];
            dimension = templayer.dimension;
            theta{i}.b=zeros(dimension, 1);%%���̾�ǰ��̴�.
            meta.layersize{i}=dimension;
    end
end
meta.numTotalParams = sum(sum(numParam));%%��� ����ġ�� ���Ѵ�.
meta.numParam=numParam;
meta.numlayer=numlayer;
theta=thetaChange(theta,meta,'stack2vec',cnnConfig);
end

