#!/bin/bash

SendWeChat()
{
    cropID='ww5b973efd9f0fe24s'
    cropSecret='CaPSgXCgJdz9-VR9KOplcJLzOndNDWFhInLKZzoJY8d'
    url="https://qyapi.weixin.qq.com/cgi-bin/gettoken?corpid=$cropID&corpsecret=$cropSecret"
    token=$(/usr/bin/curl -s -G $url | awk -F\" '{print $10}')
    
    pUrl="https://qyapi.weixin.qq.com/cgi-bin/message/send?access_token=$token"
    toUser='GaoFeng'
    agentID=1000002

    curTime=$(date "+%Y-%m-%d__%H:%M:%S")
    SSH_addr='123.57.215.212'

    /usr/bin/curl --data-ascii '{"touser": "'${toUser}'", "msgtype": "text", "agentid":"'${agentID}'", "safe":"0", "text": {
        "content": "当前时间: '${curTime}'\n远程IP: '${SSH_addr}'\n磁盘负载超过85%"
    }}' $pUrl
}



for d in `df -P | grep /dev | awk '{print $5}' | sed 's/%//g'`
do
    if [ $d -gt 85 ]; then
        SendWeChat;
        exit 0;
    fi
done