#!/bin/bash

PADDLE_ROOT=Paddle

git clone --single-branch https://github.com/PaddlePaddle/Paddle.git ${PADDLE_ROOT}

ln -s ${PADDLE_ROOT}/paddle/fluid/inference paddle-inference
