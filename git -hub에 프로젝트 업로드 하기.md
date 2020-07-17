1,71,87,81,239,79
2,85,71,56,212,70
3,52,71,62,185,61
4,62,84,59,205,68
5,84,64,56,204,68
6,85,63,68,216,72
7,68,78,77,223,74
8,68,91,91,250,83
9,88,81,82,251,83
10,98,93,70,261,87
11,96,94,89,279,93
12,97,87,90,274,91
13,83,70,89,242,80
14,66,57,79,202,67
15,71,80,73,224,74
16,73,56,59,188,62
# git -hub에 프로젝트 업로드 하기

### 최초로 깃허브에 프로젝트 업로드 하기
1. git init : 현재 폴더를 깃허브에 올리기 위한 local repository로 생성
2. vi .gitignore

#### 생성된 local repository에 깃허브 접속 정보 추가

##### 공용 또는 여러사람이 사용하는 컴퓨터인 경우 폴더별로 사용자를 변경하고자 할 때
1. git config --local user.name juseonyoung
2. git config --local user.email ssyy0622@gmail.com
 
##### 혼자 사용하는 컴퓨터(집컴)
1. git config --global user.name juseonyoung
2. git config --global user.email ssyy0622@gmail.com
3. git config 를 global로 설정하게 되면 local repository 를 생성할 때마다 git config를
   실행하지 않아도 된다.

### remote repository 정보 추가
1. 깃허브 사이트에 접속하여 새로운 repository를 생성한다.
2. git remote add origin https://github.com/juseonyoung/Biz-506-2020-07_DBMS.git
   shift+insert 하여 remote repowitory 추가
3. 위 경로를 origin으로 사용하겠다. 

### 깃허브에 프로젝트 올릴 때, 올릴때마다 항상 실행해야 한다.
1. git add . : 현재 폴더, sub 폴더의 모든 파일을 local repositor(git폴더에 저장)y에 압축, 해쉬하여 저장하라
2. git commit -m "comment" : 지금 시점에 추가된 프로젝트를 comment라는 설명을 부가하여 remote에 
  							 올릴 준비를 하라
3. git push -u origin master : 마스터(local)에 저장된 프로젝트를 origin(remote)에 보내라 
4. git push : 최초에 push 할 때는 git push -u origin master라고 명령을 수행해야 하는데 
			  두번째 이후부터는 git push라고만 명령 내리면 된다. 

### 깃허브에 올려진 프로젝트를 학원 또는 집에서 공동 작업할 경우
1. 학원에서 코딩한 후 프로젝트를 add, commit, push하여 업로드 
2. 집에서 git clone 리모트주소 하여 다운로드실행
3. 집에서 프로젝트 코딩작업 후 git config 수행(이때는 처음 수행한 username, useremail과 같게 해야한다)
4. 집에서 git push -u origin master
5. 학원에 오면 제일먼저 git pull하여 집에서 작업한 것과 학원 프로젝트를 동기화!!
6. 학원에서 코딩 추가, 변경 한 후 반복작업
7. 혹시 깃허브 사이트에서 코드를 변경하거나, 어떤 작업을 수행했으면 반드시 로컬에서 git pull 수행하자
	이 과정을 무시하면 remote repository를 지우고 다시 만들어야 할 수도 있다.













