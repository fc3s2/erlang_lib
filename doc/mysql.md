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
