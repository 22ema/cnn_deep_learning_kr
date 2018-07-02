function label=load_label(filename)

fp=fopen(filename,'rb');%%2������ ������ ���Ϸ� �ҷ�����
assert(fp~=-1,('could not'));%%���� üũ

magic = fread(fp,1,'int32',0,'ieee-be');%%������ ù��° ������ �ҷ�����
assert(magic==2049,('error'));%2049�� �ƴϸ� error

numlabel=fread(fp,1,'int32',0,'ieee-be');%%���ϳ� ���� ���� �ҷ�����

label=fread(fp,inf,'unsigned char');%%���Ͼ��� ���� �ҷ�����
assert(size(label,1) == numlabel, 'Mismatch in label count');%������ ���� ������ numlabel�� ���������� �̽� ��Ī


fclose(fp);%%���� �ݱ�.
end