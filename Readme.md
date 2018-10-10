### 部署方法:
1. 运行自动创建`docker-compose.yml`的`python`文件：`python create_container.py`(文件需要修改)
2. 启动容器: `docker-compose up -d`
### tips:
1. 删除所有镜像：`docker rmi $(docker images -aq)`
2. 删除所有容器（不包括正在运行的容器）：`docker rm $(docker ps -aq)`
3. 删除所有容器（包括正在运行的容器）：`docker rm -f $(docker ps -aq)`
