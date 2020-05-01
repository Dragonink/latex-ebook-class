\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ebook}[2020/04/21 Dragonink's custom Ebook class v1.1.0]
\LoadClass[12pt]{book}


%%%* PACKAGES
\RequirePackage{afterpage}%%* AfterPage
\RequirePackage{geometry}%%* Geometry
\RequirePackage[cm]{fullpage}%%* FullPage
\RequirePackage{pdfpages}%%* PDFPages
\RequirePackage[utf8]{inputenc}%%* InputEnc
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
\titleformat{\chapter}[frame]{\filcenter}{\LARGE\enspace\thechapter\enspace}{0pt}{\Huge\bfseries\filcenter#1\vspace{.4em}}
\titlespacing{\chapter}{0pt}{0pt}{3ex}
\let\old@chapter\chapter%
\newcommand*{\star@chapter}[2][\chaptername]{
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
\newcounter{display@section}[chapter]
\titleformat{\section}[block]{\filcenter}{\large\titlerule\enspace\thesection\enspace\titlerule\\*}{0pt}{\Large\bfseries\filcenter#1}
\titlespacing{\section}{0pt}{2ex}{0pt}
\titleclass{\notitle@section}{straight}[\chapter]
\newcounter{notitle@section}
\renewcommand*{\thenotitle@section}{\thesection}
\titleformat{\notitle@section}[block]{\filcenter}{\large\titlerule\enspace\thesection\enspace\titlerule}{0pt}{\relax}
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
\newlength{\chapterlabel}\settowidth{\chapterlabel}{\large\textsc{\chaptername} \textbf{VIII}}
\titlecontents{chapter}[0pt]{\large}{\contentspush{\framebox[\chapterlabel][c]{\thecontentslabel}} \textbf}{\hspace{\chapterlabel+2\fboxrule+\wordsep}\textbf}{\hfill\thecontentspage}
%* \section
\titlecontents{section}[\chapterlabel+2\fboxrule+\wordsep]{}{\,$\bullet$~~}{\,$\bullet$~~}{\titlerule*[1pc]{.}\thecontentspage}
\titlecontents{notitle@section}[\chapterlabel+2\fboxrule+\wordsep]{}{\,$\bullet$~~}{\,$\bullet$~~}{\titlerule*[1pc]{.}\thecontentspage}
%* \figure
\titlecontents{figure}[0pt]{\large}{\thecontentslabel~~$\bullet$~~}{}{\titlerule*[1pc]{.}\thecontentspage}
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
}
%* \author
\providecommand*{\@author}{\@empty}
\renewcommand*{\and}{,\space}
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
\newcommand*{\cover}[1]{
  \begin{titlepage}
    \illustration*{#1}{img:cover}
  \end{titlepage}
}
%* \tableofcontents
\renewcommand*{\tableofcontents}{
  \clearpage
  \begin{center}
    \Huge\bfseries\contentsname%
  \end{center}
  \vspace{3ex}
  \@starttoc{toc}
}
%* \listoffigures
\renewcommand*{\listoffigures}{
  \clearpage
  \begin{center}
    \Huge\bfseries\listfigurename%
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
%* \include
\let\old@include\include%
\renewcommand*{\include}[1]{
  \old@include{./chapters/#1}
}
%* \footnote
\counterwithin*{footnote}{page}
\renewcommand*{\thefootnote}{
  \textbf{\fnsymbol{footnote}}
}
%%* PDF metadata
\AtBeginDocument{
  \hypersetup{
    pdftitle={\@title},
    pdfauthor={\@author}
  }
}


%%%* OPTIONS
\DeclareOption{draft}{
  \overfullrule=2cm
  \PassOptionsToClass{\CurrentOption}{book}
}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessOptions\relax


\endinput
