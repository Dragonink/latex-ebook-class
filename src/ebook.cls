\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ebook}[2020/05/04 Dragonink's custom Ebook class v1.2.1]
\LoadClass{book}


%%%* OPTIONS
\DeclareOption{10pt}{\OptionNotUsed}
\DeclareOption{11pt}{\OptionNotUsed}
\DeclareOption{12pt}{
  \PassOptionsToClass{\CurrentOption}{book}
  \renewcommand{\normalsize}{\fontsize{12pt}{14.4pt}\selectfont}
  \renewcommand{\tiny}{\fontsize{8pt}{9.6pt}\selectfont}
  \renewcommand{\scriptsize}{\fontsize{9pt}{10.8pt}\selectfont}
  \renewcommand{\footnotesize}{\fontsize{10pt}{12pt}\selectfont}
  \renewcommand{\small}{\fontsize{11pt}{13.2pt}\selectfont}
  \renewcommand{\large}{\fontsize{14pt}{16.8pt}\selectfont}
  \renewcommand{\Large}{\fontsize{17pt}{20.4pt}\selectfont}
  \renewcommand{\LARGE}{\fontsize{20pt}{24pt}\selectfont}
  \renewcommand{\huge}{\fontsize{25pt}{30pt}\selectfont}
  \renewcommand{\Huge}{\fontsize{30pt}{36pt}\selectfont}
}
\DeclareOption{14pt}{
  \renewcommand{\normalsize}{\fontsize{14pt}{16.8pt}\selectfont}
  \renewcommand{\tiny}{\fontsize{9pt}{10.8pt}\selectfont}
  \renewcommand{\scriptsize}{\fontsize{10pt}{12pt}\selectfont}
  \renewcommand{\footnotesize}{\fontsize{11pt}{13.2pt}\selectfont}
  \renewcommand{\small}{\fontsize{12pt}{14.4pt}\selectfont}
  \renewcommand{\large}{\fontsize{17pt}{20.4pt}\selectfont}
  \renewcommand{\Large}{\fontsize{20pt}{24pt}\selectfont}
  \renewcommand{\LARGE}{\fontsize{25pt}{30pt}\selectfont}
  \renewcommand{\huge}{\fontsize{30pt}{36pt}\selectfont}
  \renewcommand{\Huge}{\fontsize{36pt}{43.2pt}\selectfont}
}
\DeclareOption{17pt}{
  \renewcommand{\normalsize}{\fontsize{17pt}{20.4pt}\selectfont}
  \renewcommand{\tiny}{\fontsize{10pt}{12pt}\selectfont}
  \renewcommand{\scriptsize}{\fontsize{11pt}{13.2pt}\selectfont}
  \renewcommand{\footnotesize}{\fontsize{12pt}{14.4pt}\selectfont}
  \renewcommand{\small}{\fontsize{14pt}{16.8pt}\selectfont}
  \renewcommand{\large}{\fontsize{20pt}{24pt}\selectfont}
  \renewcommand{\Large}{\fontsize{25pt}{30pt}\selectfont}
  \renewcommand{\LARGE}{\fontsize{30pt}{36pt}\selectfont}
  \renewcommand{\huge}{\fontsize{36pt}{43.2pt}\selectfont}
  \renewcommand{\Huge}{\fontsize{48pt}{57.6pt}\selectfont}
}
\DeclareOption{draft}{
  \overfullrule=2cm
  \PassOptionsToClass{\CurrentOption}{book}
}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ExecuteOptions{14pt}
\ProcessOptions\relax


%%%* PACKAGES
\RequirePackage[utf8]{inputenc}%%* InputEnc
\RequirePackage[T1]{fontenc}%%* FontEnc
\RequirePackage{lmodern}%%* LatinModern
\RequirePackage{geometry}%%* Geometry
\RequirePackage[cm]{fullpage}%%* FullPage
\RequirePackage{afterpage}%%* AfterPage
\RequirePackage{pdfpages}%%* PDFPages
\RequirePackage{babel}%%* Babel
\addto\captionsenglish{
  \renewcommand*{\contentsname}{Table of Contents}
  \renewcommand*{\listfigurename}{List of Illustrations}
  \providecommand*{\chaptername}{Chapter}
  \providecommand*{\sectionname}{Part}
  \providecommand*{\figurename}{Illustration}
}
\RequirePackage[autostyle=tryonce]{csquotes}%%* CSQuotes
\RequirePackage[loadonly,explicit,clearempty,newlinetospace]{titlesec}%%* TitleSec
%* \chapter
\titleclass{\chapter}[0]{top}
\newcounter{display@chapter}
\newcounter{display@section}[chapter]
\newlength{\width@chaptertitle}
\titleformat{\chapter}[frame]{\filcenter}{\LARGE\enspace\thechapter\enspace}{0pt}{\Huge\bfseries\filcenter#1\settowidth{\width@chaptertitle}{#1}\ifdim\width@chaptertitle<\textwidth\vspace{.3em}\fi}
\titlespacing{\chapter}{0pt}{0pt}{3ex}
\let\old@chapter\chapter%
\newcommand*{\star@chapter}[2][\chaptername]{
  \setcounter{display@section}{0}
  \renewcommand*{\thechapter}{\textsc{#1}}
  \old@chapter{#2}
}
\newcommand*{\std@chapter}[1]{
  \stepcounter{display@chapter}
  \renewcommand*{\thechapter}{\textsc{\chaptername} \textbf{\Roman{display@chapter}}}
  \old@chapter{#1}
}
\renewcommand*{\chapter}{\@ifstar\star@chapter\std@chapter}
%* \section
\titleclass{\section}{straight}[\chapter]
\counterwithout*{section}{chapter}
\titleformat{\section}[block]{\filcenter}{\large\titlerule\enspace\thesection\enspace\titlerule\\*}{0pt}{\Large\bfseries\filcenter#1}
\titlespacing{\section}{0pt}{2ex}{0pt}
\titleclass{\notitle@section}{straight}[\chapter]
\newcounter{notitle@section}
\renewcommand*{\thenotitle@section}{\thesection}
\titleformat{\notitle@section}[block]{\filcenter}{\large\titlerule\enspace\thesection\enspace\titlerule}{0pt}{\relax}
\titleformat{name=\notitle@section,numberless}[block]{\filcenter}{\relax}{0pt}{\large\titlerule\enspace\thesection\enspace\titlerule}
\titlespacing{\notitle@section}{0pt}{2ex}{0pt}
\let\old@section\section%
\let\old@notitle@section\notitle@section%
\renewcommand*{\notitle@section}[2][\@empty]{
  \ifx#1\@empty%
    \stepcounter{display@section}
    \renewcommand*{\thesection}{\textsc{\MakeLowercase\sectionname} \textbf{\oldstylenums\protect\arabic{display@section}}}
    \old@notitle@section{\sectionname\ \arabic{display@section}}
  \else
    \renewcommand*{\thesection}{\textsc{\MakeLowercase#1}}
    \old@notitle@section{#1}
  \fi
}
\newcommand*{\@@section}[2][\sectionname]{
  \stepcounter{display@section}
  \renewcommand*{\thesection}{\textsc{\MakeLowercase#1} \textbf{\oldstylenums\protect\arabic{display@section}}}
  \old@section{#2}
}
\renewcommand*{\section}{\@ifstar\notitle@section\@@section}
\RequirePackage{titletoc}%%* TitleToC
%* \chapter
\newlength{\width@chapterlabel}
\settowidth{\width@chapterlabel}{\large\textsc{\chaptername}\ \textbf{XVI}}
\titlecontents{chapter}[0pt]{}{\contentspush{\framebox[\width@chapterlabel]{\thecontentslabel}} \textbf}{\hspace{\width@chapterlabel+2\fboxsep+2\fboxrule+\wordsep}\textbf}{\hfill\thecontentspage}
%* \section
\titlecontents{section}[\width@chapterlabel+2\fboxsep+2\fboxrule]{\small}{\,$\bullet$~~}{\,$\bullet$~~}{\titlerule*[1pc]{.}\thecontentspage}
\titlecontents{notitle@section}[\width@chapterlabel+2\fboxsep+2\fboxrule]{\small}{\,$\bullet$~~}{\,$\bullet$~~}{\titlerule*[1pc]{.}\thecontentspage}
%* \figure
\titlecontents{figure}[0pt]{\small}{\thecontentslabel~~$\bullet$~~\normalsize}{}{\titlerule*[1pc]{.}\thecontentspage}
\RequirePackage[unicode=true,colorlinks=true,bookmarks=true,bookmarksopen=true,pdfdisplaydoctitle=true,pdfduplex=DuplexFlipLongEdge,pdfpagelayout=TwoPageRight]{hyperref}%%* HyperRef
\def\toclevel@chapter{0}
\def\toclevel@section{1}
\def\toclevel@notitle@section{1}


%%%* DECLARATIONS
%* \title
\newcounter{@series}
\newcommand*{\series}[1]{
  \newcommand*{\@series}{#1}
  \setcounter{@series}
}
\providecommand*{\@title}{\@empty}
\renewcommand*{\title}[1]{
  \ifx\@series\undefined%
    \renewcommand*{\@title}{#1}
  \else
    \renewcommand*{\@title}{(\@series\ \textemdash\ \arabic{@series}) #1}
  \fi
  \hypersetup{pdftitle={\@title}}
}
%* \author
\providecommand*{\@author}{\@empty}
\renewcommand*{\and}{,\space}
\renewcommand*{\author}[1]{
  \renewcommand*{\@author}{#1}
  \hypersetup{pdfauthor={\@author}}
}
%* \colortheme
\newif\ifdefined@colortheme
\defined@colorthemefalse
\newcommand*{\colortheme}[2]{
  \definecolor{@theme}{#1}{#2}
  \hypersetup{linkcolor=[#1]{#2}}
  \defined@colorthemetrue
}
\AtBeginDocument{
  \ifdefined@colortheme\relax\else
    \definecolor{@theme}{HTML}{000000}
  \fi
}
%* \illustration
\newif\ifset@landscape
\newcommand*{\star@illustration}[1]{
  \ifset@landscape
    \includepdf[landscape,picturecommand*={\label{#1}}]{./images/\illustration@src}
  \else
    \includepdf[picturecommand*={\label{#1}}]{./images/\illustration@src}
  \fi
}
\newcommand*{\std@illustration}[3][\figurename]{
  \def\arg@value{#1}
  \ifx\arg@value\figurename%
    \def\cnt{figure@@default}
  \else
    \def\cnt{figure@#1}
  \fi
  \expandafter\ifx\csname c@\cnt\endcsname\relax
    \newcounter\cnt%
  \fi
  \stepcounter\cnt%
  \renewcommand*{\thefigure}{\textsc{\MakeLowercase#1} \textbf{\oldstylenums\arabic{\cnt}}}
  \textcolor{@theme}{\hyperref[#3]{{\huge$\ast$}\hfill\emph{#2}\hfill{\huge$\ast$}}}
  \ifset@landscape
    \afterpage{\includepdf[landscape,addtolist={1,figure,#2,#3}]{./images/\illustration@src}}
  \else
    \afterpage{\includepdf[addtolist={1,figure,#2,#3}]{./images/\illustration@src}}
  \fi
}
\newcommand*{\@star@illustration}[2][\@empty]{
  \def\arg@value{#1}
  \def\arg@check{landscape}
  \ifx\arg@value\arg@check%
    \set@landscapetrue
  \else
    \set@landscapefalse
  \fi
  \def\illustration@src{#2}
  \star@illustration
}
\newcommand*{\@std@illustration}[2][\@empty]{
  \def\arg@value{#1}
  \def\arg@check{landscape}
  \ifx\arg@value\arg@check%
    \set@landscapetrue
  \else
    \set@landscapefalse
  \fi
  \def\illustration@src{#2}
  \std@illustration
}
\newcommand*{\illustration}{
  \@ifstar\@star@illustration\@std@illustration
}
%* \cover
\newif\ifused@cover
\AtBeginDocument{
  \used@coverfalse
}
\newcommand*{\cover}[1]{
  \ifused@cover
    \ClassWarning{ebook}{Command `\cover' used more than once.}{This instance will be ignored.}
  \else
    \begin{titlepage}
      \illustration*{#1}{img:cover}
    \end{titlepage}
    \used@covertrue
  \fi
}
%* \tableofcontents
\renewcommand*{\tableofcontents}{
  \clearpage
  \begin{center}
    {\huge\bfseries\contentsname}
  \end{center}
  \vspace{3ex}
  \@starttoc{toc}
}
%* \listoffigures
\renewcommand*{\listoffigures}{
  \clearpage
  \begin{center}
    {\huge\bfseries\listfigurename}
  \end{center}
  \vspace{3ex}
  \@starttoc{lof}
}
%* \mainmatter
\let\old@mainmatter\mainmatter%
\renewcommand*{\mainmatter}{
  \old@mainmatter%
  \parskip=\baselineskip%
}
%* \declarechapter
\newcommand*{\declarechapter}[1]{
  \include{./chapters/#1}
}
%* \footnote
\counterwithin*{footnote}{page}
\renewcommand*{\thefootnote}{
  \textbf{\fnsymbol{footnote}}
}
%* \backmatter
\let\old@backmatter\backmatter%
\newcommand*{\backmatter@section}[1]{
  \renewcommand*{\thesection}{\textsc{\MakeLowercase#1}}
  \old@notitle@section*{#1}
}
\renewcommand*{\backmatter}{
  \old@backmatter%
  \newpage\thispagestyle{empty}\mbox{}\newpage
  \renewcommand*{\chapter}{
    \setcounter{display@section}{0}
    \@ifstar{\old@chapter*}{\old@chapter*}
  }
  \renewcommand*{\section}{\@ifstar\backmatter@section\backmatter@section}
}


\endinput
