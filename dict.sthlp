{smcl}
{* 2017年12月21日}
{hline}
{cmd:help dict}{right: }
{hline}

{title:标题}

{phang}
{bf:dict} {hline 2} 在Stata中查单词。{p_end}

{pstd}{browse "https://github.com/czxa/dict/raw/master/example.png":示例结果图片}{p_end}

{title:语法}

{p 8 18 2}
{cmdab:dict} {cmd: words} {cmd:,} [{cmd:{opt no:split}} {cmd:{opt c:ite}}]

{marker options}{...}
{title:选项}

{phang}
{cmd: {opt no:split}}: 选择是否有分割线。{p_end}

{phang}
{opt c:ite}: 如果你需要引用该命令，加上该选项可以显示引用格式。{p_end}

{title:示例}

{phang}
{stata `"dict apple"'}
{p_end}
{phang}
{stata `"dict evidence"'}
{p_end}
{phang}
{stata `"dict impact"'}
{p_end}
{phang}
{stata `"dict water expectancy"'}
{p_end}
{phang}
{stata `"dict policy, no"'}
{p_end}
{phang}
{stata `"dict air, cite"'}
{p_end}

{title:作者}

{pstd}程振兴{p_end}
{pstd}暨南大学经济学院{p_end}
{pstd}中国广州{p_end}
{pstd}{browse "http://www.czxa.top/dict/":项目网站}{p_end}
{pstd}{browse "http://czxa.top":个人网站}{p_end}
{pstd}Email {browse "mailto:czx@czxa.top":czx@czxa.top}{p_end}

{title:Also see}
{phang}
{stata `"help dict"'}
{p_end}