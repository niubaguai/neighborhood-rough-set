# 邻域粗糙集matlab实现

#### 采用增加法进行属性约简

具体步骤：

```
for i in 每个子属性
1.计算每个样本的领域类
2.根据领域类计算每个分类的下近似，再整理合并所有下近似
3.根据邻域下近似计算出领域依赖度
4.令约简属性自己r=空集，r(D)=0
5.计算属性重要度，
	如：sig(a1,R,D)=0-0=0
		sig(a2,R,D)=1/6-0=1/6
		sig(a3,R,D)=2/3-0=2/3
		选择属性重要度最大的属性，如：a3
6.进入新一轮的循环：
	在选择的属性基础上，选择新的属性，再次计算依赖度，选择重要属性。如：(a3,a1) (a3,a2)
7.当所选属性与其他属性的依赖度相减为0，结束约简算法
```

参考文献：

[1]徐波. 邻域粗糙集的启发式属性约简算法研究[D].四川师范大学,2019.

[2]Qinghua Hu,Daren Yu,Jinfu Liu,Congxin Wu. Neighborhood rough set based heterogeneous feature subset selection[J]. Information Sciences,2008,178(18):

