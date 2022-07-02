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

---

- 참고
  - [Github Actions + CodeDeploy + Nginx 로 무중단 배포하기 (1)](https://wbluke.tistory.com/39)
  - [Github Actions + CodeDeploy + Nginx 로 무중단 배포하기 (2)](https://wbluke.tistory.com/40)
  - [Github Actions + CodeDeploy + Nginx 로 무중단 배포하기 (3)](https://wbluke.tistory.com/41)
  - [[AWS] Spring Boot,Travis CI, CodeDeploy, Nginx로 무중단 배포하기](https://devlog-wjdrbs96.tistory.com/309)
  - [[AWS] Spring Boot, Nginx, Docker 로 무중단 배포하기 - 1탄](https://devlog-wjdrbs96.tistory.com/316)
  - [[AWS] Spring, Nginx, Docker로 무중단 배포하기 - 2탄](https://devlog-wjdrbs96.tistory.com/317)