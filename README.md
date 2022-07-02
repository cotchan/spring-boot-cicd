## spring-boot-cicd

- spring-boot 무중단배포 with `git-action` & `S3` & `CodeDeploy`

---

### 목차

1. [변경이력](#변경이력)
2. [ISSUE](#issue)

### 변경이력

- v1: 도커없이 `git-action` & `S3` & `CodeDeploy` 조합으로 무중단 배포
- v2: `v1`  + `stop.sh` 추가하여 nginx가 안바라보는 서비스는 중단하는 로직 추가
- v3: `v2` + 서비스 배포 방법으로 `도커 적용` 
- v4: `도커 컴포즈` + `deploy.sh`로 무중단 배포

---

### ISSUE

- nginx `nginx.conf` 설정
  - `server_name` 속성에 IP 주소나 도메인 네임을 넣어줘야함

```conf
http {
        
        //...
        
        include /etc/nginx/conf.d/*.conf;
        include /etc/nginx/sites-enabled/*;

        server {
            include /home/ubuntu/service_url.inc;
            listen 80;
            server_name {YOUR_DOMAIN_NAME_OR_IP_ADDRESS};
            location / {
                proxy_pass $service_url;
            }
        }
}
```

- nginx `*.inc` 설정
  - 아래 같이 설정함으로써 `frontend`, `backend` 모듈이 별도로 경로를 정의할 수 있을듯

```conf
http {
        
        //...

        include /etc/nginx/conf.d/*.conf;
        include /etc/nginx/sites-enabled/*;

        server {
            include /etc/nginx/conf.d/*.inc;
            listen 80;
            server_name {YOUR_DOMAIN_NAME_OR_IP_ADDRESS};
            location / {
                proxy_pass $service_url;
            }
        }
}
```

---

- 참고
  - [Github Actions + CodeDeploy + Nginx 로 무중단 배포하기 (1)](https://wbluke.tistory.com/39)
  - [Github Actions + CodeDeploy + Nginx 로 무중단 배포하기 (2)](https://wbluke.tistory.com/40)
  - [Github Actions + CodeDeploy + Nginx 로 무중단 배포하기 (3)](https://wbluke.tistory.com/41)
  - [[AWS] Spring Boot,Travis CI, CodeDeploy, Nginx로 무중단 배포하기](https://devlog-wjdrbs96.tistory.com/309)
  - [[AWS] Spring Boot, Nginx, Docker 로 무중단 배포하기 - 1탄](https://devlog-wjdrbs96.tistory.com/316)
  - [[AWS] Spring, Nginx, Docker로 무중단 배포하기 - 2탄](https://devlog-wjdrbs96.tistory.com/317)
  - [docker-compose 무중단 배포 1편 (blue, green)](https://jay-ji.tistory.com/m/99)
  - [spring boot, docker, docker-copmpose, nginx 이용해서 무중단 배포하기](https://kukekyakya.tistory.com/entry/spring-boot-docker-docker-compose-nginx-%EC%9D%B4%EC%9A%A9%ED%95%B4%EC%84%9C-%EB%AC%B4%EC%A4%91%EB%8B%A8-%EB%B0%B0%ED%8F%AC%ED%95%98%EA%B8%B0)
  - [[Docker] Docker Compose 프로젝트 무중단 배포](https://ozofweird.tistory.com/entry/Docker-Docker-Compose-%ED%94%84%EB%A1%9C%EC%A0%9D%ED%8A%B8-%EB%AC%B4%EC%A4%91%EB%8B%A8-%EB%B0%B0%ED%8F%AC)
  - [21.11.06 TIL](https://rockintuna.tistory.com/228)