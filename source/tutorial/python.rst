Using Python inference API
----------

Paddle预测提供了完整的Python API,在保证性能与C++预测对齐的同时,还优化了API,支持使用numpy交换输入输出数据,简单易用.


Python API包括如下数据结构

- AnalysisConfig
  AnalysisConfig是创建Predictor的配置

下面是一个Python预测示例

.. code:: python

    import numpy as np
    from paddle.fluid.core import AnalysisConfig
    from paddle.fluid.core import create_paddle_predictor

    config = AnalysisConfig("model")
    predictor = create_paddle_predictor(config)

    input_names = predictor.get_input_names()

    input_tensor = predictor.get_input_tensor(input_names[0])
    input_tensor.copy_from_cpu(np.array([[1., 2., 3.]]))

