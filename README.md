在Stata中进行中英文单词、词语、句子互译——dict命令<img src="https://github.com/czxa/Web_data_Source/raw/master/elearning.png" align="right" />
========================================================
[![Travis](https://img.shields.io/travis/rust-lang/rust.svg?style=plastic)](http:www.czxa.top) [![](https://img.shields.io/badge/Stata-dict-brightgreen.svg?style=plastic)](http://www.czxa.top) [![](https://img.shields.io/badge/github-Stata-orange.svg?style=plastic)](http://www.czxa.top) [![](https://img.shields.io/badge/platform-Windows_os|Mac_os-orange.svg?style=plastic)](http://www.czxa.top) [![](https://img.shields.io/badge/Fork-30-orange.svg?style=social)](http://www.czxa.top)

安装：
--------

#### 首先你需要安装github命令，这个命令是用来安装github上的命令的：
```js
net install github, from("https://haghish.github.io/github/")
```

#### 然后就可以安装这个命令了：
```js
github install czxa/dict, replace
```
<!--more-->
#### 或者下载安装：
* 另外你也可以从这里把ado文件和sthlp文件下载下来，然后放在你的Stata系统文件夹里，查看系统文件夹的路径可以运行下面的命令：

```js
sysdir
```

* 放在那个文件夹里都可以，推荐放在plus文件夹里。

用法：
--------

##### 基本语法：

> dict contents, [nosplit sentence cite]

* contents: 是一列需要查询的英语单词、中文词语或中英文句子。

选项：
--------

* **`nosplit`**: 可以简写为no，为了便于区分多个查询结果，系统会自动在每个查询结果后面画一条黄线，加上选择项nosplit可以取消这条线。
* **`cite`**: 可以简写为c，如果你需要引用该命令，可以加上该选项显示引用方式。
* **`sentence`**: 可以简写为表明需要翻译的内容为句子，注意每次只能翻译一个句子，句子需要使用双引号括起来。


示例
--------

```js
dict apple
dict evidence
dict food water
dict food water, no
dict food water, no c
dict 您好
dict 再见
dict 证据 国际 政策, no
dict "学会信息和数据快速采集都是非常必要的", s
dict "It is necessary to learn information and data collection quickly.", s
```

### 示例图片：

![](https://github.com/czxa/dict/raw/master/example.png)
![](https://github.com/czxa/dict/raw/master/example1.png)
![](https://github.com/czxa/dict/raw/master/example2.png)
