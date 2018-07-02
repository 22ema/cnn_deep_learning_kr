function images= load_image(filename)

fp=fopen(filename,'rb');%%%���� �����ͷ� �о�´�
assert(fp~=-1, ('could not open'));%%���о� ������

magic=fread(fp,1,'int32',0,'ieee-be');%%fp ������ ù��° ������ �о����?
assert(magic ==2051,('error'));%% magic�� 2051 �� �ƴ� ���

numimages=fread(fp,1,'int32',0,'ieee-be');%%fp ���Ͽ��� �̹��� ���� ������ ��������

imrow=fread(fp,1,'int32',0,'ieee-be');%%�̹��� ���� ������
imcol=fread(fp,1,'int32',0,'ieee-be');%%�̹��� ���� ������

images=fread(fp,inf,'unsigned char=>unsigned char');%%???�߸𸣰���
images=reshape(images,imrow,imcol,numimages);%% ������ ��� �� �׸��� ������ ���ڷ� ����
images=permute(images,[2 1 3]);%% ����� ���� ��Ű��

fclose(fp);%% ������ �ݴ´�


images = reshape(images, size(images, 1) * size(images, 2), size(images, 3));%% �̹������� ��� ���� �����ش�.

images = double(images) / 255;%%���� ������ ���� 0~1������ �����ͷ� ��ȯ��Ų��.
end








