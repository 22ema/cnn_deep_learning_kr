function [theta, meta]=cnnParam(cnnConfig)

numlayer=size(cnnConfig.layer,2);%cnnConfig.layer 2번째 차원의 길이 출력
theta=cell(numlayer,1);%% 빈 cell을 numlayer,1로 만들어낸다.
numParam=zeros(numlayer,2);%%0인 배열 을 numlayer,2의 크기로 만들어낸다.
meta.layersize=cell(numlayer,1); %% 메타함수안에 cell을 만든다.
meta.paramsize=cell(numlayer,1);

for i=1:numlayer
    templayer=cnnConfig.layer{i};%%cnnConfig.layer의 각층을 1층부터 7층까지 반복
    
    switch templayer.type%%타입을나눈다 switch문으로 
        case 'input'%%input 일때
            theta{i}.W=[];%%theta배열 1에다가 가중치추가
            theta{i}.b=[];%%theta배열 1에다가 바이어스 추가
            row=templayer.dimension(1);%%dimension 배열의 1열 28
            col=templayer.dimension(2);%%dimension 배열의 2열 28
            channel=templayer.dimension(3);%%dimension 배열의 3열  1
            meta.layersize{i}=[row col channel];%meta.layersize안에 배열 삽입
        case 'conv'%%conv층
            row= row + 1 - templayer.filtdim(1);%%20
            col= col + 1 - templayer.filtdim(2);%%20
            meta.paramsize{i}=[templayer.filtdim channel templayer.filtnum];%%필터의 크기와,채널수,필터의 수를 저장한다.
            theta{i}.W=1e-2 * randn(meta.paramsize{i});%%가중치의 초기값설정
            numParam(i,:)=[templayer.filtdim(1)*templayer.filtdim(2)*channel*templayer.filtnum templayer.filtnum];%%모든값들을 곱한값과 필터의 개수로 배열을 만든다.2차원 배열을 만들기 위해서
            channel = templayer.filtnum;%%채널은 필터의 개수이다
            theta{i}.b=zeros(channel ,1 );%%바이너리 초기설정
            meta.layersize{i}=[row col channel];%%meta.layersize 2에다가 행 열 채널수를 넣는다.
        case 'pool'%%풀링층이다.
            theta{i}.W=[];%%가중치 넣기
            theta{i}.b=[];%%바이어스 넣기
            row= int32(row/templayer.poolDim(1));%%2로 나누어서 정수로 변환
            col=int32(col/templayer.poolDim(2));%%2로 나누어서 정수로 변환
            meta.layersize{i}=[row col channel];%% 행과열을 저장한다.
        case 'stack2line'%%vector 로 변환 완전연결층에 넘겨주기 위해서
            theta{i}.W=[];%%가중치 넣기
            theta{i}.b=[];%%바이어스 넣기
            row=row*col*channel;%%행을 행과 열과 채널을 곱한다 이유는 완전 연결층에다가 넣기 위해서
            col=1;
            channel=1;
            dimension=row;
            meta.layersize{i}=dimension;%%행을 넣는다. 레이어 크기 정하기
        case{'sigmoid','tanh','relu','softmax','softsign'}%% 경우에 따라 나뉜다 여기서는 relu와 softmax를 사용한다.
            meta.paramsize{i}=[templayer.dimension dimension];%% 이층의 dimension과 저장된 dimension을 저장한다.
            r=sqrt(6) ./ sqrt(double(dimension)+templayer.dimension);%%demension의 덧셈을 제곱근한것을 6의 제곱근으로 나눈다.
            theta{i}.W=rand(templayer.dimension,dimension)*2.*r-r;%%가중치의 값을 바꾼다.
            numParam(i,:)=[templayer.dimension * dimension templayer.dimension];
            dimension = templayer.dimension;
            theta{i}.b=zeros(dimension, 1);%%바이어스의값이다.
            meta.layersize{i}=dimension;
    end
end
meta.numTotalParams = sum(sum(numParam));%%모든 가중치를 더한다.
meta.numParam=numParam;
meta.numlayer=numlayer;
theta=thetaChange(theta,meta,'stack2vec',cnnConfig);
end

