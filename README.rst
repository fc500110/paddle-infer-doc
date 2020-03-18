Paddle 预测文档
============

首先准备Paddle预测代码


.. code:: bash

    ./prepare.sh



编译预测文档

.. code:: bash

    make -j html

预览

.. code:: bash
    
    python3 -m http.server 8000


在浏览器打开链接, 找到library_root就可以预览
