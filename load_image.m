function images= load_image(filename)

fp=fopen(filename,'rb');%%%이진 데이터로 읽어온다
assert(fp~=-1, ('could not open'));%%못읽어 왔을때

magic=fread(fp,1,'int32',0,'ieee-be');%%fp 파일의 첫번째 데이터 읽어오기?
assert(magic ==2051,('error'));%% magic이 2051 이 아닐 경우

numimages=fread(fp,1,'int32',0,'ieee-be');%%fp 파일에서 이미지 개수 데이터 가져오기

imrow=fread(fp,1,'int32',0,'ieee-be');%%이미지 행의 데이터
imcol=fread(fp,1,'int32',0,'ieee-be');%%이미지 열의 데이터

images=fread(fp,inf,'unsigned char=>unsigned char');%%???잘모르겠음
images=reshape(images,imrow,imcol,numimages);%% 파일을 행과 열 그리고 파일의 숫자로 만듬
images=permute(images,[2 1 3]);%% 제대로 정렬 시키기

fclose(fp);%% 파일을 닫는다


images = reshape(images, size(images, 1) * size(images, 2), size(images, 3));%% 이미지에서 행과 열을 곱해준다.

images = double(images) / 255;%%안의 데이터 들을 0~1까지의 데이터로 변환시킨다.
end








