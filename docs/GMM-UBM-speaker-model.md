# GMM-UBM-speaker-model

## Content

- [1. 简述说话人识别流程](#简述说话人识别流程)

- [2. 什么是混合高斯模型GMM](#什么是混合高斯模型GMM)

- [3. 什么是通用背景模型UBM](#什么是通用背景模型UBM)

- [4. 什么是最大似然估计](#什么是最大似然估计)

- [5. EM算法](#EM算法)

- [6. GMM-UBM模型](#GMM-UBM模型)

- [7. 基本数学理论](#基本数学理论)
  
  - [7.1 泛化误差](#泛化误差)
  - [7.2 方差](#方差)
  - [7.3 期望](#期望)

#### 1. 简述说话人识别流程 <span id = "简述说话人识别流程">

1. 特征提取

   预加重、分帧加窗、傅里叶变换得到频谱图、再进行mel滤波使频谱图更紧凑、最后进行倒谱分析(取对数和离散余弦变换)和差分(提供一种动态特征)的到MFCC特征向量。

2. 训练模型

3. 打分判决

#### 2. 什么是混合高斯模型GMM <span id = "什么是混合高斯模型GMM">

1. GMM就是由多个单高斯分布混合而成的一个模型。
2. 为什么要混合：因为单个分布的话拟合能力不够。
3. 为什么要高斯：
   1. 因为高斯分布有很好的计算性质，他有一个自然数e，很自然就可以取对数将乘法变成加法。
   2. 同时高斯分布也有很好的理论支撑,从中心极限定理可知,如果采样最够多的话，n个采样的平均值x拔会符合高斯分布，他的均值就是变量的均值，方差等于变量方差/n，那么只要n足够大，就可以用平均数的高斯分布去近似随机变量的高斯分布。

#### 3. 什么是通用背景模型UBM <span id = "什么是通用背景模型UBM">

1. UBM相当于一个大的混合高斯分布模型。
2. 目的：为了解决目标用户训练数据太少的问题，用大量非目标用户数据训练出一个拟合通用特征的大型GMM。

#### 4. 什么是最大似然估计 <span id = "什么是最大似然估计">

最大似然估计是一种反推：就是你只已经知道模型了，同时你也有了观测数据，但是模型的参数是未知的，这时候肯定是算不出来准确的参数值的。那就可以把产生当前观测数据的可能性最大的参数当作估计值，这就是最大似然的含义，也就是最大可能性。

#### 5. EM算法 <span id = "EM算法">

1. EM算法的关键思想就是迭代求解。
2. 他有两个关键的步骤：期望步和最大化。
   1. 期望：先用上一轮迭代得到的参数计算出隐性变量(无法直接观测到的变量，比如统计身高分布，某个人是男是女无法观测到)的期望。
   2. 最大化：使用最大似然估计和这个期望值来算出新的参数。
      在混合高斯模型中，这个隐性变量实际上是描述数据由那个子高斯分布取样得到的，那他的期望实际上就是被某个子分布生成的概率。

#### 6. GMM-UBM模型 <span id = "GMM-UBM模型">

1. 先使用大量的非目标用户数据训练UBM；
2. 然后使用MAP自适应算法和目标说话人数据来更新局部参数得到对应的GMM；
3. MAP自适应算法相当于先进性一轮EM迭代得到新的参数，然后将新参数和旧参数整合。

#### 7. 基本数学理论 <span id = "基本数学理论">

#### 7.1 泛化误差 <span id = "泛化误差">

在统计学中, 一个随机变量的方差描述的是它的离散程度, 也就是该随机变量在其期望值附近的**波动程度**。

先从下面的靶心图来对方差与偏差有个直观的感受：

![](https://liuchengxu.github.io/blog-cn/assets/images/posts/bulls-eye-diagram.png)

假设红色的靶心区域是学习算法完美的正确预测值, 蓝色点为每个数据集所训练出的模型对样本的预测值, 当我们从靶心逐渐向外移动时, 预测效果逐渐变差。

很容易看出有两副图中蓝色点比较集中, 另外两幅中比较分散, 它们描述的是方差的两种情况.。比较集中的属于**方差**小的, 比较分散的属于**方差大**的情况。

再从蓝色点与红色靶心区域的位置关系, 靠近红色靶心的属于**偏差**较小的情况, 远离靶心的属于**偏差**较大的情况.

![](https://liuchengxu.github.io/blog-cn/assets/images/posts/bulls-eye-label-diagram.png)

有了直观感受以后, 下面来用公式推导泛化误差与偏差与方差, 噪声之间的关系：

| **符号** | **涵义** |
| :------: | :------: |
|  $$x$$   |          |
|    D     |          |
|    yD    |          |
|    y     |          |
|    f     |          |
|  f(x;D)  |          |
|          |          |



#### 7.2 方差 <span id = "方差">

中文名：方差，外文名：variance/deviation Var，类型：统计学，种类：离散型方差、连续型方差。

方差是在概率论和统计方差**衡量**随机变量或一组数据的**离散程度的度量**。概率论中方差用来度量随机变量和其数学期望（即均值）之间的**偏离程度**。统计中的方差（样本方差）是每个样本值与全体样本值的平均数之差的平方值的平均数。

![img](https://gss2.bdstatic.com/9fo3dSag_xI4khGkpoWK1HF6hhy/baike/s%3D113/sign=c388d5738013632711edc632a28ea056/023b5bb5c9ea15cee484a9a6bc003af33a87b233.jpg)

![img](https://gss0.bdstatic.com/-4o3dSag_xI4khGkpoWK1HF6hhy/baike/s%3D18/sign=cbff73bb48a7d933bba8e07bac4b41a2/f7246b600c3387442fb466d35b0fd9f9d72aa028.jpg)为总体方差，![img](https://gss1.bdstatic.com/9vo3dSag_xI4khGkpoWK1HF6hhy/baike/s%3D12/sign=19a04804093b5bb5bad724fc37d3f460/4034970a304e251fa45ead57ad86c9177e3e53f7.jpg)为变量，![img](https://gss1.bdstatic.com/9vo3dSag_xI4khGkpoWK1HF6hhy/baike/s%3D13/sign=18b6d1d4db1373f0f13f6b9ca60f5cc6/1b4c510fd9f9d72aa9ac59b2de2a2834359bbb51.jpg)为总体均值，![img](https://gss1.bdstatic.com/9vo3dSag_xI4khGkpoWK1HF6hhy/baike/s%3D14/sign=198a4804093b5bb5bad724fa37d3f40c/4034970a304e251fa474ad57ad86c9177e3e5399.jpg)为总体例数。

#### 7.3 期望 <span id = "期望">

**期望**：在概率论和统计学中，一个离散性随机变量的**期望值**（或**数学期望**，亦简称**期望**，物理学中称为**期待值**）是试验中每次可能的结果乘以其结果概率的总和。换句话说，期望值像是随机试验在同样的机会下重复多次，所有那些可能状态平均的结果，便基本上等同“期望值”所期望的数。期望值可能与每一个结果都不相等。换句话说，期望值是该变量输出值的加权平均。

例如，掷一枚公平的六面骰子，其每次“点数”的期望值是3.5，计算如下：

![](https://wikimedia.org/api/rest_v1/media/math/render/svg/85913408feb11576c17e1e9827dade2177170d96)

不过如上所说明的，3.5虽是“点数”的期望值，但却不属于可能结果中的任一个，没有可能掷出此点数。

赌博是期望值的一种常见应用。

如果![X](https://wikimedia.org/api/rest_v1/media/math/render/svg/68baa052181f707c662844a465bfeeb135e82bab)是在概率空间![{\displaystyle (\Omega ,F,P)}](https://wikimedia.org/api/rest_v1/media/math/render/svg/3c6612687e4bdc3bdc02e47fe4c79316fc9e90e4)中的随机变量，那么它的期望值![{\displaystyle \operatorname {E} (X)}](https://wikimedia.org/api/rest_v1/media/math/render/svg/734c66846ec383f7e00c23ae4f4155f3cdc8c0fb)的定义是：

![](https://wikimedia.org/api/rest_v1/media/math/render/svg/d7ab8efaa4e279814bdb7dcbd04aa231796f105e)

如果![X](https://wikimedia.org/api/rest_v1/media/math/render/svg/68baa052181f707c662844a465bfeeb135e82bab)是**离散**的随机变量，输出值为![x_{1},x_{2},\ldots ](https://wikimedia.org/api/rest_v1/media/math/render/svg/3bfc8b10a5ede4dae0d4341edcc65f6a20232e00)，和输出值相应的概率为![p_{1},p_{2},\ldots ](https://wikimedia.org/api/rest_v1/media/math/render/svg/5d2a5f0df47b52b649e76beb97452539b7c058b0)（概率和为1）。





















































