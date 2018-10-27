%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% %% <UTF-8>
%% %% 北方民族大学硕士学位论文开题报告书LaTeX模板 
%% %% 建议采用等宽字体查看本文档
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% 模板标识
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{num}[2018/10/26 v1.0 NMUproposal document class]
%%%%% --------------------------------------------------------------------------------
%%
%%%%*************************** Declare Options **************************************
%%
%% end-user parameters, each option is declared by one declare option command
\newif\ifNMU@singlesided \NMU@singlesidedfalse
\DeclareOption{singlesided}{% enable single-sided printing
	\NMU@singlesidedtrue%
}
\newif\ifNMU@doublesided \NMU@doublesidedfalse
\DeclareOption{doublesided}{% enable double-sided printing
	\NMU@doublesidedtrue%
}
%% terminates all options processing
\ProcessOptions\relax
%%%%% --------------------------------------------------------------------------------
%%
%%%%*************************** Loadclass Infomation *********************************
%%
\ifNMU@doublesided% if double-sided printing enabled
\LoadClass[UTF8,a4paper,twoside,fntef,12pt]{ctexart}
\else% if double-sided printing isn't enabled
\LoadClass[UTF8,a4paper,oneside,fntef,12pt]{ctexart}
\fi
%%%%% --------------------------------------------------------------------------------
%%
%%%%***************************** Package Infomation *********************************
%%
%% color packages
\RequirePackage[usenames,dvipsnames,table]{xcolor}%
%% math packages
\RequirePackage{amsmath,amssymb,amstext}
\RequirePackage[includeheadfoot]{geometry}
\RequirePackage{setspace}     % 设置行间距
\usepackage{graphicx}
\usepackage{zref-abspage,zref-savepos}
\usepackage{atbegshi}
\usepackage{tikz}
\usepackage{fancyhdr} % 页眉页脚
\usepackage{multirow} % 单元格合并
\usepackage[colorlinks,linkcolor=black,anchorcolor=black,citecolor=black]{hyperref}% 超连接
\RequirePackage[sort&compress]{natbib}   % BibTex
\usepackage{fontawesome}     %可缩放的矢量图标
\usepackage{pifont}          %小铅笔符号
\RequirePackage{subcaption}   % 并排图形。subfigure、subfig与subcaption不兼容
\RequirePackage{algorithmic}  % 算法环境
\RequirePackage{algorithm2e}  % 算法环境
\RequirePackage{tikz}         % 流程图
\RequirePackage{listings}     % 代码环境
\RequirePackage{amsmath}      % 数学
%%%表格相关宏包
\RequirePackage{array}        % 表格处理必备宏包
\RequirePackage{booktabs}     % 表格上下粗线 
\RequirePackage{longtable}    % 长表格
\RequirePackage{multirow}     % 多行表格

%%%时间线相关宏包
\usepackage[utf8]{inputenc}
\usepackage[TS1,T1]{fontenc}
\usepackage{caption}
\newcommand{\foo}{\color{black}\makebox[0pt]{\textbullet}\hskip-0.5pt\vrule width 1pt\hspace{\labelsep}}

\usepackage{enumitem}
\AddEnumerateCounter{\chinese}{\chinese}{}

% 设置参考文献格式
\newcommand\bibstyle@super{\bibpunct{[}{]}{,}{s}{,}{\textsuperscript{,}}}
\newcommand\bibstyle@numbers{\bibpunct{[}{]}{,}{n}{,}{,}}
\newcommand\bibstyle@authoryear{\bibpunct{(}{)}{;}{a}{,}{,}}
\bibpunct{[}{]}{,}{n}{}{}
\setlength{\bibsep}{0pt}
\newcommand{\upcite}[1]{\textsuperscript{\cite{#1}}}
%%%%% --------------------------------------------------------------------------------
%%
%%%%******************************* Page Layout **************************************%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\geometry{top=22mm,bottom=18mm,left=30.5mm,right=26mm}
\geometry{headheight=7.7mm,headsep=4.3mm,footskip=7.9mm}
%% specifies the amount of space between paragraphs.
\setlength{\parskip}{0.5ex plus 0.25ex minus 0.25ex}
%% line spacing
\renewcommand{\baselinestretch}{1.3} % line space setting
\raggedbottom % prevent adding vertical white space in strange places
%%%%% --------------------------------------------------------------------------------
%%
%%%%***************************** Rectangle Frame *********************************
%%
\makeatletter

\newsavebox\oddpageframe
\newsavebox\evenpageframe
\newdimen\fb@yshift@dim
\newdimen\fb@bmargin@dim

\newdimen\framedboxsep
\framedboxsep=7pt

\AtBeginDocument{%
	\AtBeginShipout{\putpageframe}%
	\let\putpageframe\relax
	\fb@yshift@dim=\dimexpr\topmargin+\headheight+\headsep\relax
	\sbox\oddpageframe{%
		\tikz{%
			\useasboundingbox (\framedboxsep-\oddsidemargin,-\framedboxsep+\fb@yshift@dim);%
			\draw (0,0) rectangle (\textwidth+2\framedboxsep,-\textheight-2\framedboxsep);%
		}%
	}%
	\sbox\evenpageframe{%
		\tikz{%
			\useasboundingbox (\framedboxsep-\evensidemargin,-\framedboxsep+\fb@yshift@dim);%
			\draw (0,0) rectangle (\textwidth+2\framedboxsep,-\textheight-2\framedboxsep);%
		}%
	}%
	\fb@bmargin@dim=\dimexpr\paperheight-\fb@yshift@dim-\voffset-\AtBegShi@vorigin-\textheight\relax
}

\newcommand*\fb@putpageframe{%
	\AtBeginShipoutAddToBox{%
		\ifodd\value{page}%
		\usebox\oddpageframe
		\else
		\usebox\evenpageframe
		\fi
	}%
}
\newcommand*\fb@putfirstframe{%
	\ifnum\value{abspage}=\zref@extractdefault{\fb@currentlabel-b}{abspage}{0} %
	\fb@putfirstframe@
	\global\let\putpageframe\fb@putpageframe
	\fi
}
\newcommand*\fb@putfirstframe@{%
	\AtBeginShipoutAddToBox{%
		\dimen@=\dimexpr\zposy{\fb@currentlabel-b}sp-\fb@bmargin@dim+2\framedboxsep\relax
		\tikz{%
			\useasboundingbox(%
			\the\dimexpr\framedboxsep-\ifodd\c@page\oddsidemargin\else\evensidemargin\fi,
			\the\dimexpr\framedboxsep+\fb@yshift@dim+\textheight-\dimen@
			);%
			\draw (0,0) rectangle (\textwidth+2\framedboxsep, -\dimen@);%
		}%
	}%
}
\newcommand*\fb@cancelpageframe{%
	\ifdefined\fb@currentlabel
	\ifnum\value{abspage} > \zref@extractdefault{\fb@currentlabel-e}{abspage}{0} %
	\global\let\putpageframe\relax
	\else
	\fb@putpageframe
	\fi
	\else
	\global\let\putpageframe\relax
	\fi
}

\zref@require@unique
\zref@addprop{savepos}{abspage}

\newenvironment*{framedbox}{%
	\par
	\ifdim\pagetotal=\z@
	\global\let\putpageframe\fb@putpageframe
	\else
	\global\let\putpageframe\fb@putfirstframe
	\addvspace{2\framedboxsep}%
	\nointerlineskip
	\fi
	\global\advance\c@zref@unique\@ne
	\edef\fb@currentlabel{\thezref@unique}%
	\zsavepos{\fb@currentlabel-b}%
	\zifrefundefined{\fb@currentlabel-b}{\global\let\putpageframe\relax}{}%
	\nobreak
}{%
	\zsavepos{\fb@currentlabel-e}%
	\zref@ifrefundefined{\fb@currentlabel-e}{}{%
		\AtBeginShipoutNext{\global\let\putpageframe\fb@cancelpageframe}%
	}%
	\clearpage
}

%%%%% --------------------------------------------------------------------------------
%%
%%%%********************** Labels in Chinese Titlepage *******************************
%%
\def\NMU@label@author{\bfseries 报~~告~~人：}
\def\NMU@label@major{\bfseries 专 \qquad 业：}
\def\NMU@label@field{\bfseries 研究方向：}
\def\NMU@label@advisor{\bfseries 导 \qquad 师：}
\def\NMU@label@title{\bfseries 论文题目：}
\def\NMU@label@institute{\bfseries 系 \qquad 所：}
\def\NMU@label@date{\bfseries 填表时间：}
%%%%% --------------------------------------------------------------------------------
%%
%%%%********************* Some Style Control Commands ********************************
%% underline
\renewcommand{\CJKunderlinecolor}{\color[rgb]{0,0,0}}
\def\NMU@underline[#1]#2{%
	\CJKunderline{\hbox to #1{\hfill#2\hfill}}}
\def\NMUunderline{\@ifnextchar[\NMU@underline\CJKunderline}

\def\NMUtableline{\vspace{-12pt}  \hspace*{-32pt} \NMUunderline[450pt]{}}

\newcommand{\tabincell}[2]{\begin{tabular}{@{}#1@{}}#2\end{tabular}} % 单元格换行

% 流程图
\usetikzlibrary{arrows,shapes,chains}
%开始结束框
\tikzstyle{startstop} = [rectangle,rounded corners, minimum width=3cm,minimum height=1cm,text centered, draw=black]
%输入输出框
\tikzstyle{io} = [trapezium, trapezium left angle = 70,trapezium right angle=110,minimum width=3cm,minimum height=1cm,text centered,draw=black]
%进程框
\tikzstyle{process} = [rectangle,minimum width=3cm,minimum height=1cm,text centered,text width =3cm,draw=black]
%判断框
\tikzstyle{decision} = [diamond,minimum width=3cm,minimum height=1cm,text centered,draw=black]
%定义箭头
\tikzstyle{arrow} = [thick,->,>=stealth]

% 代码环境 frame=single无阴影
\lstset{numbers=left,
	basicstyle=\small\ttfamily,
	numberstyle=\tiny,
	keywordstyle=\color{black}\bfseries,
	commentstyle=\color{gray},
	frame=shadowbox,
	captionpos=b, 
	rulesepcolor=\color{red!20!green!20!blue!20},
	escapeinside=``,
	xleftmargin=2em,
	xrightmargin=2em, 
	aboveskip=1em}
%%%%% --------------------------------------------------------------------------------
%%
%%%%*********************  数学环境  ********************************
%%
% 数学符号：
\newcommand\eu{\mathrm{e}}
\newcommand\iu{\mathrm{i}}
\newcommand*{\diff}{\mathop{}\!\mathrm{d}}
\DeclareMathOperator*{\argmax}{arg\,max}
\DeclareMathOperator*{\argmin}{arg\,min}
% 数学公式编号
\renewcommand\theequation{\Roman{equation}}
%%%%% --------------------------------------------------------------------------------
%%
%%%%*********************  浮动体相关定义  ********************************
%%
% 设置浮动环境标题的字体大小。根据学位论文格式要求，插图和表格标题字体需要比正文
% 字体略小。
\captionsetup{%
	format=hang,
	labelsep=quad,		% 去掉图表号后的冒号。图序与图名文字之间空一个汉字宽度。
	skip=10pt,			% 标题与图标之间空10pt距离。
	font=small,			% 标题字体比正文小一号，这里取small。
	width=.75\textwidth}% 标题最大宽度为0.75倍正文宽度。

% 根据学位论文格式要求，表格的标题必须位于表格上方，插图的标题必须位于插图下方。
\captionsetup[table]{position=above}
\captionsetup[figure]{position=below}

%% 以下为设置浮动对象和文字之间的距离。
% 版心顶部或者版心底部浮动体之间的垂直距离，默认为12pt plus 2pt minus 2pt。
\setlength{\floatsep}{12bp \@plus4pt \@minus1pt}

% 文本行之间浮动体（使用h位置选项）与上下文之间的距离，默认为12pt plus 2pt minus
% 2pt。
\setlength{\intextsep}{12bp \@plus4pt \@minus2pt}

% 版心顶部或底部的浮动体与文本之间的距离，默认为12pt plus 2pt minus 2pt。
\setlength{\textfloatsep}{12bp \@plus4pt \@minus2pt}

% 浮动页中，版心顶部的浮动体与版心顶边之间的距离，默认为0pt plus 1fil。
\setlength{\@fptop}{0bp \@plus1.0fil}

% 浮动页中浮动体直接的距离，默认为8pt plus 2fil。
\setlength{\@fpsep}{8bp \@plus2.0fil}

% 浮动页中，版心底部的浮动体与版心底边之间的距离，默认为0pt plus 1fil。
\setlength{\@fpbot}{0bp \@plus1.0fil}

%% 下面这组命令使浮动对象的缺省值稍微宽松一点，从而防止幅度对象占据过多的文本页
%% 面，也可以防止在很大空白的浮动页上放置很小的图形。
% 默认情况下，LaTeX要求每页的文字至少占据 20%，否则该页就只单独放置一个浮动环境。
% 而这通常不是我们想要的。我们将这个要求降低到 5%。
\renewcommand{\textfraction}{0.05}
% 在一文本页中，被置于版心顶部的所有浮动体的高度与版心高度的最大比值，默认为0.7，
% 这里修改为0.7，任何造成高度超过版心高度70% 的浮动体都被将阻止置于当前版心顶部。
\renewcommand{\topfraction}{0.7}
% 同上，只不过变成了版心底部，默认为0.3.
\renewcommand{\bottomfraction}{0.5}
% 在任意一个“浮动页”中，所有的浮动体高度与版心的高度的最小比值，默认为 0.5，这里
% 设置成0.85。因此，浮动页中空白与版心的比值不会超过1-\floatpagefraction。
\renewcommand{\floatpagefraction}{0.0}

%设置“图1.1”、“表2.2”为“图1-1”、“表2-2”
\renewcommand {\thetable} {\arabic{table}}
\renewcommand {\thefigure} {\arabic{figure}}
%%%%% --------------------------------------------------------------------------------
%%
%%%%********************* Font Setting ********************************
%%
%=========宋体的中文加粗 =========
\setCJKfamilyfont{zhsong}[AutoFakeBold = {3}]{SimSun}
\renewcommand*{\songti}{\CJKfamily{zhsong}}

%=========设置字体=========
\XeTeXlinebreaklocale "zh"
\XeTeXlinebreakskip = 0pt plus 1pt minus 0.1pt
\usepackage{fontspec}
% Fonts
\newfontfamily\zhfont{SimSun}
\newfontfamily\zhpunctfont{SimSun}
\setmainfont{Times New Roman}
\usepackage{indentfirst}
\usepackage{zhspacing}
\setCJKmainfont{SimSun}
\zihao{-4}

%=========设置标题的格式=========
\ctexset{
	section={%节标题 : 四号宋体居左 
		format=\zihao{4} \raggedright,
		name = {,.},
		fixskip=true,
		beforeskip=0pt,
		afterskip=0pt,
	},
	subsection = {
		format =\zihao{-4} \raggedright,
		name = {（,）},
		number = \arabic{subsection},
		beforeskip = 1.0ex plus 0.2ex minus .2ex,
		afterskip = 1.0ex plus 0.2ex minus .2ex,
		aftername = \hspace{0pt}
	}
}
%%%%% --------------------------------------------------------------------------------
%%
%%%%********************** Chinese Titlepage Items ***********************************
%%
\newcommand\nmutitle[2]{%
	\def\NMU@value@sectitle{#2}	
	\def\NMU@value@title{#1}
}

\newcommand\advisor[2]{%
	\def\NMU@value@secadvisor{#2}
	\def\NMU@value@advisor{#1}}

\renewcommand\author[1]{\def\NMU@value@author{#1}}
\newcommand\major[1]{\def\NMU@value@major{#1}}
\newcommand\field[1]{\def\NMU@value@field{#1}}
\newcommand\institute[1]{\def\NMU@value@institute{#1}}
\newcommand\chinesedate[1]{\def\NMU@value@chinesedate{#1}}
%%%%% --------------------------------------------------------------------------------
%%
%%%%**************************** Make Titlepage ******************************
%%
\renewcommand\maketitle{%
	 %%%% 说明页
	\clearpage
	\thispagestyle{empty}
	\vspace*{0pt}
	\begin{center}      
	\includegraphics[scale=1.0]{proposal.pdf}
	
	\vspace*{160pt}
	
	\def\tabcolsep{1pt}
	\def\arraystretch{1.2}
	{\zihao{3}\songti \hspace{3em}
		\begin{tabular}{lp{10cm}}				
			{\NMU@label@author}    & \NMUunderline[256pt]{\NMU@value@author} \\			
			{\NMU@label@major}     & \NMUunderline[256pt]{\NMU@value@major} \\		
			{\NMU@label@field}     & \NMUunderline[256pt]{\NMU@value@field} \\			
			{\NMU@label@advisor}   & \NMUunderline[256pt]{\NMU@value@advisor} \\
	                               & \NMUunderline[256pt]{\NMU@value@secadvisor} \\				
			{\NMU@label@title}     & \NMUunderline[256pt]{\NMU@value@title} \\
	                               & \NMUunderline[256pt]{\NMU@value@sectitle} \\			
			{\NMU@label@institute} & \NMUunderline[256pt]{\NMU@value@institute} \\			
			{\NMU@label@date}      & \NMUunderline[256pt]{\NMU@value@chinesedate}
		\end{tabular}}		
		\vfill	
		\begin{tabular}{p{400pt}<{\centering}}
			{\zihao{-2} \bfseries \songti 北方民族大学研究生处制}  
		\end{tabular}		
	\end{center}
    \vspace{2ex}
    
	\clearpage	
	
	%%%% 说明页
	\thispagestyle{empty}
	\begin{center}
		{\heiti \zihao{-2} 开题报告填写要求}
	\end{center}

	\vspace*{8ex}
	
	{\songti \zihao{4}
		
		1.~~开题报告作为毕业论文答辩委员会对学生答辩资格审查的依据材料之一。此报告应在指导教师指导下，由学生在毕业论文工作前期内完成，经指导教师签署意见审查后生效。\\ \\
		
		2.~~学生查阅资料的参考文献应在20篇及以上（不包括辞典、手册），开题报告的字数要在3000字以上。\\ \\
		
		3.~~有关年月日等日期的填写，应当按照国标GB/T 7408—94《数据元和交换格式、信息交换、日期和时间表示法》规定的要求，一律用阿拉伯数字书写。如“2004年9月26日”或“2004-09-26”。
	}	
	\clearpage
		
	% 设置正文页眉
	\pagestyle{fancy}
	\def\headrule{}
	\lhead{} 
	\chead{\bfseries \zihao{-2} \songti 毕~~业~~论~~文~~开~~题~~报~~告 } % center header
	\rhead{} % empty right header
	\cfoot{\footnotesize\thepage}
}
%%%%% --------------------------------------------------------------------------------
\endinput
%% End of file
%%%%% --------------------------------------------------------------------------------
