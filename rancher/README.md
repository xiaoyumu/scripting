How to use
===

Download Latest rancher images

```shell
curl -L \
    https://github.com/rancher/rancher/releases/download/v2.3.3/rancher-images.txt \
    -o rancher-images.txt
  ```

Download this script

```shell
curl -L \
    https://raw.githubusercontent.com/xiaoyumu/scripting/master/rancher/transfer-images.sh \
    -o transfer-images.sh
```

In case of raw.githubusercontent.com cannot be connected for some reason, you can use socket or http(s) proxy by with following command  (Assume your socket5 proxy is located at 192.168.1.99:1080):

```shell
curl -L \
    https://raw.githubusercontent.com/xiaoyumu/scripting/master/rancher/transfer-images.sh \
    -o transfer-images.sh \
    --socks5 192.168.1.99:1080
```

Make the script executable:

```shell
chmod +x  transfer-images.sh
```

To transfer rancher images to your local registry (Assume your local registry is hub.fshome.net)
Make sure you have docker logged into the local registry, to push images.

```shell
./transfer-images.sh rancher-images.txt hub.fshome.net
```