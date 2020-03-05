常见问题汇总
-------------------



GCC 8.2升级相关
~~~~~~~~~~~~~~~~~~~


按照公司要求,编译工具已经升级GCC8.2

.. note::

    1. icode预编译库只支持GCC8.2, GPU库要求CUDA版本在10.1及以上

    2. 1.6.1及更低版本支持GCC4.8.2, 1.6.1及更高版本支持GCC8.2

    3. GPU预测升级GCC8.2后报错,且报错信息包含 PaddleCheckError: Expected id < GetCUDADeviceCount(), but received id:0 >= GetCUDADeviceCount():0.，请检查环境设置，需要在LD_LIBRARY_PATH中加入/usr/lib64

    4. 若编译后遇到libstdc++.so.6中GLIBCXX版本过低的问题，请在CXXFLAGS中加入”-Wl,–rpath=/opt/compiler/gcc-8.2/lib,–dynamic-linker=/opt/compiler/gcc-8.2/lib/ld-linux-x86-64.so.2”，以保证编译产出的binary文件所需的libc.so.6/libstdc++.so.6正确链接到/opt/compiler/gcc-8.2/lib目录下的对应库
