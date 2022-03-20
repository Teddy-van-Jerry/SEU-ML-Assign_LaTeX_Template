%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                    %%
%%                 seu-ml-assign.cls                  %%
%%                                                    %%
%% ================================================== %%
%%                                                    %%
%% Version:     1.1 (2022/03/21)                      %%
%% Author:      Teddy van Jerry (Wuqiong Zhao)        %%
%% License:     MIT LICENSE                           %%
%% GitHub Repo: https://tvj.one/ml-tex                %%
%% Compiler:    pdflatex, xelatex, lualatex           %%
%%                                                    %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{seu-ml-assign}[2022/02/21 SEU Machine Learning Assignment Template]

%% Class and Options
\def\@@ptsize{10pt} % font size
\DeclareOption{9pt}{\def\@@ptsize{9pt}}
\DeclareOption{10pt}{\def\@@ptsize{10pt}}
\DeclareOption{11pt}{\def\@@ptsize{11pt}}
\DeclareOption{12pt}{\def\@@ptsize{12pt}}
\def\@@solutionmode{1} % default as the solution mode
\DeclareOption{solution}{\def\@@solutionmode{1}} % solution mode
\DeclareOption{problem}{\def\@@solutionmode{0}} % problem mode
\def\@twoside{0} % default as oneside
\DeclareOption{oneside}{\def\@twoside{0}} % one-side document
\DeclareOption{twoside}{\def\@twoside{1}} % two-side document
\ProcessOptions\relax
\LoadClass[a4paper,onecolumn,\@@ptsize]{article}

%% Page Settings
\RequirePackage[inner=2.0cm,outer=2.0cm,top=1.2cm,bottom=3.5cm]{geometry}
\newcommand{\firstfooteradditionalheight}{2em} % additional height for footer on the first page
\hfuzz=.5em % disable false positive of overfull \hbox

%% Document Propertities
\global\let\@assignno\@empty
\global\let\@semester\@empty
\global\let\@studentID\@empty
\global\let\@instructor\@empty
\global\let\@duedate\@empty
\global\let\@author\@empty
\global\let\@mainproblem\@empty
\newcommand{\assignno}[1]{\gdef\@assignno{#1}} % Assignment Number
\newcommand{\semester}[1]{\gdef\@semester{#1}} % Semester
\newcommand{\studentID}[1]{\gdef\@studentID{#1}} % Student ID
\newcommand{\instructor}[1]{\gdef\@instructor{#1}} % Instructor
\newcommand{\duedate}[1]{\gdef\@duedate{#1}} % Due Date of the Assignment
\newcommand{\mainproblem}[1]{\gdef\@mainproblem{#1}} % The main problem of the assignment

%% Fonts and Colors
\RequirePackage[T1]{fontenc}
\RequirePackage[usenames,dvipsnames]{xcolor}

%% TikZ Rule
\RequirePackage{tikz}
\usetikzlibrary{fadings, calc}
\newcommand{\tikzrule}[3][]{\tikz{\fill[#1] (0,0) rectangle (#2,#3);}}

%% Sections Settings
\RequirePackage[explicit]{titlesec} % explained in https://tex.stackexchange.com/a/292307/234654
% http://mirrors.ctan.org/macros/latex/contrib/titlesec/titlesec.pdf
\pgfdeclarelayer{background}
\pgfsetlayers{background,main}
\global\let\@problempts\@empty
\newcommand{\problempts}[1]{\gdef\@problempts{#1}} % Points of the Problem
\newcommand{\problemptsprint}{\ifx\@problempts\@empty\else(\@problempts~points)\fi}
\newcommand{\sectionheadname}{Problem} % Name for the Section (default as 'Problem')
% Reference: https://tex.stackexchange.com/a/12269/234654
\newcommand{\boxedsection}[3][blue!20]{{%
    \begin{tikzpicture}[inner sep=0pt, inner ysep=0.3ex]
        \node[anchor=base west] at (0,0) (counter) {#2};
        \path let \p1 = (counter.base east) in node[anchor=base west, text width={\textwidth-\x1-0.33em}] (content)
            at ($(counter.base east)+(0.33em,0)$) {#3};
        \begin{pgfonlayer}{background}
            \shade[left color=#1,right color=white] let \p1=(counter.north), \p2=(content.north) in
            (0,{max(\y1,\y2)}) rectangle (content.south east);
        \end{pgfonlayer}
    \end{tikzpicture}
}}
% \titleformat{<command>}
%     [<shape>]{<format>}{<label>}{<sep>}{<before-code>}[<after-code>]
\titleformat{\section}%   
    {\Large\bfseries}%
    {}%
    {0pt}%
    {\boxedsection{\sectionheadname{} \thesection:}{#1}}%
    [%
        \vspace{-2.1\baselineskip}\hfill{\normalfont\small\problemptsprint}%
        \problempts{}% clear the problem points
    ]%
\newcommand{\setproblem}[1]{\ifx#1\@empty\else\setcounter{section}{#1}\fi} % force the number of problem
\newcommand{\setsubproblem}[1]{\ifx#1\@empty\else\setcounter{subsection}{#1}\fi} % force the number of subproblem
\newcommand{\problem}[2][]{\problempts{#1}\section{#2}}%
\newcommand{\solutionname}{Solution}
\newcommand{\startsolution}[1][print]{%
    \setproblem{0}% reset the section counter
    \def\startsolutionprintoption{print}
    \def\startsolutionprintuseroption{#1}
    \ifx\startsolutionprintuseroption\startsolutionprintoption{%
        {%
            \fontfamily{LinuxLibertineT-OsF}\selectfont% select font as Linux Libertine
            \centering\LARGE\scshape%
            \solutionname{}\\[-0.2em]%
        }%
        \noindent%
        \tikzrule[WildStrawberry, path fading=west]{.5\textwidth}{.2em}% <-- Do not remove this
        \tikzrule[WildStrawberry, path fading=east]{.5\textwidth}{.2em}
    }\fi%
}
\titlespacing*{\section}{0em}{2.5\baselineskip}{1\baselineskip}
\titleformat{\subsection}[runin]{\large\bfseries}{}{0pt}{(\arabic{subsection}) #1}%
\newcommand{\subproblem}[2][]{\subsection[#1]{#2}}
\titleformat{\subsubsection}[runin]{}{}{0pt}{(\arabic{subsubsection}. #1}

%% Maths Settings
\RequirePackage{mathtools}
\RequirePackage{amssymb}
\RequirePackage{amsthm} % proof environment and others
\RequirePackage{bm} % \bm command
\RequirePackage{nicematrix}
\numberwithin{equation}{section}

%% Code Block Settings
\RequirePackage{listings}
\definecolor{dkgreen}{rgb}{0,0.5,0}
\definecolor{gray}{rgb}{0.5,0.5,0.5}
\definecolor{mauve}{rgb}{0.58,0,0.82}
\lstset{
    numbers=left,  
    frame=tb,
    aboveskip=3mm,
    belowskip=3mm,
    showstringspaces=false,
    columns=fixed,
    framerule=1pt,
    rulecolor=\color{gray!35},
    backgroundcolor=\color{gray!5},
    basicstyle={\ttfamily\small},
    numberstyle=\footnotesize\color{gray},
    keywordstyle=\bfseries\color{blue},
    commentstyle=\color{dkgreen},
    stringstyle=\color{mauve},
    breaklines=true,
    breakatwhitespace=true,
    tabsize=2,
    extendedchars=false,
    postbreak=\mbox{\hspace{-1.4em}\textcolor{purple}{$\hookrightarrow$}\space}
}

%% Captions Settings
\RequirePackage[font=footnotesize,labelfont=bf]{caption}

%% Color Boxes
\RequirePackage[many]{tcolorbox}
\RequirePackage{varwidth}
\newtcolorbox{fancybox}[2][]{enhanced,skin=enhancedlast jigsaw,
    attach boxed title to top left={xshift=-4mm,yshift=-0.5mm},
    fonttitle=\bfseries\sffamily,varwidth boxed title=0.7\linewidth,
    colbacktitle=blue!45!white,colframe=red!50!black,
    interior style={top color=blue!10!white,bottom color=red!10!white},
    boxed title style={empty,arc=0pt,outer arc=0pt,boxrule=0pt},
    underlay boxed title={
        \fill[blue!45!white] (title.north west) -- (title.north east)
        -- +(\tcboxedtitleheight-1mm,-\tcboxedtitleheight+1mm)
        -- ([xshift=4mm,yshift=0.5mm]frame.north east) -- +(0mm,-1mm)
        -- (title.south west) -- cycle;
        \fill[blue!45!white!50!black] ([yshift=-0.5mm]frame.north west)
        -- +(-0.4,0) -- +(0,-0.3) -- cycle;
        \fill[blue!45!white!50!black] ([yshift=-0.5mm]frame.north east)
        -- +(0,-0.3) -- +(0.4,0) -- cycle; },
    title={#2},#1
}
\newtcolorbox{notice}[2][]{enhanced,
    colframe=blue!50!black,colback=blue!10!white,colbacktitle=blue!5!yellow!10!white,
    fonttitle=\bfseries,coltitle=black,attach boxed title to top center=
    {yshift=-0.25mm-\tcboxedtitleheight/2,yshifttext=2mm-\tcboxedtitleheight/2},
    boxed title style={boxrule=0.5mm,
    frame code={ \path[tcb fill frame] ([xshift=-4mm]frame.west)
    -- (frame.north west) -- (frame.north east) -- ([xshift=4mm]frame.east)
    -- (frame.south east) -- (frame.south west) -- cycle; },
    interior code={ \path[tcb fill interior] ([xshift=-2mm]interior.west)
    -- (interior.north west) -- (interior.north east)
    -- ([xshift=2mm]interior.east) -- (interior.south east) -- (interior.south west)
    -- cycle;} },
    title={#2},#1
}

%% Header and Footer
\RequirePackage{fancyhdr}
\RequirePackage[colorlinks=true,urlcolor=blue,linkcolor=purple,citecolor=red]{hyperref}
\setlength{\headheight}{52pt}
\setlength{\marginparwidth}{2cm}
\pagestyle{fancy}
\if\@twoside0
    \lhead{
        \fontfamily{LinuxLibertineT-OsF}\selectfont
        \if\@@solutionmode1
            \textsc{\@title~\@assignno} -- \@studentID~\@author
        \else
            \textsc{Machine Learning \@title~\@assignno}
        \fi
    }
    \rhead{\thepage}
    \renewcommand\headrule{\vspace{-0.7em}\tikzrule[BrickRed, path fading=east]{.5\textwidth}{0.3mm}}
\else
    \fancyhf{}
    \renewcommand\headrule{%
        \ifodd\thepage
            \vspace{-0.7em}\tikzrule[BrickRed, path fading=east]{.5\textwidth}{0.3mm}
        \else
            \vspace{-0.7em}\hfill\tikzrule[BrickRed, path fading=west]{.5\textwidth}{0.3mm}
        \fi
    }
    \fancyhead[LO]{
        \fontfamily{LinuxLibertineT-OsF}\selectfont
        \if\@@solutionmode1
            \textsc{\@title~\@assignno} -- \@studentID~\@author
        \else
            \textsc{Machine Learning \@title~\@assignno}
        \fi
        \renewcommand\headrule{\vspace{-0.7em}\tikzrule[BrickRed, path fading=east]{.5\textwidth}{0.3mm}}
    }
    \fancyhead[RE]{
        \fontfamily{LinuxLibertineT-OsF}\selectfont
        \textsc{Machine Learning \@title~\@assignno}
    }
    \fancyhead[LE,RO]{\thepage}
\fi

\cfoot{}
% header and footer style for the first page
\fancypagestyle{firstpage}{
    \renewcommand\headrule{}
    \lhead{}
    \rhead{}
    \cfoot{
        \fontfamily{LinuxLibertineT-OsF}\selectfont
        \vspace*{-\firstfooteradditionalheight}
        \vspace{-1.5em}
        \tikzrule[purple, path fading=west]{.5\textwidth}{.15em}% <-- Do not remove this
        \tikzrule[purple, path fading=east]{.5\textwidth}{.15em}

        \footnotesize\centering
        \if\@@solutionmode1
            This \MakeLowercase{\@title{}} is due \@duedate{} and the date of submission is \@date.
        \else
            This \MakeLowercase{\@title{}} is due \textbf{\@duedate{}} and the version of the problem set is \@date.
        \fi

        % LaTeX template information
        \LaTeX{} template for this \MakeLowercase{\@title{}} is \textit{SEU-ML-Assign}
        open source at \href{https://tvj.one/ml-tex}{tvj.one/ml-tex} under the MIT License.
        E-mail \href{mailto:me@tvj.one}{me@tvj.one} for support. 
    }
}

%% Title Settings
\RequirePackage{tabularx}
\RequirePackage{afterpage}
\newcommand{\pdftitleadditionalname}{Solution}
\makeatletter         
\renewcommand\maketitle{

    \if\@@solutionmode0
        \ifx\@instructor\@empty
            \let\@instructor\@author % author is the instructor (if not specified)
        \else
            \ifx\@author\@empty
                \let\@author\@instructor % instructor is the author (if not specified)
            \fi
        \fi
    \fi

    \thispagestyle{firstpage}
    \fontfamily{LinuxLibertineT-OsF}\selectfont % set font as Linux Libertine
    \enlargethispage{-\firstfooteradditionalheight} % make room for the footer
    \begin{minipage}{10.5cm}
        \centering
        {
            \fontsize{36}{48}\selectfont
            \textcolor{Plum}{\scshape Machine Learning}
        }\\[.5em]
        {
            \if\@@solutionmode1
                \@studentID~\@author
                \qquad
            \fi
            \textit{Instructor:~\@instructor}
        }
    \end{minipage}
    \begin{minipage}{5cm}
        \vspace{0.7em}
        \centering
        {
            \large
            \textcolor{BrickRed}{\sffamily \@semester}
            \vspace{2mm}
        }
        \LARGE\@title~{\fontfamily{bch}\selectfont\@assignno}
    \end{minipage}
    \\[.3em]
    \tikzrule[cyan, path fading=east]{\textwidth}{.4em}

    \ifx\@mainproblem\@empty
        \vspace{2mm}
    \else
        \begin{center}
            \vspace{-1\baselineskip}\color{RoyalPurple!50!black}
            \LARGE\S~\@mainproblem~\S
        \end{center}
    \fi

    \fontfamily{cmr}\selectfont % Computer Modern

    % Set up document meta data
    % Note that it should be placed here because
    % by now \@author and \@title have been set.
    \hypersetup{
        pdfauthor={\@author},
        pdftitle={%
            \@title~\@assignno~
            \if\@@solutionmode1
                \pdftitleadditionalname{}
            \fi
            - Machine Learning
        },
        pdfsubject={Machine Learning},
        pdfkeywords={%
            Machine Learning, \@title%
            \ifx\@mainproblem\@empty\else%
                , \@mainproblem
            \fi
        },
        pdfcreator={LaTeX with SEU-ML-Assign class},
        pdfproducer={LaTeX}
    }
}
\makeatother
