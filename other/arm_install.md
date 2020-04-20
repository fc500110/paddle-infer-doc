# 飞腾ARM服务器安装paddle预测库

## 安装环境

系统: Kylin 4.0.2

CPU: Phytium,FT2000PLUS 64核心

假设工作路劲为环境变量 `WORKDIR`

## 编译预测库

运行前设置

``` bash
ulimit -n 2048
```

下载PaddlePaddle v1.7.2

``` bash
cd $WORKDIR
git clone --single-branch -b v1.7.2 http://github.com/PaddlePaddle/Paddle.git paddle
cd paddle
```


### 编译C++库


1. 修改`$WORKDIR/paddle/CMakeLists.txt, 增加`set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fPIC")`和`set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fPIC")`

2. 修改 `$WORKDIR/paddle/cmake/flags.cmake` 将 191 行注释掉

3. 执行cmake

``` bash
cd $WORKDIR/paddle
mkdir build_cc && cd build_cc
cmake .. \
  -DCMAKE_BUILD_TYPE=Release \
  -DWITH_CONTRIB=OFF \
  -DWITH_MKL=OFF \
  -DWITH_MKLDNN=OFF \
  -DWITH_TESTING=OFF \
  -DWITH_GPU=OFF \
  -DWITH_PYTHON=OFF \
  -DON_INFER=ON \
  -DWITH_XBYAK=OFF
```

4. 执行make

``` bash
cd $WORKDIR/paddle/build_cc
make -j4 TARGET=ARMV8
```

注意必须带上TARGET=ARMV8


5. 编译完成

C++预测库路径为`$WORKDIR/paddle/build_cc/fluid_inference_install_dir`

### 编译Python库

1. 安装Python

下载Python源码并解压

``` bash
cd $WORKDIR
wget https://www.python.org/ftp/python/3.7.5/Python-3.7.5.tgz
tar zxvf Python-3.7.5.tgz
```

编译Python

``` bash
cd $WORKDIR/Python-3.7.5
./configure --prefix=$WORKDIR/python37 --enable-shared
make TARGET=ARMV8 -j4
make -j4 install
export PATH=$WORKDIR/python37/bin:$PATH
```

2. 安装依赖库

安装numpy

```
cd $WORKDIR
wget https://github.com/numpy/numpy/releases/download/v1.17.5/numpy-1.17.5.tar.gz
tar zxvf numpy-1.17.5.tar.gz
cd numpy-1.17.5
python3 -m pip install cython
python3 setup.py install
```

安装scipy

``` bash
sudo apt install -y liblapack-dev
cd $WORKDIR
wget https://github.com/scipy/scipy/releases/download/v1.3.1/scipy-1.3.1.tar.gz
tar zxvf scipy-1.3.1.tar.gz
cd scipy-1.3.1
python3 setup.py install
```

编译python预测库

``` bash
python3 -m pip install wheel protobuf

cd $WORKDIR
mkdir build_py && cd build_py

cmake .. \
  -DCMAKE_BUILD_TYPE=Release \
  -DWITH_CONTRIB=OFF \
  -DWITH_MKL=OFF \
  -DWITH_MKLDNN=OFF \
  -DWITH_TESTING=OFF \
  -DWITH_GPU=OFF \
  -DWITH_PYTHON=ON \
  -DPY_VERSION=3 \
  -DON_INFER=ON \
  -DWITH_XBYAK=OFF \
  -DPYTHON_EXECUTABLE=$WORKSPACE/python37/bin/python3

make TARGET=ARMV8 -j4
```
