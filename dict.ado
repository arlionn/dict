*! 0.0.0.9000 程振兴 2017年12月21日
capture program drop dict
program define dict
	version 12.0
	syntax anything(name = content), [NOsplit Cite]
	clear all 
	qui set more off, permanently

	foreach word in `content'{
		qui{
			copy "http://cn.bing.com/dict/search?q=`word'&qs=n&form=Z9LH5&sp=-1&pq=`word'&sc=7-3&sk=&cvid=E8E3C113211944A69B575B5DA2C9009A" temp.txt, replace
			local times = 0
			while _rc != 0{
				local times = `times' + 1
				sleep 1000
				qui cap copy "http://cn.bing.com/dict/search?q=`word'&qs=n&form=Z9LH5&sp=-1&pq=`word'&sc=7-3&sk=&cvid=E8E3C113211944A69B575B5DA2C9009A" temp.txt, replace
				if `times' > 10{
					di as error "错误！：因为你的网络速度贼慢，无法获得数据"
					exit 601
				}
			}
			cap unicode encoding set gb18030
			cap unicode translate temp.txt
			cap unicode erasebackups, badidea
			infix strL v 1-20000 using temp.txt, clear
			keep if index(v, "keywords")
			set obs 13
			gen v2 = _n - 3
			gen v3 = _n
			tostring v2, replace
			tostring v3, replace
			replace v2 = "【单词】" if v2 == "-2"
			replace v2 = "【读音】" if v2 == "-1"
			replace v2 = "【释义】" if v2 == "0"
			replace v3 = "`a'" if v3 == "1"
			replace v3 = ustrregexs(0) if ustrregexm(v[1],"美\[(.*)\]") & v3 == "2"
			replace v = subinstr(v, " ", "", .)
			replace v3 = ustrregexs(0) if ustrregexm(v[1], "，[a-z].(.*)；") & v3 == "3"
			replace v3 = subinstr(v3, "，", "", .)
			replace v2 = ustrregexs(2) if ustrregexm(v3[3],"([a-z]+\.+?)") & v2 == "8"
			gen strL a = v3[3] in 1
			cap which moss
			if _rc != 0{
				ssc install moss
				di as yellow "由于这是你第一次运行该命令且你的电脑上没有安装moss命令，已自动为你安装moss命令。"
			}
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
			replace v3 = "" if v2 == "【释义】" 
			keep v2 v3
			rename v2 a
			rename v3 b
			format b %-50s
			compress
			cap erase temp.txt 
			replace b = "`word'" if a == "【单词】"
		}
		forval i = 1/`=_N'{
			local temp = a[`i']
			if "`temp'" == "【单词】"{
				local temp = "word"
			}
			if "`temp'" == "【读音】"{
				local temp = "prounciation"
			}
			if "`temp'" == "【释义】"{
				local temp = "means"
			}
			di a[`i'] + ":" + b[`i']
		}
		if "`nosplit'" == ""{
			di as yellow "----------------------------------------------------------"
		}
		if "`cite'" != ""{
			di as yellow "程振兴. dict: 使用Stata翻译英语单词到中文. version: 0.0.0.9000. 2017.12.21"
		}
	}
end
