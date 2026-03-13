# Docker Cheatsheet

## 컨테이너

```bash
docker ps                          # 실행 중
docker ps -a                       # 전체
docker run -d --name my -p 8080:80 nginx
docker exec -it <container> bash   # 접속
docker logs -f <container>         # 로그 follow
docker stop $(docker ps -q)        # 전부 중지
docker rm $(docker ps -aq)         # 전부 삭제
```

## 이미지

```bash
docker images
docker build -t myapp:latest .
docker rmi <image>
docker image prune -a              # 안 쓰는 이미지 정리
```

## Docker Compose

```bash
docker compose up -d               # 백그라운드 실행
docker compose down                # 중지 + 삭제
docker compose down -v             # 볼륨까지 삭제
docker compose logs -f <service>   # 특정 서비스 로그
docker compose exec <service> bash # 접속
docker compose ps                  # 상태 확인
```

## 볼륨 & 네트워크

```bash
docker volume ls
docker volume prune                # 안 쓰는 볼륨 정리
docker network ls
docker network inspect <network>
```

## 디스크 정리

```bash
docker system df                   # 사용량 확인
docker system prune -a --volumes   # 전체 정리 (주의!)
```
