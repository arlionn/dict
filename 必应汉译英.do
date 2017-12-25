clear all
cap mkdir "~/Documents/我的项目/dict"
cd "~/Documents/我的项目/dict"
local b = "程玉卿"
qui percentencode "`b'"
local a = "`r(percentencode)'"
copy "http://cn.bing.com/dict/search?q=`a'&qs=n&form=Z9LH5&sp=-1&pq=`a'&sc=2-2&sk=&cvid=F0EB8DBE335C4C6683304A4D16ECD8FB" temp.txt, replace
local times = 0
while _rc != 0{
	local times = `times' + 1
	sleep 1000
	qui cap copy "http://cn.bing.com/dict/search?q=`a'&qs=n&form=Z9LH5&sp=-1&pq=`a'&sc=2-2&sk=&cvid=F0EB8DBE335C4C6683304A4D16ECD8FB" temp.txt, replace
	if `times' > 10{
		di as error "错误！：因为你的网络速度贼慢，无法获得数据"
		exit 601
	}
}
cap unicode encoding set gb18030
cap unicode translate temp.txt
cap unicode erasebackups, badidea
infix strL v 1-20000 using temp.txt, clear
keep if index(v, "<title>")
replace v = subinstr(v, "网络释义：", "net.", .)
set obs 13
input strL v2 strL v3
【词语】 "1"
【拼音】 "2"
【英语】 "3"
 "1" "4"
 "2" "5"
 "3" "6"
 "4" "7"
 "5" "8"
 "6" "9"
 "7" "10"
 "8" "11"
 "9" "12"
 "10" "13"
replace v3 = "`b'" if v3 == "1"
replace v3 = ustrregexs(0) if ustrregexm(v[1],"\[(.*)\]") & v3 == "2"
replace v3 = subinstr(v3, "]", "", .)
replace v3 = subinstr(v3, "[", "", .)
replace v3 = ustrregexs(0) if ustrregexm(v[1], "，[a-z].(.*)；") & v3 == "3"
replace v3 = subinstr(v3, "，", "", .)
gen strL a = v3[3] in 1
moss a, match("([a-z]+\.+?)") regex unicode
levelsof _count, local(b)
local c = `b' + 3
forval i = 4/`c'{
	local j = `i' - 3
	replace v2 = _match`j'[1] if v2 == "`j'"
}
drop if _n > `c'
global p = ""
forval i = 1/`b'{
	global p = "$p" + " " + _match`i'
}
keep v v2 v3
split v3 if v3[_n+1] == "4", parse($p)
local j = 2
forval i = 4/`c'{
	replace v3 = v3`j'[3] if v3 == "`i'"
	local j = `j' + 1
}
replace v3 = "" if v2 == "【英语】" 
keep v2 v3
rename v2 a
rename v3 b
format b %-50s
compress
cap erase temp.txt 




