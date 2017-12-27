clear all
cap mkdir "~/Documents/我的项目/dict"
cd "~/Documents/我的项目/dict"
local a = "news"
copy "http://dict.cn/`a'" temp.txt, replace
local times = 0
while _rc != 0{
	local times = `times' + 1
	sleep 1000
	qui cap copy "http://dict.cn/`a'" temp.txt, replace
	if `times' > 10{
		di as error "错误！：因为你的网络速度贼慢，无法获得数据"
		exit 601
	}
}
cap unicode encoding set gb18030
cap unicode translate temp.txt
cap unicode erasebackups, badidea
infix strL v 1-20000 using temp.txt, clear
keep if index(v, `"h1"') | index(v, `"level-title"') | index(v, `"EN-US"') | index(v, `"<strong>"') | index(v, `"label"') | index(v[_n-2], `"label"') | index(v, `"<h3>"') | index(v, `"<bdo>"') | index(v, `"<li>"') | index(v, `"<h2>"') | index(v, `"<span>"') | index(v, `"<p>"') | index(v, `"<br/>"') | index(v, `"interj."') | index(v, `"用作"') | index(v, `"</a>"') | index(v, `"</li>"') | index(v, `"<b>"') | index(v, `"<div>"')
drop if index(v, "<a href=")
drop if index(v, "<a  href=")
drop if v == "<li>"
drop if v == "</li>"
drop if v == "<span>"
drop if v == "<b>"
drop if v == "<div>"
drop if index(v, "a name")
drop if index(v, "a class")
drop if v == "<h2>"
drop if index(v, "li id")
drop if index(v, "<dt><span>")
drop if index(v, "附录")
drop if index(v, "查词历史")
drop if index(v, "a title")
drop if index(v, "a style")
drop if index(v, "a target")
drop if index(v, "i tip")

gen a = _n
gen b = _n
tostring a b, replace

replace a = "【单词】" if a == "1"
replace b = ustrregexs(0) if ustrregexm(v[1],">(.*)<") & b == "1"
replace a = "【词汇等级】" if a == "2"
replace b = ustrregexs(0) if ustrregexm(v[2],">(.*)<") & b == "2"
replace b = subinstr(b, "                            ", "", .)
compress
replace a = "【读音】" if a == "3"
replace a = "英:" if a == "4"
replace b = ustrregexs(0) if ustrregexm(v[4],">(.*)<") & b == "4"
replace a = "美:" if a == "5"
replace b = ustrregexs(0) if ustrregexm(v[6],">(.*)<") & b == "5"
replace a = "【释义】" if a == "6"
forval i = 7/`=_N'{
	if index(v[`i'], "label"){
		global temp1 = `i' - 2
		continue, break
	}
}
di $temp1
forval i = 7(2)$temp1{
	replace a = ustrregexs(0) if ustrregexm(v[`i'],">(.*)<") & a == "`i'"
	replace b = ustrregexs(0) if ustrregexm(v[`i'+1],">(.*)<") & b == "`i'"
}
global temp2 = $temp1 + 1
replace a = "【形态】" if a == "$temp2"
global temp3 = $temp2 + 1
forval i = $temp3/`=_N'{
	if index(v[`i'], "<h3>"){
		global temp4 = `i' - 2
		continue, break
	}
}
forval i = $temp3(2)$temp4{
	replace a = ustrregexs(0) if ustrregexm(v[`i'],">(.*)<") & a == "`i'"
	replace b = subinstr(v[`i'+1], "</a>", "", .) if b == "`i'"
}
global temp5 = $temp4 + 2
replace a = "【详尽释义】" if a == "$temp5"
global temp6 = $temp5 + 1
forval i = $temp6/`=_N'{
	if index(v[`i'], "<h3>"){
		global temp7 = `i' - 1
		continue, break
	}
}
forval i = $temp6/$temp7{
	replace a = subinstr(v[`i'], "                                                                                    ", "", .) if a == "`i'" & index(v[`i'], "li") == 0 
	replace b = ustrregexs(0) if ustrregexm(v[`i'], ">(.*)<") & b == "`i'" & index(v[`i'], "li")
}
global temp8 = $temp7 + 1
replace a = "【双解释义】" if a == "$temp8"
global temp9 = $temp8 + 1
forval i = $temp9/`=_N'{
	if index(v[`i'], "<h3>"){
		global temp10 = `i' - 1
		continue, break
	}
}
forval i = $temp9/$temp10{
	replace a = subinstr(v[`i'], "                                                                                    ", "", .) if a == "`i'" & index(v[`i'], "li") == 0 
	replace b = v[`i'] if b == "`i'" & index(v[`i'], "li")
}
global temp11 = $temp10 + 1
replace a = "【英英释义】" if a == "$temp11"
global temp12 = $temp11 + 1
forval i = $temp12/`=_N'{
	if index(v[`i'], "<h3>"){
		global temp13 = `i' - 1
		continue, break
	}
}
forval i = $temp12/$temp13{
	replace a = ustrregexs(0) if ustrregexm(v[`i'], ">(.*)<") & a == "`i'" & index(v[`i'], "<span>") 
	replace b = v[`i'] if b == "`i'" & index(v[`i'], "<span>") == 0
}
global temp14 = $temp13 + 1
replace a = "【例句】" if a == "$temp14"
global temp15 = $temp14 + 1
forval i = $temp15/`=_N'{
	if index(v[`i'], "<h3>"){
		global temp16 = `i' - 1
		continue, break
	}
}
forval i = $temp15/$temp16{
	replace a = subinstr(v[`i'], "                                                                                    ", "", .) if a == "`i'" & index(v[`i'], "li") == 0
	replace b = v[`i'] if b == "`i'" & index(v[`i'], "li")
}
global temp17 = $temp16 + 1
replace a = "【常见句型】" if a == "$temp17"
global temp18 = $temp17 + 1
forval i = $temp18/`=_N'{
	if index(v[`i'], "<h3>"){
		global temp19 = `i' - 1
		continue, break
	}
}
forval i = $temp18/$temp19{
	replace a = subinstr(v[`i'], "                                                                            ", "", .) if a == "`i'" & index(v[`i'], "li") == 0
	replace b = v[`i'] if b == "`i'" & index(v[`i'], "li")
}
global temp20 = $temp19 + 1
replace a = "【常见短语】" if a == "$temp20"
global temp21 = $temp20 + 1
forval i = $temp21/`=_N'{
	if index(v[`i'], "<h3>"){
		global temp22 = `i' - 1
		continue, break
	}
}
forval i = $temp21/$temp22{
	replace a = subinstr(v[`i'], "                                                   ", "", .) if a == "`i'" & index(v[`i'], ">") == 0
	replace b = v[`i'] if b == "`i'" & index(v[`i'], ">")
}

global temp23 = $temp22 + 1
replace a = "【词汇搭配】" if a == "$temp23"
global temp24 = $temp23 + 1
forval i = $temp24/`=_N'{
	if index(v[`i'], "<h3>"){
		global temp25 = `i' - 1
		continue, break
	}
}
forval i = $temp24/$temp25{
	replace a = v[`i'] if a == "`i'" & index(v[`i'], "</a>") == 0 & index(v[`i'], "li") == 0
	replace b = subinstr(v[`i'], "                                                                  </li>", "", .) if b == "`i'" & (index(v[`i'], "</a>") | index(v[`i'], "li"))
}

global temp26 = $temp25 + 1
replace a = "【经典引文】" if a == "$temp26"
global temp27 = $temp26 + 1
forval i = $temp27/`=_N'{
	if index(v[`i'], "<h3>"){
		global temp28 = `i' - 1
		continue, break
	}
}
global tempspecial = $temp28 - 1
forval i = $temp27(2)$tempspecial{
	replace a = ustrregexs(0) if ustrregexm(v[`i'], ">(.*)<") & a == "`i'" 
	replace b = ustrregexs(0) if ustrregexm(v[`i'+1], ">(.*)<") & b == "`i'"
}

global temp29 = $temp28 + 1
replace a = "【词语用法】" if a == "$temp29"
global temp30 = $temp29 + 1
forval i = $temp30/`=_N'{
	if index(v[`i'], "<h3>"){
		global temp31 = `i' - 1
		continue, break
	}
}
forval i = $temp30/$temp31{
	replace a = subinstr(v[`i'], "                                                                     ", "", .) if a == "`i'" & index(v[`i'], "<em>") == 0
	replace b = v[`i'] if b == "`i'" & index(v[`i'], "em")
}

global temp32 = $temp31 + 1
replace a = "【词源解说】" if a == "$temp32"
replace b = v[$temp32+1] if b == "$temp32"

global temp33 = $temp32 + 2
replace a = "【近反义词】" if a == "$temp33"
global temp34 = $temp33 + 1
replace a = "近义词" if a == "$temp34"
global temp35 = $temp34 + 1
forval i = $temp35/`=_N'{
	if index(v[`i'], "<h3>"){
		global temp36 = `i' - 2
		continue, break
	}
}
forval i = $temp35(2)$temp36{
	replace a = v[`i'] if a == "`i'" 
	replace b = v[`i'+1] if b == "`i'"
}
global temp37 = $temp36 + 2
replace a = "【临近单词】" if a == "$temp37"
global temp38 = $temp37 + 1
global temp39 = `=_N' - 1
forval i = $temp38(2)$temp39{
	replace a = v[`i'] if a == "`i'" 
	replace b = v[`i'+1] if b == "`i'"	
}
drop v
drop if ustrregexm(a, "[0-9]") & ustrregexm(b, "[0-9]")
replace a = subinstr(a, "<bdo>", "", .)
replace a = subinstr(a, "</bdo>", "", .)
replace a = subinstr(a, "<p>", "", .)
replace a = subinstr(a, "</p>", "", .)
replace a = subinstr(a, "<b>", "", .)
replace a = subinstr(a, "</b>", "", .)
replace a = subinstr(a, "</a>", "", .)
replace a = subinstr(a, "<a>", "", .)
replace a = subinstr(a, "</div>", "", .)
replace a = subinstr(a, "<div>", "", .)
replace a = subinstr(a, "<li>", "", .)
replace a = subinstr(a, "</li>", "", .)
replace a = subinstr(a, "</span>", "", .)
replace a = subinstr(a, "<span>", "", .)
replace a = subinstr(a, "<br/>", "", .)
replace a = subinstr(a, "<br>", "", .)
replace a = subinstr(a, "  ", "", .)
compress a
replace a = "" if ustrregexm(a, "[0-9]")
replace a = subinstr(a, ">", "", .)
replace a = subinstr(a, "<", "", .)
replace b = subinstr(b, `"""', "", .)

replace b = subinstr(b, "  ", "", .)
replace b = "" if ustrregexm(b, "[0-9]")
replace b = subinstr(b, "<li>", "", .)
replace b = subinstr(b, "</strong>", "", .)
replace b = subinstr(b, "</li>", "", .)
replace b = subinstr(b, "<p>", "", .)
replace b = subinstr(b, "</p>", "", .)
replace b = subinstr(b, "<strong>", "", .)
replace b = subinstr(b, "<br/>", "", .)
replace b = subinstr(b, "<br>", "", .)
replace b = subinstr(b, "/bdo", "", .)
replace b = subinstr(b, "bdo", "", .)
replace b = subinstr(b, "</a>", "", .)
replace b = subinstr(b, "<em>", "", .)
replace b = subinstr(b, "</em>", "", .)
replace b = subinstr(b, "</ul>", "", .)
replace b = subinstr(b, "<ul>", "", .)
replace b = subinstr(b, "</dt>", "", .)
replace b = subinstr(b, "<dt>", "", .)
replace b = subinstr(b, "</b>", "", .)
replace b = subinstr(b, "<b>", "", .)
replace b = subinstr(b, ">", "", .)
replace b = subinstr(b, "<", "", .)
format a %-20s
format b %-20s
drop if a == "" & b == ""