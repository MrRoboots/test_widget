var WebSocketServer = require('ws').Server,

wss = new WebSocketServer({ port: 7272 });
wss.on('connection', function (ws) {
    console.log('连接成功');
    ws.send('你是第' + wss.clients.length + '位');
    //收到消息回调
    ws.on('message', function (message) {
        console.log(message);
        ws.send('收到:'+message);
    });
    // 退出
    ws.on('close', function(close) {
        console.log('退出连接了');
        ws.send('退出连接');
    });
});
console.log('开始监听7272端口');