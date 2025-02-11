# V Rising
------
## Synology Container
### 폴더 생성
docker 폴더 밑에 vrising/data, vrising/server 폴더를 생성한다. 해당 폴더들은 컨테이너에 마운트하기 위한 폴더이기 때문에 미리 생성해둔다. 

### 컨테이너 설정 프로세스 

/mnt/vrising/persistentdata
/mnt/vrising/server

### Network 설정
#### Static IP
Nas가 재부팅될 때 변동하는 IP라면 기존의 서버 IP도 변경되어 유저들이 불편을 겪게 된다. 이를 방지하기 위하여 고정 IP 세팅을 해주어야 한다. 만약 한번도 Nas를 끄지 않을 자신이 있다면 스킵해도 된다. 
##### DHCP Server
공유기에서 나스를 선택하고 원하는 IP주소와 MAC 주소를 입력해주면 된다.
##### Synology setting

#### Port Forwarding

## Game Setting
경로 : vrising/persistentdata/Settings
아래 파일을 편집하기 위해서는 컨테이너를 중지 후에 편집하길 권장한다. 
### adminlist.txt
- Steam64 ID를 삽입하여 어드민 권한 부여
### banlist.txt
- Steam64 ID를 삽입하여 서버 접근 금지

### ServerHostSettings.json 
- 네트워크 관련 환경 설정을 하는 파일
- Name : "",   
- Description : "",
- MaxConnectedUsers: 10,
- MaxConnectedAdmins: 1,
- SaveName : "",
- Password : "0123456789",
  - 제일 중요한 암호 설정하는 파라미터, 문자열로 넣어주면 된다.
### ServerGameSettings.json
- GameDifficulty : 0-캐주얼, 1-일반, 2-잔인

그 외 설정들은 [링크](https://gall.dcinside.com/mgallery/board/view/?id=vrising&no=5863)에서 원하는 값으로 찾아보고 바꿔주면 된다.

## Reference
- https://gall.dcinside.com/mgallery/board/view/?id=vrising&no=7221
- https://techtim.tistory.com/50
- https://svrforum.com/nas/1607783

- https://m.blog.naver.com/boshow/222292538297
- https://blog.naver.com/techbor/222883504298
이미지 임시
- https://velog.io/@hotmosit/Markdown-%EC%9D%B4%EB%AF%B8%EC%A7%80-%EC%B2%A8%EB%B6%80-%EB%B0%8F-%EC%A1%B0%EC%A0%95