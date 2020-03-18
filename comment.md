
# 文档注释


## 1. 注释风格

Doxygen支持三种注释风格

``` cpp
/**
 * ... style 1 ...
 */

/*!
 * ... style 2 ...
 */

/// 
/// ... style 3 ...
/// 
```

我们统一采用三个斜杠 `///` 风格的注释


## 2. 文档概述

使用`\mainpage` 为整个API生成文档概述，提供API的high level描述，和主要条目

概述可以分为多个小节，用 `\section` 和 `\subsection`

``` cpp
///
/// \mainpage Paddle inference API documentation
///
/// \section sec_Contents Contents
/// \li \ref sec_Overview
/// \li \ref sec_Detail
/// \li \ref sec_SeeAlso
///
/// \section sec_Overview Overview
/// This is overview
/// 
/// \section sec_Detail Detailed Description
/// This is detail
///
/// \section sec_SeeAlso See Also
```

## 3. 文件注释

文件头部增加注释, 作为整个模块的文档

``` cpp
///
/// \file <filename>
/// 
/// \brief <description>
///
/// \author <paddle-infer@baidu.com, ...>
/// \date <date>
///
/// module description
/// 
```

## 4. 类注释
文件中的类应该增加注释

已经弃用的类使用 `\deprecated` 命令

``` cpp
/// 
/// \class <ClassName>
/// 
/// \brief <...>
///
/// ... description ...
///
/// \author <...>
/// \date <...>
/// 
```

## 5. 方法注释
详细说明类方法中参数名称和描述，说明是输入参数、输出参数还是输入输出可选参数，对返回值进行描述，适当添加 `\ingroup` 和 `\deprecated`

``` cpp
///
/// \brief <...>
/// 
/// ... description ...
///
/// \param[in] <input parameter name> <description>
/// \param[out] <output parameter name> <description>
/// \return <...>
/// \see <see also>
/// \note <...>
///
class TestDoxygen {
 public:
  /// \name group1
  //@{
  void Method1InGroup1();
  void Method2InGroup1();
  //@}

  /// \name group1
  //@{
  void Method1InGroup2();
  void Method2InGroup2();
  //@}
};
```

## 6. 枚举和类(结构体)成员注释
使用 `<` 语法将注释附加到前一个元素

``` cpp
///
/// \brief <...>
/// 
/// ... description ...
///
enum class DataType {
  kI8,  ///< int8
  kI32, ///< int32
  kI64, ///< int64
  kF16, ///< float16
};

///
/// \brief <...>
///
struct Point {
  int x; ///< x
  int y; ///< y
};
```

## 7. 禁用doxygen
使用 `\cond ... \endcond` 跳过非公开的public API

## 8. 示例
``` cpp
///
/// \file paddle_api.h
/// 
/// \brief Paddle API信息
///
/// \autohr paddle-infer@baidu.com
/// \date 2020-01-01
/// \since 1.7
/// 
#pragma once

/// 
/// \file paddle_api.h
/// \brief Memory manager for `PaddleTensor`.
/// \since 1.7.0
/// 
/// The PaddleBuf holds a buffer for data input or output. The memory can be
/// allocated by user or by PaddleBuf itself, but in any case, the PaddleBuf
/// should be reused for better performance.
/// 
/// For user allocated memory, the following API can be used:
/// - PaddleBuf(void* data, size_t length) to set an external memory by
/// specifying the memory address and length.
/// - Reset(void* data, size_t length) to reset the PaddleBuf with an external
/// emory.
/// ATTENTION, for user allocated memory, deallocation should be done by users
/// xternally after the program finished. The PaddleBuf won't do any allocation
/// r deallocation.
/// 
/// To have the PaddleBuf allocate and manage the memory:
/// - PaddleBuf(size_t length) will allocate a memory of size `length`.
/// - Resize(size_t length) resize the memory to no less than `length`, ATTENTION
///  if the allocated memory is larger than `length`, nothing will done.
/// 
/// Example usage:
/// 
/// Let PaddleBuf manage the memory internally.
/// \code{cpp}
///     const int num_elements = 128;
///     PaddleBuf buf(num_elements * sizeof(float));
/// \endcode
/// 
/// Or
/// \code{cpp}
///     PaddleBuf buf;
///     buf.Resize(num_elements * sizeof(float));
/// \endcode
/// Works the exactly the same.
/// 
/// One can also make the `PaddleBuf` use the external memory.
/// \code{cpp}
///     PaddleBuf buf;
///     void *external_memory = new float[num_elements];
///     buf.Reset(external_memory, num_elements*sizeof(float));
///     // ...
///     delete[] external_memory; // manage the memory lifetime outside.
/// \endcode
///
class PaddleBuf {
 public:
 // ...
 
  /// \brief Reset to external memory, with address and length set.
  /// \param[in] data data pointer
  /// \param[in] length buffer length
  void Reset(void* data, size_t length);
};

///
/// \brief Basic input and output data structure for PaddlePredictor.
///
struct PaddleTensor {
  PaddleTensor() = default;
  std::string name;                     ///< variable name.
  std::vector<int> shape;               ///< shape
  PaddleBuf data;                       ///< blob of data.
  PaddleDType dtype;                    ///< data type
  std::vector<std::vector<size_t>> lod; ///< Tensor+LoD equals LoDTensor
};

/// \cond NATIVE
/// \deprecated
struct NativeConfig : public PaddlePredictor::Config {
};
/// \encond
```



