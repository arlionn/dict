clear all
cap mkdir "~/Documents/我的项目/dict"
cd "~/Documents/我的项目/dict"
local a = "2018年01月12日增加了句子的中英互译。"
qui percentencode "`a'"
local b = "`r(percentencode)'"
copy "http://www.youdao.com/w/`b'/#keyfrom=dict2.top" temp.txt, replace
local times = 0
while _rc != 0{
	local times = `times' + 1
	sleep 1000
	qui cap copy "http://www.youdao.com/w/`a'/#keyfrom=dict2.top" temp.txt, replace
	if `times' > 10{
		di as error "错误！：因为你的网络速度贼慢，无法获得数据"
		exit 601
	}
}
cap unicode encoding set gb18030
cap unicode translate temp.txt
cap unicode erasebackups, badidea
infix strL v 1-20000 using temp.txt, clear
keep if index(v[_n+1], "机器翻译")
replace v = ustrregexs(1) if ustrregexm(v[1],">(.*)<")
local c = v[1]
di as text "`a'"
di as text "`c'"

* 英译中：
clear all
cap mkdir "~/Documents/我的项目/dict"
cd "~/Documents/我的项目/dict"
local a = "After the 1987 market crash of the New York stock exchange."
qui percentencode "`a'"
local b = "`r(percentencode)'"
copy "http://www.youdao.com/w/`b'/#keyfrom=dict2.top" temp.txt, replace
local times = 0
while _rc != 0{
	local times = `times' + 1
	sleep 1000
	qui cap copy "http://www.youdao.com/w/`a'/#keyfrom=dict2.top" temp.txt, replace
	if `times' > 10{
		di as error "错误！：因为你的网络速度贼慢，无法获得数据"
		exit 601
	}
}
cap unicode encoding set gb18030
cap unicode translate temp.txt
cap unicode erasebackups, badidea
infix strL v 1-20000 using temp.txt, clear
keep if index(v[_n+1], "机器翻译")
replace v = ustrregexs(1) if ustrregexm(v[1],">(.*)<")
local c = v[1]
di as text "`a'"
di as text "`c'"










