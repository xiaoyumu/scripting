How to use
===

Download Latest rancher images

```sh
curl -L \
    https://github.com/rancher/rancher/releases/download/v2.3.3/rancher-images.txt \
    -o rancher-images.txt
  ```

Download this script
```
curl -L \
    https://raw.githubusercontent.com/xiaoyumu/scripting/master/rancher/transfer-images.sh \
    -o transfer-images.sh
```
如果出现不能连接raw.githubusercontent.com 可以添加socket或者https代理
curl -L https://raw.githubusercontent.com/xiaoyumu/scripting/master/rancher/transfer-images.sh -o transfer-images.sh --socks5 192.168.1.99:1080

下载成功后为  transfer-images.sh 添加可执行权限
chmod +x  transfer-images.sh

执行脚本导入rancher 相关的镜像，在执行之前确保 docker 已经登陆了本地私有仓库 hub.fshome.net
如果没有登录，可以先执行 docker login hub.fshome.net 命令登录.
./transfer-images.sh rancher-images.txt hub.fshome.net