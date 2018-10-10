#!/usr/bin/python
# -*- coding: utf-8 -*-

def WriteData(sid, cid):
    template = "\
  class{1}_student{0}:\n \
    image: docker-mysql-ssh\n \
    ports:\n \
      - '9{1}{0}:22'\n \
      - '8{1}{0}:3306'\n \
    volumes:\n \
      - ./app:/app\n \
      - ./data{1}{0}:/var/lib/mysql\n \
      - ./var_log{1}{0}:/var/log\n \
    entrypoint: /app/docker_start.sh\n\n"
    with open("example.yml", "a+") as f:
        f.write(template.format(sid, cid))

def Handle(cid, ms):
    for i in range(1, int(ms)+1):
        i = str(i)
        if len(i) < 2:
            i = "0" + str(i)
        try:
            WriteData(i, cid)
            print("Successfully write student %s "%i)
        except Exception as e:
            print("Fail write student %s "%i, e, "\n")

if __name__ == "__main__":
    # docker-compose头信息
    with open("example.yml", "a+") as f:
        f.write("version: '3.1'\n\n\
services:\n\n")
    # 两个班级
    # (1, 38) 1:一班 38:38个人
    Handle(1, 5)
    Handle(2, 5)
