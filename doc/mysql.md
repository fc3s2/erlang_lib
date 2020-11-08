mysql
修改密码
记得密码
    cmd mysql -u root -p  登入后修改
    set password for root@localhost = 'newpassword';
记不得密码
    pass

服务名无效
net stop mysql、net start mysql

原因是：因为net start +服务名，启动的是win下注册的服务。此时，系统中并没有注册mysql到服务中。即当前路径下没有mysql服务。
任务管理器 服务里面真正的 服务名 

乱码问题
字符集   校对集(排序规则)  乱码

乱码出现的原因 文字本来的字符集和展示的字符集不一致

 一般统一 UTF8 ;除非特别古老或者其他地区

客户端字符集 连接器字符集 可接受字符集

set names gbk;

 show variables like "%char%";

 客户端,GBK     ---提交--->  处理为utf8或者在存储的时候处理 ->DB, utf8