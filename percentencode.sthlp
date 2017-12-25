{smcl}
{* 2017年12月25日}
{hline}
{cmd:help percentencode}{right: }
{hline}

{title:标题}

{phang}
{bf:dict} {hline 2} 在Stata中将字符串转换为url编码。{p_end}

{title:语法}

{p 8 18 2}
{cmdab:percentencode} {cmd: string}

{pstd}{cmd: 描述:}{p_end}

{pstd}{space 3}{cmd: string}: 为将要被翻译的字符串。{p_end}


{marker options}{...}
{title:选项}

{phang}
{cmd: {opt no:split}}: 选择是否有分割线。{p_end}

{title:示例}

{phang}
{stata `"percentencode 你好"'}
{p_end}

{title:作者}

{pstd}WILLIAM MATSUOKA{p_end}
{pstd}{browse "http://www.wmatsuoka.com/":作者个人网站}{p_end}

{title:Also see}
{phang}
{stata `"help percentencode"'}
{p_end}
{phang}
{stata `"help dict"'}
{p_end}