function label=load_label(filename)

fp=fopen(filename,'rb');%%2진수의 데이터 파일로 불러오기
assert(fp~=-1,('could not'));%%에러 체크

magic = fread(fp,1,'int32',0,'ieee-be');%%파일의 첫번째 데이터 불러오기
assert(magic==2049,('error'));%2049가 아니면 error

numlabel=fread(fp,1,'int32',0,'ieee-be');%%파일내 라벨의 갯수 불러오기

label=fread(fp,inf,'unsigned char');%%파일안의 정보 불러오기
assert(size(label,1) == numlabel, 'Mismatch in label count');%파일의 라벨의 개수와 numlabel이 맞지않으면 미스 매칭


fclose(fp);%%파일 닫기.
end