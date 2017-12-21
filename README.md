# 在Stata中查单词——dict命令

### 在Stata中直接查单词。

### 示例图片：

![](https://github.com/czxa/dict/raw/master/example.png)

### 安装：

#### 首先你需要安装github命令，这个命令是用来安装github上的命令的：
```stata
net install github, from("https://haghish.github.io/github/")
```

#### 然后就可以安装这个命令了：
```stata
github install czxa/dict, replace
```
<!--more-->
#### 或者下载安装：
* 另外你也可以从这里把ado文件和sthlp文件下载下来，然后放在你的Stata系统文件夹里，查看系统文件夹的路径可以运行下面的命令：

```stata
sysdir
```

* 放在那个文件夹里都可以，推荐放在plus文件夹里。

#### 用法：
##### 基本语法：

> dict words, [nosplit, cite]

* words: 是一列需要查询的英语单词。

##### 选项

* **nosplit**: 可以简写为no，为了便于区分多个查询结果，系统会自动在每个查询结果后面画一条黄线，加上选择项nosplit可以取消这条线。
* **cite**: 可以简写为c，如果你需要引用该命令，可以加上该选项显示引用方式。


#### 示例

```stata
dict apple
dict evidence
dict food water
dict food water, no
dict food water, no c
```
