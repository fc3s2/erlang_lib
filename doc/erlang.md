shell:strings(false) 
["⢡","✔","✓","⥬","⟣","✒","⟞","⟙","⢣","⟢","⥫","⟚","⢪","⢢"]
当成汉字了


Erlang shell 接入控制台

windows   werl       -detached 

方法1. JCL模式 Ctrl + G

erl -setcookie abc -name node_1@127.0.0.1 
设置相同的cookie 
erl -setcookie abc -name node_2@127.0.0.2 

Eshell V8.1  (abort with ^G)
(node_2@127.0.0.1)1> node().
'node_2@127.0.0.1'
(node_2@127.0.0.1)2> 
User switch command
 --> j
   1* {shell,start,[init]}
 --> r 'node_1@127.0.0.1' 
 --> j
   1  {shell,start,[init]}
   2* {'node_1@127.0.0.1',shell,start,[]}
 --> c 2
Eshell V8.1  (abort with ^G)
(node_1@127.0.0.1)1> 

方法2. -remsh

erl -setcookie abc -name node_3@127.0.0.3 -remsh node_1@127.0.0.1 
注意. 禁止 q(). 
可以使用 Ctrl + c 两次 来终止
Ctrl + G  Q

ps aux | grep beam  
检查进程

方法3. https://www.iteye.com/blog/mryufeng-362394
