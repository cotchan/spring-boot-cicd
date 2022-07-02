## spring-boot-cicd

- spring-boot 무중단배포 with `git-action` & `S3` & `CodeDeploy`

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