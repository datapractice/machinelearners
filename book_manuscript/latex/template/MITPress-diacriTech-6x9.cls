\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{MITPress-diacriTech-6x9}
              [2014/05/15 v1.0 Standard LaTeX document class for MIT Press - grid 7x9]
\newcommand\@ptsize{}
\newif\if@restonecol
\newif\if@titlepage
\@titlepagetrue
\newif\if@openright
\newif\if@mainmatter \@mainmattertrue
\if@compatibility\else
\DeclareOption{a4paper}
   {\setlength\paperheight {297mm}%
    \setlength\paperwidth  {210mm}}
\DeclareOption{a5paper}
   {\setlength\paperheight {210mm}%
    \setlength\paperwidth  {148mm}}
\DeclareOption{b5paper}
   {\setlength\paperheight {250mm}%
    \setlength\paperwidth  {176mm}}
\DeclareOption{letterpaper}
   {\setlength\paperheight {11in}%
    \setlength\paperwidth  {8.5in}}
\DeclareOption{legalpaper}
   {\setlength\paperheight {14in}%
    \setlength\paperwidth  {8.5in}}
\DeclareOption{executivepaper}
   {\setlength\paperheight {10.5in}%
    \setlength\paperwidth  {7.25in}}
\DeclareOption{landscape}
   {\setlength\@tempdima   {\paperheight}%
    \setlength\paperheight {\paperwidth}%
    \setlength\paperwidth  {\@tempdima}}
\fi
\if@compatibility
  \renewcommand\@ptsize{0}
\else
\DeclareOption{10pt}{\renewcommand\@ptsize{0}}
\fi
\DeclareOption{11pt}{\renewcommand\@ptsize{1}}
\DeclareOption{12pt}{\renewcommand\@ptsize{2}}
\if@compatibility\else
\DeclareOption{oneside}{\@twosidefalse \@mparswitchfalse}
\fi
\DeclareOption{twoside}{\@twosidetrue  \@mparswitchtrue}
\DeclareOption{draft}{\setlength\overfullrule{5pt}}
\if@compatibility\else
\DeclareOption{final}{\setlength\overfullrule{0pt}}
\fi
\DeclareOption{titlepage}{\@titlepagetrue}
\if@compatibility\else
\DeclareOption{notitlepage}{\@titlepagefalse}
\fi
\if@compatibility
\@openrighttrue
\else
\DeclareOption{openright}{\@openrighttrue}
\DeclareOption{openany}{\@openrightfalse}
\fi
\if@compatibility\else
\DeclareOption{onecolumn}{\@twocolumnfalse}
\fi
\DeclareOption{twocolumn}{\@twocolumntrue}
\DeclareOption{leqno}{\input{leqno.clo}}
\DeclareOption{fleqn}{\input{fleqn.clo}}
\DeclareOption{openbib}{%
  \AtEndOfPackage{%
   \renewcommand\@openbib@code{%
      \advance\leftmargin\bibindent
      \itemindent -\bibindent
      \listparindent \itemindent
      \parsep \z@
      }%
   \renewcommand\newblock{\par}}%
}

\let\if@envcntreset\iffalse%
\DeclareOption{envcountreset}{\let\if@envcntreset\iftrue}%
\let\if@envcntsame\iffalse%
\DeclareOption{envcountsame}{\let\if@envcntsame\iftrue}%
\let\if@envcntsect\iffalse%
\DeclareOption{envcountsect}{\let\if@envcntsect\iftrue}%

\let\PromoText=Z%

\DeclareOption{promotion}{\global\let\PromoText=Y}

\newcommand{\@timesfont}{0}
\DeclareOption{timesfont}{\renewcommand{\@timesfont}{1}}

\newcommand{\@dblspace}{0}
\DeclareOption{dblspace}{\renewcommand{\@dblspace}{1}}


\ExecuteOptions{10pt,twoside,onecolumn,final,openright}
\ProcessOptions
%\input{bk1\@ptsize.clo}
\setlength\lineskip{1\p@}
\setlength\normallineskip{1\p@}
\renewcommand\baselinestretch{}
\setlength\parskip{0\p@}% \@plus \p@
\@lowpenalty   51
\@medpenalty  151
\@highpenalty 301
\setcounter{topnumber}{2}
%\renewcommand\topfraction{.7}
\setcounter{bottomnumber}{3}
%\renewcommand\bottomfraction{.3}
\renewcommand\topfraction{.921}
\renewcommand\bottomfraction{.921}
\setcounter{totalnumber}{4}
\renewcommand\textfraction{.2}
\renewcommand\floatpagefraction{.5}
\setcounter{dbltopnumber}{2}
\renewcommand\dbltopfraction{.7}
\renewcommand\dblfloatpagefraction{.5}
\if@twoside
  \def\ps@headings{%
      \let\@oddfoot\@empty\let\@evenfoot\@empty
      \def\@evenhead{\thepage\hfil\slshape\leftmark}%
      \def\@oddhead{{\slshape\rightmark}\hfil\thepage}%
      \let\@mkboth\markboth
    \def\chaptermark##1{%
      \markboth {\MakeUppercase{%
        \ifnum \c@secnumdepth >\m@ne
          \if@mainmatter
            \@chapapp\ \thechapter. \ %
          \fi
        \fi
        ##1}}{}}%
    \def\sectionmark##1{%
      \markright {\MakeUppercase{%
        \ifnum \c@secnumdepth >\z@
          \thesection. \ %
        \fi
        ##1}}}}
\else
  \def\ps@headings{%
    \let\@oddfoot\@empty
    \def\@oddhead{{\slshape\rightmark}\hfil\thepage}%
    \let\@mkboth\markboth
    \def\chaptermark##1{%
      \markright {\MakeUppercase{%
        \ifnum \c@secnumdepth >\m@ne
          \if@mainmatter
            \@chapapp\ \thechapter. \ %
          \fi
        \fi
        ##1}}}}
\fi
\def\ps@myheadings{%
    \let\@oddfoot\@empty\let\@evenfoot\@empty
    \def\@evenhead{\thepage\hfil\slshape\leftmark}%
    \def\@oddhead{{\slshape\rightmark}\hfil\thepage}%
    \let\@mkboth\@gobbletwo
    \let\chaptermark\@gobble
    \let\sectionmark\@gobble
    }
  \if@titlepage
  \newcommand\maketitle{\begin{titlepage}%
  \let\footnotesize\small
  \let\footnoterule\relax
  \let \footnote \thanks
%  \null\vfil
%  \vskip 60\p@
%  \begin{center}%
%    {\LARGE \@title \par}%
   % \vskip 3em%
    {%\large
     \lineskip .75em%
      \begin{tabular}[t]{@{}l}%
        \@author
      \end{tabular}\par}%
%      \vskip 1.5em%
%    {\large \@date \par}%       % Set date in \large size.
%  \end{center}
  \par
  \@thanks
  \vfil\null
  \end{titlepage}%
  \setcounter{footnote}{0}%
  \global\let\thanks\relax
  \global\let\maketitle\relax
  \global\let\@thanks\@empty
  \global\let\@author\@empty
  \global\let\@date\@empty
  \global\let\@title\@empty
  \global\let\title\relax
  \global\let\author\relax
  \global\let\date\relax
  \global\let\and\relax
}
\else
\newcommand\maketitle{\par
  \begingroup
    \renewcommand\thefootnote{\@fnsymbol\c@footnote}%
    \def\@makefnmark{\rlap{\@textsuperscript{\normalfont\@thefnmark}}}%
    \long\def\@makefntext##1{\parindent 1em\noindent
            \hb@xt@1.8em{%
                \hss\@textsuperscript{\normalfont\@thefnmark}}##1}%
    \if@twocolumn
      \ifnum \col@number=\@ne
        \@maketitle
      \else
        \twocolumn[\@maketitle]%
      \fi
    \else
      \newpage
      \global\@topnum\z@   % Prevents figures from going at top of page.
      \@maketitle
    \fi
    \thispagestyle{plain}\@thanks
  \endgroup
  \setcounter{footnote}{0}%
  \global\let\thanks\relax
  \global\let\maketitle\relax
  \global\let\@maketitle\relax
  \global\let\@thanks\@empty
  \global\let\@author\@empty
  \global\let\@date\@empty
  \global\let\@title\@empty
  \global\let\title\relax
  \global\let\author\relax
  \global\let\date\relax
  \global\let\and\relax
}
\def\@maketitle{%
  \newpage
  \null
  \vskip 2em%
  \begin{center}%
  \let \footnote \thanks
    {\LARGE \@title \par}%
    \vskip 1.5em%
    {\large
      \lineskip .5em%
      \begin{tabular}[t]{c}%
        \@author
      \end{tabular}\par}%
    \vskip 1em%
    {\large \@date}%
  \end{center}%
  \par
  \vskip 1.5em}
\fi
\newcommand*\chaptermark[1]{}
\setcounter{secnumdepth}{6}
\newcounter {part}
\newcounter {apart}
\newcounter {chapter}
\newcounter {section}[chapter]
\newcounter {subsection}[section]
\newcounter {subsubsection}[subsection]
\newcounter {paragraph}[subsubsection]
\newcounter {subparagraph}[paragraph]
\newcounter {subsubparagraph}[subparagraph]
\newcounter {subsubsubparagraph}[subsubparagraph]

\renewcommand \thepart {\@Roman\c@part}
\renewcommand \theapart {\@Alph\c@part}
\renewcommand \thechapter {\@arabic\c@chapter}
\renewcommand \thesection {\thechapter.\@arabic\c@section}%
\renewcommand\thesubsection   {\thesection.\@arabic\c@subsection}
\renewcommand\thesubsubsection{\thesubsection.\@arabic\c@subsubsection}
\renewcommand\theparagraph    {\thesubsubsection.\@arabic\c@paragraph}
\renewcommand\thesubparagraph {\theparagraph.\@arabic\c@subparagraph}
\renewcommand\thesubsubparagraph {\thesubparagraph.\@arabic\c@subsubparagraph}
\renewcommand\thesubsubsubparagraph {\thesubsubparagraph.\@arabic\c@subsubsubparagraph}

\newcommand\@chapapp{\chaptername}

\def\@alphnum#1{\ifcase#1\or \myspacepartno{ONE}\or \myspacepartno{TWO}\or \myspacepartno{THREE}\or \myspacepartno{FOUR}\else\@ialphnum{#1}\fi}
\def\@ialphnum#1{\ifcase#1\or \or \or \or \or FIVE\or SIX\or SEVEN\or h\or i\or j\or
   k\or l\or m\or n\or o\or p\or q\or r\or s\or t\or u\or v\or w\or x\or y\or
   z\else\@ctrerr\fi}


\def\@alphnums#1{\ifcase#1\or \myspacepartno{One}\or \myspacepartno{Two}\or \myspacepartno{Three}\or \myspacepartno{Four}\else\@ialphnums{#1}\fi}
\def\@ialphnums#1{\ifcase#1\or \or \or \or \or Five\or Six\or Seven\or h\or i\or j\or
   k\or l\or m\or n\or o\or p\or q\or r\or s\or t\or u\or v\or w\or x\or y\or
   z\else\@ctrerr\fi}

\newcommand\thefigureint{I.\@arabic\c@figure}


\newcommand\frontmatter{%\let\@makeschapterhead\@makeschapterheadfrnt%
    \cleardoublepage
  \@mainmatterfalse
  \pagenumbering{roman}\pagestyle{fmheadings}}
\newcommand\mainmatter{%
    \cleardoublepage
  \@mainmattertrue
  \pagenumbering{arabic}
  \pagestyle{headings}
  }
\newcommand\backmatter{%
  \if@openright
    \clearemptydoublepage
  \else
    \clearpage
  \fi
  %\@mainmatterfalse  
  \pagestyle{bmheadings}}


\newcommand\part{%
  \if@openright
    \cleardoublepage
  \else
    \clearpage
  \fi
  \thispagestyle{plain}%
  \if@twocolumn
    \onecolumn
    \@tempswatrue
  \else
    \@tempswafalse
  \fi
  \null\vfil
  \secdef\@part\@spart}


\def\@rparthead{}

\def\@part[#1]#2{%
    \ifnum \c@secnumdepth >-2\relax%
      \refstepcounter{part}%
      \refstepcounter{apart}%
      \addcontentsline{toc}{part}{\hbox to 4pc{\thepart\hfill}#1}%
    \else
      \addcontentsline{toc}{part}{#1}%
    \fi
    \markboth{}{}%
    {%\centering
%     \interlinepenalty \@M
     \ifnum \c@secnumdepth >-2\relax
%       {{\fontsize{18}{18}\selectfont\sffamily\bfseries PART}
%       \nobreakspace{\fontsize{60}{60}\selectfont\sffamily\bfseries\thepart}}
%       \par
%       \vskip 20\p@
\begingroup\parindent=0pt\thispagestyle{empty}%
\par\removelastskip\vspace*{-297pt}\nointerlineskip%
{\rule{26pc}{2pt}}%
\par\removelastskip\vspace*{4.3pt}\nointerlineskip%
%\hskip-30.1pc
\begin{minipage}[t]{26pc}
\begin{minipage}[t]{4pc} 
\hbox to 4pc{{\fontsize{36}{36}\bfseries\selectfont\thepart}\vphantom{Ay}\hfill}%
\end{minipage}
%\hskip-4pc\hbox to 4pc{{\fontsize{36}{36}\bfseries\selectfont\thepart}\vphantom{Ay}\hfill}%
\par\removelastskip\vspace*{-27pt}\nointerlineskip%
\begin{minipage}[t]{22pc} 
{\hspace*{4pc}\parbox{22pc}{{\fontsize{11}{13}\bfseries\selectfont\raggedright \uppercase{#2}\par}}}
\end{minipage}
\end{minipage}
\removelastskip\nointerlineskip\vspace*{43.6bp}\nointerlineskip%
\endgroup%
     \fi
     %\Huge \bfseries #2\par
     }\gdef\@rparthead{#2}%
     \@endpart}




\def\@spart#1{%
    {\centering
     \interlinepenalty \@M
     \normalfont
     \Huge \bfseries #1\par}%
    \@endpart}
\def\@endpart{\vfil\newpage
              \if@twoside
               \if@openright
                \null
                \thispagestyle{empty}%
                \newpage
               \fi
              \fi
              \if@tempswa
                \twocolumn
              \fi}
\newcommand\chapter{\if@openright\clearemptydoublepage%\cleardoublepage
\else\clearpage\fi%
                    \thispagestyle{plain}%
                    \global\@topnum\z@
                    \@afterindentfalse
                    \secdef\@chapter\@schapter}
\def\@chapter[#1]#2{\ifnum \c@secnumdepth >\m@ne
                       \if@mainmatter
                         \refstepcounter{chapter}%
                         \typeout{\@chapapp\space\thechapter.}%
                         \addcontentsline{toc}{chapter}%
                                   {\protect\numberline{\thechapter}#1}%
                       \else
                         \addcontentsline{toc}{chapter}{#1}%
                       \fi
                    \else
                      \addcontentsline{toc}{chapter}{#1}%
                    \fi
                    \chaptermark{#1}%
                    \addtocontents{lof}{\protect\addvspace{10\p@}}%
                    \addtocontents{lot}{\protect\addvspace{10\p@}}%
                    \if@twocolumn
                      \@topnewpage[\@makechapterhead{#2}]%
                    \else
                      \@makechapterhead{#2}%
                      \@afterheading
                    \fi}
\def\@makechapterhead#1{%
  \vspace*{50\p@}%
  {\parindent \z@ \raggedright \normalfont
    \ifnum \c@secnumdepth >\m@ne
      \if@mainmatter
        {\fontsize{12}{14}\selectfont\sffamily\bfseries \@chapapp}\space{\fontsize{48}{48}\selectfont\sffamily\bfseries \thechapter}
        \par\break%
        \vskip 20\p@
      \fi
    \fi
    \interlinepenalty\@M
    \fontsize{18}{26}\selectfont \sffamily\bfseries #1\par\nobreak
    \vskip 40\p@
  }}
\def\@schapter#1{\if@twocolumn 
                   \@topnewpage[\@makeschapterhead{#1}]%
                 \else
                   \@makeschapterhead{#1}%
                   \@afterheading
                 \fi}
\def\@makeschapterhead#1{%
  \vspace*{50\p@}%
  {\parindent \z@ \raggedright
    \normalfont
    \interlinepenalty\@M
    \Huge \bfseries  #1\par\nobreak
    \vskip 40\p@
  }}
\newcommand\section{\@startsection {section}{1}{\z@}%
                                   {-3.5ex \@plus -1ex \@minus -.2ex}%
                                   {2.3ex \@plus.2ex}%
                                   {\normalfont\Large\bfseries}}
\newcommand\subsection{\@startsection{subsection}{2}{\z@}%
                                     {-3.25ex\@plus -1ex \@minus -.2ex}%
                                     {1.5ex \@plus .2ex}%
                                     {\normalfont\large\bfseries}}
\newcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
                                     {-3.25ex\@plus -1ex \@minus -.2ex}%
                                     {1.5ex \@plus .2ex}%
                                     {\normalfont\normalsize\bfseries}}
\newcommand\paragraph{\@startsection{paragraph}{4}{\z@}%
                                    {3.25ex \@plus1ex \@minus.2ex}%
                                    {-1em}%
                                    {\normalfont\normalsize\bfseries}}
\newcommand\subparagraph{\@startsection{subparagraph}{5}{\parindent}%
                                       {3.25ex \@plus1ex \@minus .2ex}%
                                       {-1em}%
                                      {\normalfont\normalsize\bfseries}}

\newcommand\subsubparagraph{\@startsection{subparagraph}{6}{\parindent}%
                                       {3.25ex \@plus1ex \@minus .2ex}%
                                       {-1em}%
                                      {\normalfont\normalsize\bfseries}}





\setlength\leftmargini{7bp}
\leftmargin  \leftmargini
\setlength\leftmarginii  {2.2em}
\setlength\leftmarginiii {1.87em}
\setlength\leftmarginiv  {1.7em}
\if@twocolumn
  \setlength\leftmarginv  {.5em}
  \setlength\leftmarginvi {.5em}
\else
  \setlength\leftmarginv  {1em}
  \setlength\leftmarginvi {1em}
\fi
\setlength\labelsep {5pt}
\setlength\labelwidth{\leftmargini}
\addtolength\labelwidth{-\labelsep}
\@beginparpenalty -\@lowpenalty
\@endparpenalty   -\@lowpenalty
\@itempenalty     -\@lowpenalty
\renewcommand\theenumi{\@arabic\c@enumi}
\renewcommand\theenumii{\@alph\c@enumii}
\renewcommand\theenumiii{\@roman\c@enumiii}
\renewcommand\theenumiv{\@Alph\c@enumiv}
\newcommand\labelenumi{\theenumi.}
\newcommand\labelenumii{\theenumii.}
\newcommand\labelenumiii{\theenumiii.}
\newcommand\labelenumiv{\theenumiv.}
\renewcommand\p@enumii{\theenumi}
\renewcommand\p@enumiii{\theenumi(\theenumii)}
\renewcommand\p@enumiv{\p@enumiii\theenumiii}
\newcommand\labelitemi{\textbullet}
\newcommand\labelitemii{\normalfont\bfseries \textendash}
\newcommand\labelitemiii{\textasteriskcentered}
\newcommand\labelitemiv{\textperiodcentered}
\newenvironment{description}
               {\list{}{\labelwidth\z@ \itemindent-\leftmargin
                        \let\makelabel\descriptionlabel}}
               {\endlist}
\newcommand*\descriptionlabel[1]{\hspace\labelsep
                                \normalfont\bfseries #1}


\newenvironment{UNL}
               {\list{}{\topsep=10pt%
               \listparindent0pt%
                        \itemindent30pt%
                        \labelsep=10pt%
                        \rightmargin0pt%
                        \leftmargin0pt%
                        \parsep0pt}%
                \item\relax}
               {\endlist}


\newenvironment{verse}
               {\let\\\@centercr
                \list{}{\itemsep      \z@
                        \itemindent   -1.5em%
                        \listparindent\itemindent
                        \rightmargin  \leftmargin
                        \advance\leftmargin 1.5em}%
                \item\relax}
               {\endlist}
\newenvironment{quotation}
               {\list{}{\listparindent 1.5em%
                        \itemindent    \listparindent
                        \rightmargin   \leftmargin
                        \parsep        \z@ \@plus\p@}%
                \item\relax}
               {\endlist}
\newenvironment{quote}
               {\list{}{\rightmargin\leftmargin}%
                \item\relax}
               {\endlist}
\if@compatibility
\newenvironment{titlepage}
    {%
%      \cleardoublepage
      \if@twocolumn
        \@restonecoltrue\onecolumn
      \else
        \@restonecolfalse%\newpage
      \fi
      \thispagestyle{empty}%
      \setcounter{page}\z@
    }%
    {\if@restonecol\twocolumn \else \newpage \fi
    }
\else
\newenvironment{titlepage}
    {%
%      \cleardoublepage
      \if@twocolumn
        \@restonecoltrue\onecolumn
      \else
        \@restonecolfalse%\newpage
      \fi
    %  \thispagestyle{empty}%
      \setcounter{page}\@ne
    }%
    {\if@restonecol\twocolumn \else %\newpage 
    \fi
     \if@twoside\else
     %   \setcounter{page}\@ne
     \fi
    }
\fi
\newcommand\appendix{\fontsize{8}{9}\selectfont%\par
%  \setcounter{chapter}{0}%
  \setcounter{section}{0}%
  \gdef\@chapapp{\appendixname}%
  \gdef\thechapter{\@Alph\c@chapter}
\renewcommand\theequation
  {\ifnum \c@chapter>\z@\fi \@arabic\c@equation}
\let\extract\appextract}



\newenvironment{appendices}
               {\appendix\list{}{\fontsize{8}{9}\selectfont\listparindent9pt\rightmargin0pt\leftmargin0pt}%
                \item\relax}
               {\endlist}





\setlength\arraycolsep{5\p@}
\setlength\tabcolsep{10\p@}
\setlength\arrayrulewidth{0.5\p@}
\setlength\doublerulesep{2\p@}
\setlength\tabbingsep{\labelsep}
\skip\@mpfootins = \skip\footins
\setlength\fboxsep{3\p@}
\setlength\fboxrule{.4\p@}
\@addtoreset {equation}{chapter}
\renewcommand\theequation
  {\ifnum \c@chapter>\z@ \thechapter.\fi \@arabic\c@equation}
\newcounter{figure}[chapter]
\renewcommand \thefigure
     {\ifnum \c@chapter>\z@ \thechapter.\fi \@arabic\c@figure}
\def\fps@figure{tbp}
\def\ftype@figure{1}
\def\ext@figure{lof}
\def\fnum@figure{\figurename~\thefigure}
\newenvironment{figure}
               {\let\@makecaption\@makefigurecaption\@float{figure}}
               {\end@float}
\newenvironment{figure*}
               {\let\@makecaption\@makefigurecaption\@dblfloat{figure}}
               {\end@dblfloat}

\newenvironment{mfigure}
               {\let\@makecaption\@makefigurecaptionmar\@float{figure}}
               {\end@float\figcapwidth{\textwidth}}


\newcounter{table}[chapter]
\renewcommand \thetable
     {\ifnum \c@chapter>\z@ \thechapter.\fi \@arabic\c@table}
\def\fps@table{tbp}
\def\ftype@table{2}
\def\ext@table{lot}
\def\fnum@table{\tablename\nobreakspace\thetable}%\nobreakspace

\newenvironment{table}
               {\let\@makecaption\@maketablecaption\@float{table}}
               {\end@float}


\newenvironment{table*}
               {\let\@makecaption\@maketablecaption\@dblfloat{table}}
               {\end@dblfloat}
\newlength\abovecaptionskip
\newlength\belowcaptionskip
\setlength\abovecaptionskip{10\p@}
\setlength\belowcaptionskip{0\p@}
\long\def\@makecaption#1#2{%
  \vskip\abovecaptionskip
  \sbox\@tempboxa{#1: #2}%
  \ifdim \wd\@tempboxa >\hsize
    #1: #2\par
  \else
    \global \@minipagefalse
    \hb@xt@\hsize{\hfil\box\@tempboxa\hfil}%
  \fi
  \vskip\belowcaptionskip}

\DeclareOldFontCommand{\rm}{\normalfont\rmfamily}{\mathrm}
\DeclareOldFontCommand{\sf}{\normalfont\sffamily}{\mathsf}
\DeclareOldFontCommand{\tt}{\normalfont\ttfamily}{\mathtt}
\DeclareOldFontCommand{\bf}{\normalfont\bfseries}{\mathbf}
\DeclareOldFontCommand{\it}{\normalfont\itshape}{\mathit}
\DeclareOldFontCommand{\sl}{\normalfont\slshape}{\@nomath\sl}
\DeclareOldFontCommand{\sc}{\normalfont\scshape}{\@nomath\sc}
\DeclareRobustCommand*\cal{\@fontswitch\relax\mathcal}
\DeclareRobustCommand*\mit{\@fontswitch\relax\mathnormal}
\newcommand\@pnumwidth{1.55em}
\newcommand\@tocrmarg{2.55em}
\newcommand\@dotsep{4.5}
\setcounter{tocdepth}{2}
\newcommand\tableofcontents{\let\@makeschapterhead\@makeschapterheadcont\markboth{Contents}{Contents}%
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \chapter*{\contentsname}\par\removelastskip\vspace*{-15pt}\nointerlineskip%
    \@starttoc{toc}%
    \if@restonecol\twocolumn\fi
    \let\@makeschapterhead\@makeschapterheadorg}
\newcommand*\l@part[2]{%
  \ifnum \c@tocdepth >-2\relax
    \addpenalty{-\@highpenalty}%
    \addvspace{2.25em \@plus\p@}%
    \setlength\@tempdima{3em}%
    \begingroup
      \parindent \z@ \rightskip \@pnumwidth
      \parfillskip -\@pnumwidth
      {\leavevmode
       \large \bfseries #1\hfil \hb@xt@\@pnumwidth{\hss #2}}\par
       \nobreak
         \global\@nobreaktrue
         \everypar{\global\@nobreakfalse\everypar{}}%
    \endgroup
  \fi}
\newcommand*\l@chapter[2]{%
  \ifnum \c@tocdepth >\m@ne
    \addpenalty{-\@highpenalty}%
    \vskip 1.0em \@plus\p@
    \setlength\@tempdima{1.5em}%
    \begingroup
      \parindent \z@ \rightskip \@pnumwidth
      \parfillskip -\@pnumwidth
      \leavevmode \bfseries
      \advance\leftskip\@tempdima
      \hskip -\leftskip
      #1\nobreak\hfil \nobreak\hb@xt@\@pnumwidth{\hss #2}\par
      \penalty\@highpenalty
    \endgroup
  \fi}
\newcommand*\l@section{\@dottedtocline{1}{1.5em}{2.3em}}
\newcommand*\l@subsection{\@dottedtocline{2}{3.8em}{3.2em}}
\newcommand*\l@subsubsection{\@dottedtocline{3}{7.0em}{4.1em}}
\newcommand*\l@paragraph{\@dottedtocline{4}{10em}{5em}}
\newcommand*\l@subparagraph{\@dottedtocline{5}{12em}{6em}}
\newcommand\listoffigures{%
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \chapter*{\listfigurename}%
      \@mkboth{\listfigurename}%
              {\listfigurename}%
    \@starttoc{lof}%
    \if@restonecol\twocolumn\fi
%\addcontentsline{toc}{chapterast}{List of Figures}
    \clearemptydoublepage}
\newcommand*\l@figure{\@dottedtoclinefig{1}{0em}{2.3em}}

\def\@dottedtoclinefig#1#2#3#4#5{\ifnum #1>\c@tocdepth \else
  \vskip \z@% plus.2\p@
  {\leftskip #2\relax %\rightskip \@tocrmarg 
  \parfillskip -\rightskip
    \parindent #2\relax\@afterindenttrue
   \interlinepenalty\@M
   \leavevmode
   \@tempdima #3\relax \advance\leftskip \@tempdima \hbox{}\hskip -\leftskip
    #4\nobreak\leaders\hbox{$\m@th \mkern \@dotsep mu \mkern \@dotsep
       mu$}\hfill \nobreak
           %\hbox to\@pnumwidth{\hfil\reset@font\rm #5}
           \par}\fi\vskip3.5pt}



\newcommand\listoftables{%
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \chapter*{\listtablename}%
      \@mkboth{%
          \listtablename}%
         {\listtablename}%
    \@starttoc{lot}%
    \if@restonecol\twocolumn\fi
%\addcontentsline{toc}{chapterast}{List of Tables}
    \clearemptydoublepage}
\let\l@table\l@figure
\newdimen\bibindent
\setlength\bibindent{1.5em}


\newenvironment{thebibliography}[1]
     {\chapter*{\bibname}%
      \@mkboth{\MakeUppercase\bibname}{\MakeUppercase\bibname}%
      \list{\@biblabel{\@arabic\c@enumiv}}%
           {\settowidth\labelwidth{\@biblabel{#1}}%
            \leftmargin\labelwidth
            \advance\leftmargin\labelsep
            \@openbib@code
            \usecounter{enumiv}%
            \let\p@enumiv\@empty
            \renewcommand\theenumiv{\@arabic\c@enumiv}}%
      \sloppy
      \clubpenalty4000
      \@clubpenalty \clubpenalty
      \widowpenalty4000%
      \sfcode`\.\@m}
     {\def\@noitemerr
       {\@latex@warning{Empty `thebibliography' environment}}%
      \endlist}



\newcommand\newblock{\hskip .11em\@plus.33em\@minus.07em}
\let\@openbib@code\@empty
\newenvironment{theindex}
               {\if@openright
    \clearemptydoublepage
  \else
    \clearpage
  \fi
                 \if@twocolumn
                  \@restonecolfalse
                \else
                  \@restonecoltrue
                \fi
                \twocolumn[\@makeschapterhead{\indexname}]%
                \@mkboth{\MakeUppercase\indexname}%
                        {\MakeUppercase\indexname}%
                \thispagestyle{plain}\parindent\z@
                \parskip\z@ \@plus .3\p@\relax
                \columnseprule \z@
                \columnsep 35\p@
                \let\item\@idxitem}
               {\if@restonecol\onecolumn\clearemptydoublepage\else\clearemptydoublepage\fi}
\newcommand\@idxitem{\par\hangindent 40\p@}
\newcommand\subitem{\@idxitem \hspace*{20\p@}}
\newcommand\subsubitem{\@idxitem \hspace*{30\p@}}
\newcommand\indexspace{\par \vskip 10\p@ \@plus5\p@ \@minus3\p@\relax}
\renewcommand\footnoterule{%
%  \kern-3\p@
%  \hrule\@width.4\columnwidth
%  \kern2.6\p@
  }
\@addtoreset{footnote}{chapter}
\newcommand\@makefntext[1]{%
    \parindent 1em%
    \noindent
    \hb@xt@1.8em{\hss\@makefnmark}#1}
\newcommand\contentsname{Contents}
\newcommand\listfigurename{List of Figures}
\newcommand\listtablename{List of Tables}
\newcommand\bibname{Bibliography}
\newcommand\indexname{Index}
\newcommand\figurename{Figure}
\newcommand\tablename{Table}
\newcommand\partname{PART}
\newcommand\chaptername{Chapter}
\newcommand\appendixname{Appendix}
\def\today{\ifcase\month\or
  January\or February\or March\or April\or May\or June\or
  July\or August\or September\or October\or November\or December\fi
  \space\number\day, \number\year}
\setlength\columnsep{10\p@}
\setlength\columnseprule{0\p@}
\pagestyle{headings}
\pagenumbering{arabic}
\if@twoside
\else
  \raggedbottom
\fi
\if@twocolumn
  \twocolumn
  \sloppy
  \flushbottom
\else
  \onecolumn
\fi
\makeatletter

\def\normalsize{%
\@setfontsize\normalsize\@xpt{13}%
\abovedisplayskip 7\p@ \@plus3.5\p@ \@minus1.75\p@%
\abovedisplayshortskip \z@ \@plus3\p@%
\belowdisplayshortskip 4\p@ \@plus2\p@ \@minus1\p@%
\belowdisplayskip \abovedisplayskip%
\let\@listi\@listI%
}%

\normalsize
\newcommand\small{%
   \@setfontsize\small\@ixpt{11}%
   \abovedisplayskip 3\p@ \@plus1.5\p@ \@minus1\p@
   \abovedisplayshortskip \z@ \@plus2\p@
   \belowdisplayshortskip 2\p@ \@plus1\p@ \@minus0.5\p@
   \def\@listi{\leftmargin\leftmargini
%               \topsep 4\p@ \@plus2\p@ \@minus2\p@
%               \parsep 2\p@ \@plus\p@ \@minus\p@
%               \itemsep \parsep
            \itemindent\z@%
            \parsep\z@%
            \itemsep\z@%
            \topsep 7\p@%
               }%
   \belowdisplayskip \abovedisplayskip
}
\newcommand\footnotesize{%
   \@setfontsize\footnotesize\@viiipt{10}%
   \abovedisplayskip 2\p@ \@plus1\p@ \@minus0.5\p@
   \abovedisplayshortskip \z@ \@plus\p@
   \belowdisplayshortskip 1\p@ \@plus0.5\p@ \@minus0.25\p@
   \def\@listi{\leftmargin\leftmargini
%               \topsep 3\p@ \@plus\p@ \@minus\p@
%               \parsep 2\p@ \@plus\p@ \@minus\p@
%               \itemsep \parsep
            \itemindent\z@%
            \parsep\z@%
            \itemsep\z@%
            \topsep 7\p@%
}%
   \belowdisplayskip \abovedisplayskip
}
\newcommand\scriptsize{\@setfontsize\scriptsize\@viipt\@viiipt}
\newcommand\tiny{\@setfontsize\tiny\@vpt\@vipt}
\newcommand\large{\@setfontsize\large\@xiipt{14}}
\newcommand\Large{\@setfontsize\Large\@xivpt{18}}
\newcommand\LARGE{\@setfontsize\LARGE\@xviipt{22}}
\newcommand\huge{\@setfontsize\huge\@xxpt{25}}
\newcommand\Huge{\@setfontsize\Huge\@xxvpt{30}}

\setlength\parindent{10pt}%
\setlength\parskip{0pt}%

\setlength\smallskipamount{3\p@ \@plus 1\p@ \@minus 1\p@}
\setlength\medskipamount{6\p@ \@plus 2\p@ \@minus 2\p@}
\setlength\bigskipamount{12\p@ \@plus 4\p@ \@minus 4\p@}
\setlength\footskip{.35in}

\renewcommand\footnoterule{%
%  \kern-3\p@
%  \hrule\@width174bp\@height0.5bp%
%  \kern3.1\p@
  }

\long\def\@makefntext#1{%\@hangfrom
    \parindent 1em%
\noindent{\textsuperscript{\fontsize{7}{9}\selectfont\@thefnmark}}\fontsize{7}{9}\selectfont#1}%\hspace*{4pt}\raggedright

\def\footindent{\hspace*{1em}}

\setlength\footnotesep{9.3\p@}
\setlength{\skip\footins}{13.5\p@ \@plus 4\p@ \@minus 2\p@}
\setlength\floatsep    {12\p@ \@plus 2\p@ \@minus 2\p@}
\setlength\textfloatsep{26\p@ \@plus 2\p@ \@minus 4\p@}
\setlength\intextsep   {12\p@ \@plus 2\p@ \@minus 2\p@}
\setlength\dblfloatsep    {12\p@ \@plus 2\p@ \@minus 2\p@}
\setlength\dbltextfloatsep{26\p@ \@plus 2\p@ \@minus 4\p@}
\setlength\@fptop{0\p@}% \@plus 1fil
\setlength\@fpsep{8\p@ \@plus 2fil}
\setlength\@fpbot{0\p@ \@plus 1fil}
\setlength\@dblfptop{0\p@ \@plus 1fil}
\setlength\@dblfpsep{8\p@ \@plus 2fil}
\setlength\@dblfpbot{0\p@ \@plus 1fil}
\setlength\partopsep{0pt%2\p@ \@plus 1\p@ \@minus 1\p@
}
\def\@listi{\leftmargin\leftmargini
%            \parsep 4\p@ \@plus2\p@ \@minus\p@
%            \topsep 8\p@ \@plus2\p@ \@minus4\p@
%            \itemsep4\p@ \@plus2\p@ \@minus\p@
            \itemindent\z@%
            \parsep\z@%
            \itemsep\z@%
            \topsep 7\p@%
}
\let\@listI\@listi
\@listi
\def\@listii{\leftmargin\leftmarginii
              \labelwidth\leftmarginii
              \advance\labelwidth-\labelsep
%              \topsep    4\p@ \@plus2\p@ \@minus\p@
%              \parsep    2\p@ \@plus\p@  \@minus\p@
%              \itemsep   \parsep
            \itemindent\z@%
            \parsep\z@%
            \itemsep\z@%
            \topsep 7\p@%
}
\def\@listiii{\leftmargin\leftmarginiii
              \labelwidth\leftmarginiii
              \advance\labelwidth-\labelsep
%              \topsep    2\p@ \@plus\p@\@minus\p@
%              \parsep    \z@
%              \partopsep \p@ \@plus\z@ \@minus\p@
%              \itemsep   \topsep
            \itemindent\z@%
            \parsep\z@%
            \itemsep\z@%
            \topsep 3\p@%
}
\def\@listiv {\leftmargin\leftmarginiv
              \labelwidth\leftmarginiv
              \advance\labelwidth-\labelsep
            \itemindent\z@%
            \parsep\z@%
            \itemsep\z@%
            \topsep 3\p@%
}
\def\@listv  {\leftmargin\leftmarginv
              \labelwidth\leftmarginv
              \advance\labelwidth-\labelsep}
\def\@listvi {\leftmargin\leftmarginvi
              \labelwidth\leftmarginvi
              \advance\labelwidth-\labelsep}

\ifodd\@timesfont
\renewcommand\rmdefault{ptm}%
\renewcommand\sfdefault{phv}%
\renewcommand*\ttdefault{pcr}%
\usepackage{DIA-mfonts}%
\usepackage[OT1]{fontenc}
\RequirePackage[OT1,mtbold]{mathtime}
\else%
\fi%

\ifodd\@dblspace
\usepackage{setspace}
\usepackage[norule,splitrule]{footmisc}
\def\splitfootnoterule{\kern3\p@ \hrule\@width.48\columnwidth \kern1\p@}
\def\@makefnmarka{\hbox{{{\@thefnmark\enspace}}}}
\long\def\@makefntext#1{\leavevmode
    \@makefnmarka\nobreak
    %\hskip.5em
    \relax#1%
  }
\doublespacing
\long\def\@footnotetext#1{%
  \insert\footins{%
% GT:  Next line added.  Hook desired here!
\setstretch {1.5}
    \reset@font\footnotesize
    \interlinepenalty\interfootnotelinepenalty
    \splittopskip\footnotesep
    \splitmaxdepth \dp\strutbox \floatingpenalty \@MM
    \hsize\columnwidth
    \@parboxrestore
    \protected@edef\@currentlabel{%
      \csname p@footnote\endcsname\@thefnmark
    }%
    \color@begingroup
      \@makefntext{%
        \rule\z@\footnotesep\ignorespaces#1\@finalstrut\strutbox}%
    \color@endgroup}}
\else
\usepackage[norule,splitrule]{footmisc}
\def\splitfootnoterule{\kern3\p@ \hrule\@width.48\columnwidth \kern1\p@}
\def\@makefnmarka{\hbox{{{\@thefnmark\enspace}}}}
\long\def\@makefntext#1{\fontsize{8}{9}\selectfont\leavevmode
    \@makefnmarka\nobreak
    %\hskip.5em
    \relax#1%
  }
\fi

 

%\setlength\paperwidth{7truein}%
\setlength\paperwidth{6truein}%  6x9
\setlength\paperheight{9truein}%
\addtolength\paperwidth{.006truein}%
\addtolength\paperheight{.006truein}%

\setlength\oddsidemargin{175bp}%
\advance\oddsidemargin by -1truein%

%\addtolength\oddsidemargin{-53.6pt}%
\addtolength\oddsidemargin{-114pt}% 6x9

\setlength\evensidemargin{150bp}%
\advance\evensidemargin by -1truein%

%\addtolength\evensidemargin{-29pt}%
\addtolength\evensidemargin{-89.4pt}%6x9

\setlength\marginparwidth{76pt}%
\setlength\marginparpush{0pt}%
\setlength\marginparsep{20pt}%

\setlength\topmargin{36.4pt}%
\advance\topmargin by -1truein%

\setlength\topskip{0bp}%

\setlength\headheight{6.25bp}%
\setlength\headsep{52.5bp}%

\setlength\textwidth{26pc}%
\setlength\textheight{41pc}%




\newbox\RHeadbox%
\setbox\RHeadbox\hbox{\fontsize{9}{9}\bfseries\selectfont abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789}
%\showthe\ht\RHeadbox%


\usepackage{soul}

\sodef\myspacepart{}{.3em}{1em plus1em}{2em plus.1em minus.1em}% User-defined letter spacing
\sodef\myspacepartno{}{.08em}{1em plus1em}{2em plus.1em minus.1em}% User-defined letter spacing
\sodef\myspaceparttitle{}{.01em}{1em plus1em}{2em plus.1em minus.1em}% User-defined letter spacing

\sodef\rcharspace{}{.01em}{1em plus1em}{2em plus.1em minus.1em}% User-defined letter spacing

\sodef\ltdedi{}{.03em}{.5em}{2em}% User-defined letter spacing

\sodef\mytitlesp{}{.05em}{1em plus1em}{2em plus.1em minus.1em}% User-defined letter spacing

\sodef\myausp{}{.06em}{1em}{2em}% User-defined letter spacing

\sodef\mymitltsp{}{.07em}{1em}{2em}% User-defined letter spacing

%\ifx Y\PromoText
%\usepackage[cam,a4paper]{MIT-DIA-crop}
%\else
%\usepackage[cam,a4papernew]{MIT-DIA-crop}
%\voffset=36pt%
%\hoffset=36pt%
%\fi

%%%for 6x9
\ifx Y\PromoText
\usepackage[cam,a4paper6x9]{MIT-DIA-crop}
\else
\usepackage[cam,a4paper6x9m]{MIT-DIA-crop}
\voffset=36pt%
\hoffset=36pt%
\fi


\definecolor{grayfourty}{cmyk}{0,0,0,0.4}
\definecolor{grayseventy}{cmyk}{0,0,0,0.7}



%%6x9
  \def\ps@headings{%
      \let\@oddfoot\@empty\let\@evenfoot\@empty
      \def\@evenhead{\fontsize{9}{9}\selectfont\thepage\hfil\rightmark}%
      \def\@oddhead{\fontsize{9}{9}\selectfont{\leftmark}\hfil\thepage}%
      \let\@mkboth\markboth
    \def\chaptermark##1{%
      \markboth {{%
        \ifnum \c@secnumdepth >\m@ne
          \if@mainmatter
%            \@chapapp\ \thechapter\hspace*{10pt}%
          \fi
        \fi
        %##1
        \@rparthead
        }}{}}%
    \def\sectionmark##1{%
      \markright {{%
        \ifnum \c@secnumdepth >\z@
%          \thesection\hspace*{10pt}%
%            \@chapapp\ \thechapter%
Part~\thepart%
        \fi
        %##1
        }}}}

%6x9
  \def\ps@fmheadings{%
      \let\@oddfoot\@empty\let\@evenfoot\@empty
      \def\@evenhead{\fontsize{9}{9}\selectfont\thepage\hfil\rightmark}%
      \def\@oddhead{\fontsize{9}{9}\selectfont{\leftmark}\hfil\thepage}%
      \let\@mkboth\markboth
    \def\chaptermark##1{%
      \markboth {{%
        \ifnum \c@secnumdepth >\m@ne
          \if@mainmatter
%            \@chapapp\ \thechapter\hspace*{10pt}%
          \fi
        \fi
        ##1
        %\@rparthead
        }}{}}%
    \def\sectionmark##1{%
      \markright {{%
        \ifnum \c@secnumdepth >\z@
%          \thesection\hspace*{10pt}%
%            \@chapapp\ \thechapter%
Part~\thepart%
        \fi
        %##1
        }}}}


%6x9
  \def\ps@bmheadings{%
      \let\@oddfoot\@empty\let\@evenfoot\@empty
      \def\@evenhead{\fontsize{9}{9}\selectfont\thepage\hfil\rightmark}%
      \def\@oddhead{\fontsize{9}{9}\selectfont{\leftmark}\hfil\thepage}%
      \let\@mkboth\markboth
    \def\chaptermark##1{%
      \markboth {{%
        \ifnum \c@secnumdepth >\m@ne
          \if@mainmatter
            %\@chapapp\ \thechapter\hspace*{10pt}%
          \fi
        \fi
        \@rparthead%##1
        }}{}}%
    \def\sectionmark##1{%
      \markright {{%
        \ifnum \c@secnumdepth >\z@
%          \thesection\hspace*{10pt}%
Part~\thepart%
        \fi
%       ##1
        }}}}


  \def\ps@appheadings{%
      \let\@oddfoot\@empty\let\@evenfoot\@empty
      \def\@evenhead{\fontsize{9}{9}\selectfont\thepage\hfil\rightmark}%
      \def\@oddhead{\fontsize{9}{9}\selectfont{\leftmark}\hfil\thepage}%
      \let\@mkboth\markboth
    \def\chaptermark##1{%
      \markboth {{%
        \ifnum \c@secnumdepth >\m@ne
          \if@mainmatter
            %\@chapapp\ \thechapter\hspace*{10pt}%
          \fi
        \fi
        ##1}}{}}%
    \def\sectionmark##1{%
      \markright {{%
        \ifnum \c@secnumdepth >\z@
%          \thesection\hspace*{10pt}%
            \@chapapp\ \thechapter%
        \fi
%       ##1
        }}}}



\pagestyle{headings}
\frenchspacing%
\clubpenalty=10000%
\widowpenalty=10000%
\tolerance=10000%

\newcommand{\clearemptydoublepage}{\newpage{\pagestyle{empty}\cleardoublepage}}



\definecolor{defwhite}{cmyk}{0,0,0,0}


\def\@makechapterhead#1{\begingroup\parindent=0pt\thispagestyle{empty}%
\par\removelastskip\vspace*{-58.5pt}\nointerlineskip%
{\rule{26pc}{2pt}}%
\par\removelastskip\vspace*{4.3pt}\nointerlineskip%
\hbox to 4pc{{\fontsize{36}{36}\bfseries\selectfont\thechapter}\vphantom{Ay}\hfill}%
\par\removelastskip\vspace*{-27pt}\nointerlineskip%
\hspace*{4pc}\parbox{22pc}{{\fontsize{11}{13}\bfseries\selectfont\raggedright #1\par}}
\removelastskip\nointerlineskip\vspace*{43.6bp}\nointerlineskip%
\endgroup%
\ifx Y\PromoText
\AddToShipoutPictureBG*{%
\AtTextCenter{%
\makebox(0,0)[c]{\resizebox{\textwidth}{!}{%
\rotatebox{45}{\fontseries{b}\fontsize{53}{53}\selectfont\color{twentyfive}Promotional
Use}}} } }\else\fi
  \global\let\@title\@empty
  \global\let\title\relax
}


%%%FM

\newif\if@seriespages@provided 

\@seriespages@providedfalse


%6x9
\def\halftitle#1{\clearemptydoublepage\begingroup\parindent=0pt\thispagestyle{empty}%
\par\removelastskip\vspace*{-58.5pt}\nointerlineskip%
\noindent{\rule{26pc}{2pt}}%
\par\removelastskip\vspace*{4pt}\nointerlineskip%
\parbox{26pc}{{\fontsize{12}{14}\bfseries\selectfont\raggedright \uppercase{#1}\par}}
\removelastskip\nointerlineskip\vspace*{43.6bp}\nointerlineskip%
\endgroup}



\newenvironment{seriespage}
{\newpage\parindent=0pt\fontsize{10}{13}\selectfont\thispagestyle{empty}}
{}


\def\seriestitle#1{\begingroup\parindent=0pt%
%\par\removelastskip\vspace*{5pt}\nointerlineskip%
\parbox{26pc}{{\fontsize{10}{13}\selectfont\bfseries\raggedright {#1}\par}}
\removelastskip\nointerlineskip\vspace*{6pt}\nointerlineskip%
\endgroup}


\def\serieseditor#1{\begingroup\parindent=0pt%
%\par\removelastskip\vspace*{5pt}\nointerlineskip%
\parbox{26pc}{{\fontsize{10}{13}\selectfont\raggedright {#1}\par}}
\removelastskip\nointerlineskip\vspace*{1pt}\nointerlineskip%
\endgroup}


\def\seriesauthor#1{\begingroup\parindent=0pt%
\par\removelastskip\vspace*{4pt}\nointerlineskip%
\parbox{26pc}{{\fontsize{10}{13}\selectfont\normalfont\raggedright {#1}\par}}
\removelastskip\nointerlineskip\vspace*{1pt}\nointerlineskip%
\endgroup}

%6x9
\def\booktitle#1{\clearemptydoublepage\begingroup\parindent=0pt\thispagestyle{empty}%
\par\removelastskip\vspace*{-58.5pt}\nointerlineskip%
\noindent{\rule{26pc}{2pt}}%
\par\removelastskip\vspace*{4pt}\nointerlineskip%
\parbox{26pc}{{\fontsize{12}{14}\bfseries\selectfont\raggedright \uppercase{#1}\par}}
\removelastskip\nointerlineskip\vspace*{1pt}\nointerlineskip%
\endgroup}

\def\subtitle#1{\begingroup\parindent=0pt%
\par\removelastskip\vspace*{5pt}\nointerlineskip%
\parbox{26pc}{{\fontsize{11}{13}\selectfont\raggedright {#1}\par}}
\removelastskip\nointerlineskip\vspace*{1pt}\nointerlineskip%
\endgroup}


\def\edition#1{\begingroup\parindent=0pt%
\par\removelastskip\vspace*{11.5pt}\nointerlineskip%
\parbox{26pc}{{\fontsize{11}{13}\selectfont\raggedright {#1}\par}}
\removelastskip\nointerlineskip\vspace*{3pt}\nointerlineskip%
\endgroup}



\def\edauthor#1{\begingroup\parindent=0pt%
\par\removelastskip\vspace*{29pt}\nointerlineskip%
\parbox{26pc}{{\fontsize{11}{13}\selectfont\raggedright {#1}\par}}
\removelastskip\nointerlineskip\vspace*{3pt}\nointerlineskip%
\endgroup}


\def\MITimprint#1{\vfill\begingroup\parindent=0pt%
\par\removelastskip\vspace*{29pt}\nointerlineskip%
\parbox{26pc}{{\fontsize{10}{13}\selectfont\raggedright {#1}\par}}
\removelastskip\nointerlineskip\vspace*{3pt}\nointerlineskip%
\endgroup}


\newenvironment{copyrightpage}
{\thispagestyle{empty}\newpage\parindent=0pt\fontsize{8}{9}\selectfont\thispagestyle{empty}}
{}

\def\cindent{\hspace*{6pt}}


\def\dedication#1{{\clearemptydoublepage\begingroup\thispagestyle{empty}\parindent=0pt%
\fontsize{10}{13}\selectfont\raggedright #1\par
\endgroup}\clearemptydoublepage}


\def\episource#1{\newline\normalfont\fontsize{9}{11}\selectfont{---#1\par}}

\newenvironment{epigraphpage}
               {\let\source\episource\clearemptydoublepage\thispagestyle{empty}\fontsize{9}{11}\selectfont\itshape%
               \list{}{\rightmargin0pt\leftmargin0pt}%
                \item\relax}
               {\endlist\clearemptydoublepage}


\def\contname#1{{\normalfont\fontsize{10}{11}\selectfont\bfseries#1\par}}
\def\contaffil#1{{\normalfont\fontsize{10}{11}\selectfont#1\par\vskip3pt}}

\def\contributorname{Contributors}

\newenvironment{contributors}
               {%\addcontentsline{toc}{chapterast}{\contributorname}%
               \let\affil\contaffil\let\name\contname\chapter*{\contributorname}
               \@mkboth{\contributorname}{\contributorname}%
               \list{}{\topsep0pt\normalfont\fontsize{10}{11}\selectfont\rightmargin0pt\leftmargin0pt}%
                \item\relax\par}
              {\endlist\clearemptydoublepage}



\def\subchapter#1{\chapter*{#1}}

\newskip\Indexskip%
\Indexskip=7.7bp%

\def\@makeschapterhead#1{\begingroup\parindent=0pt\thispagestyle{empty}%
\par\removelastskip\vspace*{-58.5pt}\nointerlineskip%
\noindent{\rule{26pc}{2pt}}%
\par\removelastskip\vspace*{4pt}\nointerlineskip%
\parbox{26pc}{{\fontsize{11}{13}\bfseries\selectfont\raggedright #1\par}}
\removelastskip\nointerlineskip\vspace*{43.6bp}\nointerlineskip%
\endgroup\pagestyle{bmheadings}\addcontentsline{toc}{chapterast}{#1}}


\def\@makeschapterheadcont#1{\begingroup\parindent=0pt\thispagestyle{empty}%
\par\removelastskip\vspace*{-58.5pt}\nointerlineskip%
\noindent{\rule{26pc}{2pt}}%
\par\removelastskip\vspace*{4pt}\nointerlineskip%
\parbox{26pc}{{\fontsize{11}{13}\bfseries\selectfont\raggedright #1\par}}
\removelastskip\nointerlineskip\vspace*{43.6bp}\nointerlineskip%
\endgroup\pagestyle{bmheadings}}

\def\@makeschapterheadorg#1{\begingroup\parindent=0pt\thispagestyle{empty}%
\par\removelastskip\vspace*{-58.5pt}\nointerlineskip%
\noindent{\rule{26pc}{2pt}}%
\par\removelastskip\vspace*{4pt}\nointerlineskip%
\parbox{26pc}{{\fontsize{11}{13}\bfseries\selectfont\raggedright #1\par}}
\removelastskip\nointerlineskip\vspace*{43.6bp}\nointerlineskip%
\endgroup\pagestyle{bmheadings}\addcontentsline{toc}{chapterast}{#1}}


\renewenvironment{quotation}{\begingroup\parindent=0pt\parskip9pt\fontsize{9}{11}\selectfont%
\par\removelastskip\nointerlineskip\vspace*{1.5bp}\nointerlineskip}{\par\removelastskip\nointerlineskip\vspace*{12.5bp}\nointerlineskip\endgroup}%

\renewenvironment{quote}{\begingroup\parindent=0pt\parskip9pt\fontsize{9}{11}\selectfont%
\par\removelastskip\nointerlineskip\vspace*{1.5bp}\nointerlineskip}{\par\removelastskip\nointerlineskip\vspace*{12.5bp}\nointerlineskip\endgroup}%


%6x9
\def\@sect#1#2#3#4#5#6[#7]#8{%
  \ifnum #2>\c@secnumdepth
    \let\@svsec\@empty
  \else
    \refstepcounter{#1}%
    \protected@edef\@svsec{\@seccntformat{#1}\relax}%
  \fi
  \@tempskipa #5\relax
  \ifdim \@tempskipa>\z@
    \begingroup
    \ifnum#2=1\vspace*{-6pt}\noindent\rule{26pc}{1pt}\par\removelastskip\vspace*{5.1pt}\nointerlineskip\else\fi
      #6{%
        \@hangfrom
        {\hskip #3\relax{\ifnum#2=1\else\ifnum#2=2\else\ifnum#2=5\textbf{\@svsec}\else\ifnum#2=6\textbf{\textit{\@svsec}}\else{\@svsec}\fi\fi\fi\fi}}%
          \interlinepenalty \@M \ifnum#2=1{%
          \hsize=26pc\hbox to \hsize{\parbox{28.5pc}{\@hangfrom{\@svsec}\raggedright#8\par}}} \else\ifnum#2=2{%
\hbox to \hsize{\parbox{26pc}{\@hangfrom{\@svsec}\raggedright#8\par}}}%
          \else {#8} \fi\fi \@@par}%
    \endgroup
    \csname #1mark\endcsname{#7}%
    \addcontentsline{toc}{#1}{%
      \ifnum #2>\c@secnumdepth \else
        \protect\numberline{\csname the#1\endcsname}%
      \fi
      #8}%
  \else
    \def\@svsechd{%
      #6{\hskip #3\relax
      \@svsec #8}%
      \csname #1mark\endcsname{#7}%
      \addcontentsline{toc}{#1}{%
        \ifnum #2>\c@secnumdepth \else
          \protect\numberline{\csname the#1\endcsname}%
        \fi
        #8}
        }%
  \fi
  \@xsect{#5}\@afterindentfalse}

%6x9
\def\@boxsect#1#2#3#4#5#6[#7]#8{%
  \ifnum #2>\c@secnumdepth
    \let\@svsec\@empty
  \else
    \refstepcounter{#1}%
    \protected@edef\@svsec{\@seccntformat{#1}\relax}%
  \fi
  \@tempskipa #5\relax
  \ifdim \@tempskipa>\z@
    \begingroup
    \ifnum#2=1\vspace*{-6pt}\noindent\rule{25pc}{1pt}\par\removelastskip\vspace*{5.1pt}\nointerlineskip\else\fi
      #6{%
        \@hangfrom
        {\hskip #3\relax{\ifnum#2=1\else\ifnum#2=2\else\ifnum#2=5\textbf{\@svsec}\else\ifnum#2=6\textbf{\textit{\@svsec}}\else{\@svsec}\fi\fi\fi\fi}}%
          \interlinepenalty \@M \ifnum#2=1{%
          \hsize=26pc\hbox to \hsize{\parbox{26pc}{\@hangfrom{\@svsec}\raggedright#8\par}}} \else\ifnum#2=2{%
\hbox to \hsize{\parbox{26pc}{\@hangfrom{\@svsec}\raggedright#8\par}}}%
          \else {#8} \fi\fi \@@par}%
    \endgroup
    \csname #1mark\endcsname{#7}%
    \addcontentsline{toc}{#1}{%
      \ifnum #2>\c@secnumdepth \else
        \protect\numberline{\csname the#1\endcsname}%
      \fi
      #8}%
  \else
    \def\@svsechd{%
      #6{\hskip #3\relax
      \@svsec #8}%
      \csname #1mark\endcsname{#7}%
      \addcontentsline{toc}{#1}{%
        \ifnum #2>\c@secnumdepth \else
          \protect\numberline{\csname the#1\endcsname}%
        \fi
        #8}
        }%
  \fi
  \@xsect{#5}\@afterindentfalse}


\def\@sectorg#1#2#3#4#5#6[#7]#8{\ifnum #2>\c@secnumdepth
     \let\@svsec\@empty\else
     \refstepcounter{#1}\edef\@svsec{\csname the#1\endcsname\hskip 1em}\fi
     \@tempskipa #5\relax
      \ifdim \@tempskipa>\z@
        \begingroup #6\relax
          \@hangfrom{\hskip #3\relax\@svsec}{\interlinepenalty \@M #8\par}%
        \endgroup
       \csname #1mark\endcsname{#7}\addcontentsline
         {toc}{#1}{\ifnum #2>\c@secnumdepth \else
                      \protect\numberline{\csname the#1\endcsname}\fi
                    #7}\else
        \def\@svsechd{#6\hskip #3\relax  %% \relax added 2 May 90
                   \@svsec #8\csname #1mark\endcsname
                      {#7}\addcontentsline
                           {toc}{#1}{\ifnum #2>\c@secnumdepth \else
                             \protect\numberline{\csname the#1\endcsname}\fi
                       #7}}\fi
     \@xsect{#5}}


\def\@ssect#1#2#3#4#5{%
  \@tempskipa #3\relax
  \ifdim \@tempskipa>\z@
    \begingroup
      #4{%
        \@hangfrom{\hskip #1}%
          \interlinepenalty \@M {#5}\@@par}%\color{gray!80}
      \endgroup
  \else
    \def\@svsechd{#4{\hskip #1\relax #5}}%
  \fi
  \@xsect{#3}\addcontentsline{toc}{sectionast}{#5}}%

\def\@ssectorg#1#2#3#4#5{%
  \@tempskipa #3\relax
  \ifdim \@tempskipa>\z@
    \begingroup
      #4{%
        \@hangfrom{\hskip #1}%
          \interlinepenalty \@M {#5}\@@par}%\color{gray!80}
      \endgroup
  \else
    \def\@svsechd{#4{\hskip #1\relax #5}}%
  \fi
  \@xsect{#3}\addcontentsline{toc}{sectionast}{#5}}%


%6x9
\def\@ssectsec#1#2#3#4#5{%
  \@tempskipa #3\relax
  \ifdim \@tempskipa>\z@
    \begingroup
      #4{%
        \@hangfrom{\hskip #1}%
                  \interlinepenalty \@M \hsize=26pc\hbox to \hsize{\parbox{26pc}{%
                  \noindent\rule{26pc}{1pt}\par\removelastskip\vspace*{6.1pt}\nointerlineskip%
                  {\raggedright#5}}}\@@par\vskip5pt}%
      \endgroup
  \else
    \def\@svsechd{#4{\hskip #1\relax #5}}%
  \fi
  \@xsect{#3}\addcontentsline{toc}{sectionast}{#5}}%


\renewcommand\section{\let\@ssect\@ssectsec\@startsection {section}{1}{0pt}%
{-18pt plus-9pt minus-4.5pt}{13pt}%
{\fontsize{10}{13}\bfseries\raggedright\selectfont}}%\parshape 1 -31.5pt \textwidth

\newcommand\boxsection{\let\@sect\@boxsect\let\@ssect\@ssectsec\@startsection {section}{1}{0pt}%
{-18pt plus-9pt minus-4.5pt}{13pt}%
{\fontsize{10}{13}\bfseries\raggedright\selectfont}}%\parshape 1 -31.5pt \textwidth


\def\Ahead#1{\section*{#1}}

\renewcommand\subsection{\let\@ssect\@ssectorg\@startsection{subsection}{2}{\z@}%
{-18pt plus-9pt minus-4.5pt}{7pt}%
{\fontsize{10}{13}\bfseries\raggedright\selectfont}}%\parshape 1 -48pt \textwidth

\renewcommand\subsubsection{%
\@startsection{subsubsection}{3}{\z@}%
{-18pt plus-9pt minus-4.5pt}{7pt}%
{\fontsize{10}{13}\bfseries\raggedright\selectfont}}


\renewcommand\paragraph{\@startsection{paragraph}{4}{0pt}%
{-18pt plus-9pt minus-4.5pt}{7pt}%
{\fontsize{10}{13}\bfseries\itshape\raggedright\selectfont}}


\renewcommand\subparagraph{\@startsection{subparagraph}{5}{\z@}%\parindent
{-18pt plus-9pt minus-4.5pt}{7pt}%
{\fontsize{10}{13}\raggedright\selectfont}}

\renewcommand\subsubparagraph{\@startsection{subsubparagraph}{6}{\z@}%\parindent
{-12pt}{7pt}%
{\fontsize{10}{13}\raggedright\bfseries\itshape\selectfont}}

\newcommand\subsubsubparagraph{\@startsection{subsubparagraph}{7}{\z@}%\parindent
{-18pt plus-9pt minus-4.5pt}{7pt}%
{\fontsize{10}{13}\raggedright\selectfont}}


 
\newcommand\boxheads{\let\@ssect\@ssectorg\@startsection{subsubsection}{3}{\z@}%
{0pt}{6pt}%
{\fontsize{8}{9}\bfseries\raggedright\selectfont}}

\def\boxhead#1{\begin{xboxhead}\end{xboxhead}%
\boxheads*{#1}}


\newcommand\listheads{\@startsection{subparagraph}{5}{\z@}%\parindent
{7pt}{3pt}%
{\fontsize{10}{13}\itshape\raggedright\selectfont}}




\def\listhead#1{\listheads*{#1}}

\def\enumerate{\@ifnextchar[{\@numerate}{\@numerate[]}}

\def\@numerate[#1]{%
     \ifnum \@enumdepth >3 \@toodeep\else
     \advance\@enumdepth \@ne
     \edef\@enumctr{enum\romannumeral\the\@enumdepth}
     \list{\csname label\@enumctr\endcsname}{%
     \itemindent\z@%
     \parsep\z@%
     \itemsep3\p@%
     \topsep 7\p@%
       \setlength{\leftmargin}{0pt}
       \usecounter{\@enumctr}
       \settowidth\labelwidth{#1}
       \addtolength{\leftmargin}{\labelwidth}
       \addtolength{\leftmargin}{\labelsep}
       \def\makelabel##1{\hss\llap{##1}}}%
     \fi
   }
\let\endenumerate\endlist


\def\description{\@ifnextchar[{\@ddescription}{\@ddescription[]}}

\def\@ddescription[#1]{%
     \ifnum \@enumdepth >3 \@toodeep\else
     \advance\@enumdepth \@ne
     \edef\@enumctr{enum\romannumeral\the\@enumdepth}
     \list{\csname label\@enumctr\endcsname}{%
     \itemindent\z@%
     \parsep\z@%
     \itemsep14pt%\z@%
     \topsep 14\p@%
       \setlength{\leftmargin}{0pt}
       \usecounter{\@enumctr}
       \settowidth\labelwidth{#1}
       \addtolength{\leftmargin}{\labelwidth}
       \addtolength{\leftmargin}{\labelsep}
       \addtolength{\leftmargin}{7pt}
       \def\makelabel##1{\hss\llap{\itshape##1}}}%
     \fi
   }
\let\enddescription\endlist

\RequirePackage{eso-pic}
\definecolor{twentyfive}{cmyk}{0,0,0,0.15}


\def\promotionaluse{\AddToShipoutPictureBG*{%
\AtTextCenter{%
\makebox(0,0)[c]{\resizebox{\textwidth}{!}{%
\rotatebox{45}{\fontseries{b}\fontsize{53}{53}\selectfont\color{twentyfive}Promotional Use}}}
}
}}

%\usepackage{epigraph}
%
%  \setlength{\epigraphwidth}{\textwidth}
%
%\renewcommand{\@epitext}[1]{%
%  \begin{minipage}{\epigraphwidth}\begin{\textflush}\itshape #1\\
%%    \ifdim\epigraphrule>\z@ \@epirule \else \vspace*{1ex} \fi
%  \end{\textflush}\end{minipage}}
%
%
%\renewcommand{\epigraph}[2]{%\vspace{\beforeepigraphskip}
%  {\epigraphsize\begin{\textflush}\begin{minipage}{\epigraphwidth}
%    \@epitext{#1}\\ \@episource{#2}
%    \end{minipage}\end{\textflush}
%    \vspace{\afterepigraphskip}}}


\newcommand{\epigraph}[2]{{\noindent\normalfont\fontsize{9}{11}\selectfont\itshape#1\par\normalfont\noindent---#2\par\removelastskip\vspace*{19pt}\nointerlineskip}}

\newenvironment{abstract}
               {\list{}{\topsep13pt\normalfont\fontsize{9}{11}\selectfont\rightmargin0pt\leftmargin0pt}%
                \item\relax\par}
              {\endlist}


\makeatother

\usepackage[figuresright]{rotating}
\usepackage{makeidx}
\usepackage{amssymb}
\usepackage{eurosym}
\usepackage{graphicx}
\usepackage{amsfonts}
\usepackage[fleqn]{amsmath}
\usepackage{endnotes}
%\usepackage[Lenny]{fncychap}
%\usepackage{chicago}
\usepackage{fancyhdr}


\usepackage[splitbottomskip=0pt,splittopskip=0pt,skipabove=0pt,%
innerleftmargin=12,innerrightmargin=12,innertopmargin=11pt,innerbottommargin=11pt]{mdframed}

\makeatletter

\renewenvironment{mdframed}[1][]{\fontsize{8}{9}\selectfont\let\extract\boxextract\let\section\boxsection%
 \color@begingroup%
   \mdfsetup{userdefinedwidth=26pc,#1}%
   \mdf@startcode%
   \mdf@preenvsetting%
   \ifdefempty{\mdf@firstframetitle}{}%
           {\let\mdf@frametitlesave\mdf@frametitle%
            \let\mdf@frametitle\mdf@firstframetitle%
           }%
   \ifvmode\nointerlineskip\fi%
   \mdf@trivlist{\mdf@skipabove@length}%%
   \mdf@settings%
   \mdf@lrbox{\mdf@splitbox@one}%
   \mdf@startinnercode%
  }%
  {%
   \mdf@@ignorelastdescenders%
   \par\unskip\ifvmode\nointerlineskip\hrule \@height\z@ \@width\hsize\fi%%
   \ifmdf@footnoteinside%
      \def\mdf@reserveda{%
        \mdf@footnoteoutput%
        \mdf@endinnercode%
        \endmdf@lrbox%
        \ifdefempty{\mdf@frametitle}{}%
            {\mdfframedtitleenv{\mdf@frametitle}\mdf@@frametitle@use}%
        \detected@mdf@put@frame}%
   \else%
      \def\mdf@reserveda{%
        \mdf@endinnercode%
        \endmdf@lrbox%
        \ifdefempty{\mdf@frametitle}{}%
            {\mdfframedtitleenv{\mdf@frametitle}\mdf@@frametitle@use}%
        \detected@mdf@put@frame%
        \mdf@footnoteoutput%
        }%
   \fi%
   \mdf@reserveda%
  \aftergroup\endmdf@trivlist%
 \color@endgroup%
 \mdf@endcode%
\vspace*{6pt}}


\renewrobustcmd*\if@mdf@pageodd{%
 \zref@refused{mdf@pagelabel-\the\value{mdf@zref@counter}}%
 \ifodd\zref@extract{mdf@pagelabel-\the\value{mdf@zref@counter}}%
                    {mdf@pagevalue}%
    \setlength\mdf@rightmargin@length{\mdf@innermargin@length}%
    \setlength\mdf@leftmargin@length{\mdf@innermargin@length}%
 \else
    \setlength\mdf@rightmargin@length{\mdf@innermargin@length}%
    \setlength\mdf@leftmargin@length{\mdf@innermargin@length}%
 \fi%
}

\makeatother

%\global\mdfdefinestyle{exampledefaultt}{%
%rightline=true,innerleftmargin=12,innerrightmargin=12,
%frametitlerule=true,frametitlerulecolor=black,
%frametitlebackgroundcolor=black,
%frametitlerulewidth=2pt,splitbottomskip=0pt}



\makeatletter




\makeatother

\makeatletter
%\renewcommand\NAT@force@numbers{%
%  \ifNAT@numbers\else
%  \global\NAT@numberstrue\fi}
\makeatother

\usepackage{listings}

\lstdefinelanguage{Dummy}{
    morekeywords={},
    morestring=[b]",
    morecomment=[l]{//},
    morecomment=[s]{/*}{*/},
    morecomment=[s]{/**}{*/},
        morecomment=[l]{C----},
    % delimiters for emphasized text
    %   (no-op since the default color is now black not gray)
    moredelim=**[is][\color{black}]{/^}{^/}
}
\lstset{language=Dummy,
%    columns=fullflexible,
    numbers=none,
    frame=single,
    framerule=0pt,
    framesep=0pt,
    basicstyle=\fontsize{10}{13}\ttfamily\selectfont\color{black},
numbers=none,
numberstyle=\tiny, stepnumber=2, numbersep=10pt,
        % setting the default color to gray allows having emphasized
    % and non-emphasized code, but it seems to make the frame come
        % and we don't have any non-emphasized code anyway
    %basicstyle=\footnotesize\ttfamily\color{MediumGray},
    commentstyle=\itshape,
    identifierstyle={},
    keywordstyle={},
    showlines=true,
    showstringspaces=false,
    xleftmargin=0pt,
    framexleftmargin=0pt,
    xrightmargin=22pt,
captionpos=b,
abovecaptionskip=9.5pt, belowskip=7pt,aboveskip=10pt}


\mathindent0pt

%\usepackage[T1]{fontenc}
\usepackage{tikz}
\makeatletter

\def\@rotfloat#1{%
  \@ifnextchar[%
    {\@xrotfloat{#1}}%
    {\edef\@tempa{\noexpand\@xrotfloat{#1}[\csname fps@#1\endcsname]}\@tempa}%
}
\def\@xrotfloat#1[#2]{%
  \@float{#1}[#2]%
  \begin{lrbox}\rot@float@box
  \begin{minipage}\textheight
 }
\def\end@rotfloat{%
   \end{minipage}\end{lrbox}%
   \global\addtocounter{r@tfl@t}{1}%
   \rot@label{RF\ther@tfl@t}%
   \message{Adding sideways figure on }%
   \def\R@@page{\pageref{RF\ther@tfl@t}}%
   \wd\rot@float@box\z@
   \ht\rot@float@box\z@
   \dp\rot@float@box\z@
   \vbox to \textheight{%
    \setkeys{Grot}{units=360}%
    \if@rot@twoside
      \def\R@@page{\pageref{RF\ther@tfl@t}}%
    \else
      \let\R@@page\rot@LR
    \fi
    \ifthenelse{\isodd{\R@@page}}{%
    \message{right hand page}%
    \vfill
    %\centerline
    {\hspace*{6.7pc}\rotatebox{90}{\box\rot@float@box}}%
         }{%
    \message{left hand page}%
    \centerline{\rotatebox{-90}{\box\rot@float@box}}%
     \vfill
         }%
 }%
   \end@float
}
\def\sidewaysfigure{\let\@makecaption\@makefigurecaption\@rotfloat{figure}}
\let\endsidewaysfigure\end@rotfloat

\makeatother

\setcounter{MaxMatrixCols}{10}


%%%%%%%%%%%%%%%%%%%%%%%%%%%
\makeatletter
% definition of the "\spnewtheorem" command.
%
% Usage:
%
%     \spnewtheorem{env_nam}{caption}[within]{cap_font}{body_font}
% or  \spnewtheorem{env_nam}[numbered_like]{caption}{cap_font}{body_font}
% or  \spnewtheorem*{env_nam}{caption}{cap_font}{body_font}
%
% New is "cap_font" and "body_font". It stands for
% fontdefinition of the caption and the text itself.
%
% "\spnewtheorem*" gives a theorem without number.
%
% A defined spnewthoerem environment is used as described
% by Lamport.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\def\@thmcountersep{.}
\def\@thmcounterend{}

\def\@endprooftheorem{\hfill\rule{4pt}{4pt}\endtrivlist}

\def\spnewtheorem{\@ifstar{\@sthm}{\@Sthm}}

% definition of \spnewtheorem with number

\def\@spnthm#1#2{%
  \@ifnextchar[{\@spxnthm{#1}{#2}}{\@spynthm{#1}{#2}}}
\def\@Sthm#1{\@ifnextchar[{\@spothm{#1}}{\@spnthm{#1}}}

\def\@spxnthm#1#2[#3]#4#5{\expandafter\@ifdefinable\csname #1\endcsname
   {\@definecounter{#1}\@addtoreset{#1}{#3}%
   \expandafter\xdef\csname the#1\endcsname{\expandafter\noexpand
     \csname the#3\endcsname \noexpand\@thmcountersep \@thmcounter{#1}}%
   \expandafter\xdef\csname #1name\endcsname{#2}%
   \global\@namedef{#1}{\@spthm{#1}{\csname #1name\endcsname}{#4}{#5}}%
                              \global\@namedef{end#1}{\@endtheorem}}}

\def\@spynthm#1#2#3#4{\expandafter\@ifdefinable\csname #1\endcsname
   {\@definecounter{#1}%
   \expandafter\xdef\csname the#1\endcsname{\@thmcounter{#1}}%
   \expandafter\xdef\csname #1name\endcsname{#2}%
   \global\@namedef{#1}{\@spthm{#1}{\csname #1name\endcsname}{#3}{#4}}%
                               \global\@namedef{end#1}{\@endtheorem}}}

\def\@spothm#1[#2]#3#4#5{%
  \@ifundefined{c@#2}{\@latexerr{No theorem environment `#2' defined}\@eha}%
  {\expandafter\@ifdefinable\csname #1\endcsname
  {\global\@namedef{the#1}{\@nameuse{the#2}}%
  \expandafter\xdef\csname #1name\endcsname{#3}%
  \global\@namedef{#1}{\@spthm{#2}{\csname #1name\endcsname}{#4}{#5}}%
  \global\@namedef{end#1}{\@endtheorem}}}}

\def\@spthm#1#2#3#4{\topsep5\p@% \@plus2\p@ \@minus4\p@
\refstepcounter{#1}%
\@ifnextchar[{\@spythm{#1}{#2}{#3}{#4}}{\@spxthm{#1}{#2}{#3}{#4}}}

\def\@spxthm#1#2#3#4{\@spbegintheorem{#2}{\csname the#1\endcsname}{#3}{#4}%
                    \ignorespaces}

\def\@spythm#1#2#3#4[#5]{\@spopargbegintheorem{#2}{\csname
       the#1\endcsname}{#5}{#3}{#4}\ignorespaces}

\def\@spbegintheorem#1#2#3#4{\trivlist
                 \item[\hskip\labelsep{#2\@thmcounterend\hspace*{1em}#3#1\hspace*{0.5em}}]#4}

\def\@spopargbegintheorem#1#2#3#4#5{\trivlist
      \item[\hskip\labelsep{#2\@thmcounterend\hspace*{1em}#4#1}]{#4(#3)\hspace*{1em}}#5}

% definition of \spnewtheorem* without number

\def\@sthm#1#2{\@Ynthm{#1}{#2}}

\def\@Ynthm#1#2#3#4{\expandafter\@ifdefinable\csname #1\endcsname
   {\global\@namedef{#1}{\@Thm{\csname #1name\endcsname}{#3}{#4}}%
    \expandafter\xdef\csname #1name\endcsname{#2}%
    \global\@namedef{end#1}{\@endtheorem}}}

\def\@Thm#1#2#3{\topsep5\p@%\@plus2\p@ \@minus4\p@
\@ifnextchar[{\@Ythm{#1}{#2}{#3}}{\@Xthm{#1}{#2}{#3}}}

\def\@Xthm#1#2#3{\@Begintheorem{#1}{#2}{#3}\ignorespaces}

\def\@Ythm#1#2#3[#4]{\@Opargbegintheorem{#1}
       {#4}{#2}{#3}\ignorespaces}

\def\@Begintheorem#1#2#3{#3\trivlist
                           \item[\hskip\labelsep{#2#1\@thmcounterend\hspace*{0.5em}}]}

\def\@Opargbegintheorem#1#2#3#4{#4\trivlist
      \item[\hskip\labelsep{#3#1}]{#3(#2)\@thmcounterend\hspace*{1em}}}

\if@envcntsect
   \def\@thmcountersep{.}
%   \spnewtheorem{theorem}{Theorem}[section]{\itshape}{\rmfamily}
\else
%   \spnewtheorem{theorem}{Theorem}[section]{\itshape}{\rmfamily}
   \if@envcntreset
      \@addtoreset{theorem}{section}
   \else
      \@addtoreset{theorem}{chapter}
   \fi
\fi

%definition of divers theorem environments
\spnewtheorem*{claim}{Claim}{\itshape}{\rmfamily}
\spnewtheorem*{proof}{Proof}{\itshape}{\rmfamily}
\if@envcntsame % alle Umgebungen wie Theorem.
   \def\spn@wtheorem#1#2#3#4{\@spothm{#1}[theorem]{#2}{#3}{#4}}
\else % alle Umgebungen mit eigenem Zaehler
   \if@envcntsect % mit section numeriert
      \def\spn@wtheorem#1#2#3#4{\@spxnthm{#1}{#2}[section]{#3}{#4}}
   \else % nicht mit section numeriert
      \if@envcntreset
         \def\spn@wtheorem#1#2#3#4{\@spynthm{#1}{#2}{#3}{#4}
                                   \@addtoreset{#1}{section}}
      \else
         \def\spn@wtheorem#1#2#3#4{\@spynthm{#1}{#2}{#3}{#4}
                                   \@addtoreset{#1}{chapter}}%
      \fi
   \fi
\fi

\def\@takefromreset#1#2{%
    \def\@tempa{#1}%
    \let\@tempd\@elt
    \def\@elt##1{%
        \def\@tempb{##1}%
        \ifx\@tempa\@tempb\else
            \@addtoreset{##1}{#2}%
        \fi}%
    \expandafter\expandafter\let\expandafter\@tempc\csname cl@#2\endcsname
    \expandafter\def\csname cl@#2\endcsname{}%
    \@tempc
    \let\@elt\@tempd}

\def\theopargself{\def\@spopargbegintheorem##1##2##3##4##5{\trivlist
      \item[\hskip\labelsep{##4##1\ ##2}]{##4##3\@thmcounterend\ }##5}
                  \def\@Opargbegintheorem##1##2##3##4{##4\trivlist
      \item[\hskip\labelsep{##3##1}]{##3##2\@thmcounterend\ }}
      }

\let\endproof\@endprooftheorem%

%\font\bullsq=pmlr8r at 9pt
 
%\def\labelitemi{{\bullsq{\hbox{\char'225}}}}
%\def\labelitemiii{{\bullsq{\hbox{\char'225}}}}
%\def\labelitemii{{\bullsq{\hbox{\char'225}}}}
%\def\labelitemiv{{\bullsq{\hbox{\char'225}}}}

%\renewcommand\labelitemi{\fontsize{2}{2}\selectfont\raisebox{2.1pt}{\textbullet}}
\renewcommand\labelitemi{{\textbullet}}
\renewcommand\labelitemii{{\textbullet}}
\renewcommand\labelitemiii{\textasteriskcentered}
\renewcommand\labelitemiv{\textperiodcentered}

%\def\itemize{%
%  \ifnum \@itemdepth >\thr@@\@toodeep\else
%    \advance\@itemdepth\@ne
%    \edef\@itemitem{labelitem\romannumeral\the\@itemdepth}%
%    \expandafter
%    \list
%      \csname\@itemitem\endcsname
%      {\def\makelabel##1{\hss\llap{##1}}}%
%  \fi}
%\let\enditemize =\endlist


\def\itemargs{%
   \leftmargini   0\p@
   \addtolength\leftmargini{-.4mm}
   \topsep     7pt
   \itemsep       3pt
   \parsep        \z@
   \labelsep      0.6em
   \rightmargin   \z@
   \listparindent \parindent
   \itemindent    \z@}

\def\itemize{%
   \@ifnextchar[{\@itemize}{\@itemize[$\bullet$]}}

\def\@itemize[#1]{%
     \ifnum \@itemdepth >3 \@toodeep\else
     \advance\@itemdepth \@ne
     \edef\@itemctr{item\romannumeral\the\@itemdepth}
     \list{\csname label\@itemctr\endcsname}{%
       \itemargs
       \setlength{\leftmargin}{\csname leftmargin\romannumeral\the\@itemdepth\endcsname}
       \settowidth\labelwidth{#1}
       \addtolength{\leftmargin}{\labelwidth}
       \addtolength{\leftmargin}{\labelsep}
       \def\makelabel##1{\hss \llap{##1}}}%
     \fi
   }
\let\enditemize\endlist




\def\enumargs{%
   \leftmargini   0pt
   \topsep     7pt
   \itemsep       3pt
   \parsep        \z@
   \labelsep      6.1pt
   \rightmargin   \z@
   \listparindent \parindent
   \itemindent    \z@}

\def\enumerate{\let\enumerate\subenumerate%
    \@ifnextchar[{\@numerate}{\@numerate[0.]}}

\def\@numerate[#1]{%
     \ifnum \@enumdepth >3 \@toodeep\else
     \advance\@enumdepth \@ne
     \edef\@enumctr{enum\romannumeral\the\@enumdepth}
     \list{\csname label\@enumctr\endcsname}{%
       \enumargs
       \setlength{\leftmargin}{\csname leftmargin\romannumeral\the\@enumdepth\endcsname}
       \usecounter{\@enumctr}
       \settowidth\labelwidth{#1}
       \addtolength{\leftmargin}{\labelwidth}
       \addtolength{\leftmargin}{\labelsep}
       \def\makelabel##1{\hss\llap{{##1}}}}%
     \fi
   }
\let\endenumerate\endlist


\def\subenumargs{%
   \leftmargini   0pt
   \topsep     7pt
   \itemsep       3pt
   \parsep        \z@
   \labelsep      6.1pt
   \rightmargin   \z@
   \listparindent \parindent
   \itemindent    \z@}

\def\subenumerate{%
    \@ifnextchar[{\@subnumerate}{\@subnumerate[0.]}}

\def\@subnumerate[#1]{%
     \ifnum \@enumdepth >3 \@toodeep\else
     \advance\@enumdepth \@ne
     \edef\@enumctr{enum\romannumeral\the\@enumdepth}
     \list{\csname label\@enumctr\endcsname}{%
       \subenumargs
       \setlength{\leftmargin}{\csname leftmargin\romannumeral\the\@enumdepth\endcsname}
       \usecounter{\@enumctr}
       \settowidth\labelwidth{#1}
       \addtolength{\leftmargin}{\labelwidth}
       \addtolength{\leftmargin}{\labelsep}
       \def\makelabel##1{\hss\llap{{##1}}}}%
     \fi
   }
\let\endsubenumerate\endlist


\def\unenumargs{%
   \leftmargini   0pt
   \topsep     7pt
   \itemsep       3pt
   \parsep        \z@
   \labelsep      0pt
   \rightmargin   \z@
   \listparindent \parindent
   \itemindent    \z@}

\def\unlist{%
    \@ifnextchar[{\@unnumerate}{\@unnumerate[]}}

\def\@unnumerate[#1]{%
     \ifnum \@enumdepth >3 \@toodeep\else
     \advance\@enumdepth \@ne
     \edef\@enumctr{enum\romannumeral\the\@enumdepth}
     \list{}{%
       \unenumargs
       \setlength{\leftmargin}{\csname leftmargin\romannumeral\the\@enumdepth\endcsname}
       \usecounter{\@enumctr}
       \settowidth\labelwidth{#1}
       \addtolength{\leftmargin}{\labelwidth}
       \addtolength{\leftmargin}{\labelsep}
       \def\makelabel##1{}}%
     \fi
   }
\let\endunlist\endlist



\def\notenumargs{%
   \leftmargini   0pt
   \topsep     7pt
   \itemsep       3pt
   \parsep        \z@
   \labelsep      10.1pt
   \rightmargin   \z@
   \listparindent \parindent
   \itemindent    \z@}

\def\notation{%
    \@ifnextchar[{\@notnumerate}{\@notnumerate[0.]}}

\def\@notnumerate[#1]{%
     \ifnum \@enumdepth >3 \@toodeep\else
     \advance\@enumdepth \@ne
     \edef\@enumctr{enum\romannumeral\the\@enumdepth}
     \list{\csname label\@enumctr\endcsname}{%
       \notenumargs
       \setlength{\leftmargin}{\csname leftmargin\romannumeral\the\@enumdepth\endcsname}
       \usecounter{\@enumctr}
       \settowidth\labelwidth{#1}
       \addtolength{\leftmargin}{\labelwidth}
       \addtolength{\leftmargin}{\labelsep}
       \def\makelabel##1{\hss\llap{\hbox to \labelwidth{##1\hss}}}}%
     \fi
   }
\let\endnotation\endlist


\def\descenumargs{%
   \leftmargini   0pt
   \topsep     7pt
   \itemsep       3pt
   \parsep        \z@
   \labelsep      6.1pt
   \rightmargin   \z@
   \listparindent \parindent
   \itemindent    \z@}

\def\deshead#1{\textbf{\textit{#1}}\hspace*{6pt}}

\def\descriptive{\let\head\deshead%
    \@ifnextchar[{\@descnumerate}{\@descnumerate[0.]}}

\def\@descnumerate[#1]{%
     \ifnum \@enumdepth >3 \@toodeep\else
     \advance\@enumdepth \@ne
     \edef\@enumctr{enum\romannumeral\the\@enumdepth}
     \list{\csname label\@enumctr\endcsname}{%
       \descenumargs
       \setlength{\leftmargin}{\csname leftmargin\romannumeral\the\@enumdepth\endcsname}
       \usecounter{\@enumctr}
       \settowidth\labelwidth{#1}
       \addtolength{\itemindent}{\labelwidth}
       \addtolength{\itemindent}{\labelsep}
       \def\makelabel##1{\hss\llap{{##1}}}}%
     \fi
   }
\let\enddescriptive\endlist


%%author defi

\usepackage{authblk}

%
\renewcommand\Authfont{\normalfont\bfseries}
\renewcommand\Affilfont{\normalfont\itshape}

\renewcommand\author[2][]%
      {\ifnewaffil\addtocounter{affil}{1}%
       \edef\AB@thenote{\arabic{affil}}\fi
      \if\relax#1\relax\def\AB@note{\AB@thenote}\else\def\AB@note{#1}%
        \setcounter{Maxaffil}{0}\fi
      \ifnum\value{authors}>1\relax
      \@namedef{@sep\number\c@authors}{\Authsep}\fi
      \addtocounter{authors}{1}%
      \begingroup
          \let\protect\@unexpandable@protect \let\and\AB@pand
          \def\thanks{\protect\thanks}\def\footnote{\protect\footnote}%
         \@temptokena=\expandafter{\AB@authors}%
         {\def\\{\protect\\[\@affilsep]\protect\Affilfont
              \protect\AB@resetsep}%
              \xdef\AB@author{\AB@blk@and#2}%
       \ifnewaffil\gdef\AB@las{}\gdef\AB@lasx{\protect\Authand}\gdef\AB@as{}%
           \xdef\AB@authors{\the\@temptokena\AB@blk@and}%
       \else
          \xdef\AB@authors{\the\@temptokena\AB@as\AB@au@str}%
          \global\let\AB@las\AB@lasx\gdef\AB@lasx{\protect\Authands}%
          \gdef\AB@as{\Authsep}%
       \fi
       \gdef\AB@au@str{#2}}%
         \@temptokena=\expandafter{\AB@authlist}%
         \let\\=\authorcr
         \xdef\AB@authlist{\the\@temptokena
           \protect\@nameuse{@sep\number\c@authors}%
           \protect\Authfont#2\AB@authnote{\AB@note}}%
      \endgroup
      \ifnum\value{authors}>2\relax
      \@namedef{@sep\number\c@authors}{\Authands}\fi
      \newaffilfalse
 \addcontentsline{toc}{chapauthor}{#2}%
 }

\def\maketitle
  {{\renewenvironment{tabular}[2][]{}
                                   {}
  \AB@maketitle}\vspace*{-64pt}}

\setlength{\affilsep}{.5em}
%%author defi end



\newlength\tbelowcaptionskip%
\setlength\tbelowcaptionskip{3.66\p@}%


\long\def\@maketablecaption#1#2{%
  \sbox\@tempboxa{\fontsize{8}{9}\selectfont{\bfseries#1}\par#2}%
  \ifdim \wd\@tempboxa >\hsize
    \fontsize{8}{9}\selectfont{{\bfseries#1\par\vspace*{3pt}}%\hspace*{6pt}%\par%
\selectfont#2\vphantom{Ay}\par}
  \else
%    \global \@minipagefalse
%    \hb@xt@\hsize{\hfil\box\@tempboxa\hfil}%
    \fontsize{8}{9}\selectfont{{\bfseries#1\par\vspace*{3pt}}%\hspace*{6pt}%
\selectfont#2\vphantom{Ay}\par}
  \fi%
  \vskip1.5pt
  }

\newlength\tabovecaptionskip%
\setlength\tabovecaptionskip{3.5\p@}%

\long\def\@makefigurecaption#1#2{%
  \vskip\tabovecaptionskip%
  \sbox\@tempboxa{\fontsize{8}{9}\selectfont{{\bfseries#1}\par#2}}%
  \ifdim \wd\@tempboxa >\hsize
    \fontsize{8}{9}\selectfont{{\bfseries#1}\par\vspace*{3pt}%\hspace*{6pt}%
#2\vphantom{Ay}\par}
  \else
%    \global \@minipagefalse
%    \hb@xt@\hsize{\hfil\box\@tempboxa\hfil}%
    \fontsize{8}{9}\selectfont{{\bfseries#1}\par\vspace*{3pt}%\hspace*{6pt}%
#2\vphantom{Ay}\par}
  \fi%
}





\def\Toprule{%
  \noalign{\ifnum0=`}\fi\hrule \@height \arrayrulewidth \futurelet%
   \reserved@a\@xhline%
\noalign{\vspace*{2.62pt}}}

\def\Midrule{\noalign{\vspace*{1.88pt}}%
  \noalign{\ifnum0=`}\fi\hrule \@height \arrayrulewidth \futurelet%
   \reserved@a\@xhline%
\noalign{\vspace*{2.62pt}}}

\def\Botrule{\noalign{\vspace*{1.88pt}}%
  \noalign{\ifnum0=`}\fi\hrule \@height \arrayrulewidth \futurelet
   \reserved@a\@xhline%
\noalign{\vspace*{1pt}}}


\def\halfptrule{\hrule \@height 0.5\p@}

\def\Toprule{\noalign{\vspace*{1.8pt}\halfptrule\vspace*{1pt}}}
\def\Midrule{\noalign{\vspace*{1.8pt}\halfptrule\vspace*{1pt}}}
\def\Botrule{\noalign{\vspace*{1.8pt}\halfptrule\vspace*{1pt}}}

\def\arraystretch{1.1}% Default value.


\usepackage{dcolumn}
\newcolumntype{d}[1]{D{.}{.}{#1}}

\thinmuskip=2.5mu%%%%3mu
\medmuskip=3.5mu%4mu plus 2mu minus 4mu                <- no glue
\thickmuskip=4.5mu%5mu plus 5mu                        <- no glue

\setlength\arraycolsep{1.5\p@}%

\newenvironment{pf}[1]{\list{}{\itemindent\z@%
\leftmargin\z@%
\rightmargin\z@%
\parsep\z@%
\itemsep\z@%
\topsep 7\p@%
}%
\item\relax%
{\itshape#1}\ignorespaces\hspace*{1em}\ignorespaces}
{\hfill\rule{4pt}{4pt}\endlist}

\newenvironment{programminglist}{\list{}{\itemindent\z@%
\leftmargin\z@%
\rightmargin\z@%
\parsep\z@%
\itemsep\z@%
\topsep 7\p@%
}%
\item\relax%
  \obeylines \verbatim@font \@noligs
  \hyphenchar\font\m@ne
  \everypar \expandafter{\the\everypar \unpenalty}%
\frenchspacing\@vobeyspaces}
{\endlist}

\def\TCHhead#1{\hbox{\bfseries\boldmath#1}}

\def\inToprule{%
  \noalign{\ifnum0=`}\fi\hrule \@height \arrayrulewidth \futurelet%
   \reserved@a\@xhline%
\mathstrut\crcr\noalign{\vspace*{-14.45bp}}}

\def\inMidrule{\mathstrut\crcr\noalign{\vspace*{-14.45bp}}%
  \noalign{\ifnum0=`}\fi\hrule \@height \arrayrulewidth \futurelet
   \reserved@a\@xhline%
\mathstrut\crcr\noalign{\vspace*{-14.45bp}}}

\def\inBotrule{\noalign{\vspace*{-14pt}}\mathstrut\cr%
  \noalign{\ifnum0=`}\fi\hrule \@height \arrayrulewidth \futurelet
   \reserved@a\@xhline%
}

\usepackage{balance}

\def\printindex#1#2{\@restonecoltrue\if@twocolumn\@restonecolfalse\fi
\Indexskip=0pt
\columnseprule\z@%
\columnsep 12pt
\def\indexname{#2}
\def\partmark{#2}
\addcontentsline{toc}{section}{#2}
\@input{#1.ind}}

\usepackage{balance}
\renewenvironment{theindex}
{  \if@openright
    \clearemptydoublepage
  \else
    \clearpage
  \fi
\if@twocolumn
  \@restonecolfalse
\else
  \@restonecoltrue
\fi
\twocolumn[\thispagestyle{empty}%
\@makeschapterhead{\indexname}\vspace*{-2.5pt}]%
\@mkboth{\indexname}{\indexname}%
\parindent\z@%
%\parskip\z@ \@plus .3\p@\relax%
\columnseprule \z@%
\columnsep 12\p@%
\fontsize{8}{9}\selectfont
\let\item\@idxitem\balance}
{\if@restonecol\onecolumn\clearemptydoublepage\else\clearpage\fi\balance}
\renewcommand\@idxitem{\par\hangindent 12\p@}
\renewcommand\subitem{\par\hangindent 12\p@\hspace*{6\p@}}
\renewcommand\subsubitem{\par\hangindent 18\p@\hspace*{12\p@}}
\renewcommand\indexspace{\par \vskip 10\p@}% \@plus5\p@ \@minus3\p@\relax

% Page break penalties
\@lowpenalty   51
\@medpenalty  151
\@highpenalty 301


% Disallow widows and orphans
\clubpenalty 10000
\widowpenalty 10000

% Disable page breaks before equations, allow pagebreaks after
% equations and discourage widow lines before equations.
\displaywidowpenalty 100
\predisplaypenalty   10000
\postdisplaypenalty  0

% Allow breaking the page in the middle of a paragraph
\interlinepenalty 0

% Disallow breaking the page after a hyphenated line
\brokenpenalty 10000

% Hyphenation; don't split words into less than three characters
\lefthyphenmin=3
\righthyphenmin=3










\def\@makeschapterheadfrnt#1{\begingroup\parindent=0pt\thispagestyle{empty}%
\removelastskip\nointerlineskip\vspace*{-22pt}\nointerlineskip%
\fontsize{18}{26}\sffamily\bfseries\selectfont\raggedright\color{grayseventy}{#1}
\removelastskip\nointerlineskip\vspace*{59.6bp}\nointerlineskip%
\endgroup%
\ifx Y\PromoText
\AddToShipoutPictureBG*{%
\AtTextCenter{%
\makebox(0,0)[c]{\resizebox{\textwidth}{!}{%
\rotatebox{45}{\fontseries{b}\fontsize{53}{53}\selectfont\color{twentyfive}Promotional
Use}}} } }\else\fi{#1}}


\newcommand*\l@fmchapter[2]{\normalfont\fontsize{8.5}{11}\selectfont%
  \ifnum \c@tocdepth >\m@ne
    \addpenalty{-\@highpenalty}%
%    \vskip 6pt% \@plus\p@
    \setlength\@tempdima{12em}%
    \begingroup
      \parindent \z@ \rightskip \@pnumwidth
      \parfillskip -\@pnumwidth
      \leavevmode %\bfseries
      \advance\leftskip\@tempdima
      \hskip -\leftskip
      #1\nobreak\hfil \nobreak\hb@xt@\@pnumwidth{\normalfont\hss #2}\par
      \penalty\@highpenalty
    \endgroup
  \fi
 \vskip 6.5pt% \@plus\p@  
}




%%6x9
\renewcommand*\l@part{\@dottedtoclinepart{1}{0pc}{16pt}}
\renewcommand*\l@chapter{\@dottedtoclinechap{1}{0pc}{16pt}}

\newcommand*\l@chapterast{\@dottedtoclinechapast{1}{0pc}{5em}}

\newcommand*\l@chapauthor{\@dottedtoclineauthor{1}{16pt}{0em}}


\renewcommand*\l@section{\@dottedtoclinesec{1}{16pt}{16pt}}
\newcommand*\l@ssection{\@dottedtoclinesec{1}{16pt}{2em}}
\newcommand*\l@sectionast{\@dottedtoclinesec{1}{40pt}{0pt}}
\renewcommand*\l@subsection{\@dottedtoclinesubsec{2}{40pt}{30pt}}

\newlength\@tempdimaa
\newlength\@tempdimab

\renewcommand\@pnumwidth{21pt}

\def\@dottedtoclinepart#1#2#3#4#5{{%
  \renewcommand\@dotsep{90}%
     \setlength\@tempdimaa{41pt}%
\def\numberline##1{\hb@xt@\@tempdima{\hfill{\fontsize{8.5}{11}\selectfont{##1}}}\hangindent10.4pt}%
\ifnum #1>\c@tocdepth \else
  \vskip4pt%
    \setlength\@tempdima{10pt}%
  {\leftskip #2\relax \rightskip \@tocrmarg \parfillskip -\rightskip%
    \parindent #2\relax\@afterindenttrue%
   \interlinepenalty\@M%
   \leavevmode%
   \@tempdima #3\relax \advance\leftskip \@tempdima\hskip -\leftskip%
    \bfseries\fontsize{10}{13}\selectfont \uppercase{#4}\nobreak\leaders\hbox{$\m@th \mkern \@dotsep mu \mkern \@dotsep
       mu$}\hfill \nobreak
           \hbox to\@pnumwidth{\hfil\reset@font\normalfont#5}\par}\fi\vskip11pt}}



\def\@dottedtoclinechap#1#2#3#4#5{{%
  \renewcommand\@dotsep{3}%
    \setlength\@tempdimab{16pt}%
\def\numberline##1{\hb@xt@\@tempdimab{{\fontsize{10}{13}\selectfont\bfseries{##1}}\hfil}\hangindent0pt}%
\ifnum #1>\c@tocdepth \else%
\vskip.1pt%
    \setlength\@tempdima{40pt}%
  {\leftskip #2\relax \rightskip \@tocrmarg \parfillskip -\rightskip
    \parindent #2\relax\@afterindenttrue%
   \interlinepenalty\@M
   \leavevmode
   \@tempdima #3\relax \advance\leftskip \@tempdima \hskip -\leftskip
    \fontsize{10}{13}\selectfont\bfseries#4\nobreak\leaders\hbox{$\m@th \mkern \@dotsep mu\mkern \@dotsep
       mu$}\hfill \nobreak
           \hbox to\@pnumwidth{\hfil\reset@font\normalfont#5}\par}\fi\vskip5pt}}


\def\@dottedtoclinechapast#1#2#3#4#5{{%
  \renewcommand\@dotsep{3}%
    \setlength\@tempdimab{4pc}%
\def\numberline##1{\hb@xt@\@tempdimab{{\fontsize{10}{13}\selectfont{##1}}\hfil}\hangindent0pt}%
\ifnum #1>\c@tocdepth \else%
\vskip.1pt%
    \setlength\@tempdima{40pt}%
  {\leftskip #2\relax \rightskip \@tocrmarg \parfillskip -\rightskip
    \parindent #2\relax\@afterindenttrue%
   \interlinepenalty\@M
   \leavevmode
   \@tempdima #3\relax \advance\leftskip \@tempdima \hskip -\leftskip
    \fontsize{10}{13}\selectfont#4\nobreak\leaders\hbox{$\m@th \mkern \@dotsep mu\mkern \@dotsep
       mu$}\hfill \nobreak
           \hbox to\@pnumwidth{\hfil\reset@font\normalfont#5}\par}\fi\vskip1pt}}


\def\@dottedtoclineauthor#1#2#3#4#5{{%
  \renewcommand\@dotsep{100}%
     \setlength\@tempdimaa{41pt}%
\def\numberline##1{\hb@xt@\@tempdima{\hfill{\fontsize{8.5}{11}\selectfont{##1}}}\hspace*{17pt}\hangindent80.4pt}%
\ifnum #1>\c@tocdepth \else
  \vskip-4pt%
    \setlength\@tempdima{40pt}%
  {\leftskip #2\relax \rightskip \@tocrmarg \parfillskip -\rightskip%
    \parindent #2\relax\@afterindenttrue%
   \interlinepenalty\@M%
   \leavevmode%
   \@tempdima #3\relax \advance\leftskip \@tempdima\hskip -\leftskip%
    \normalfont\fontsize{10}{13}\selectfont {#4}\nobreak\leaders\hbox{$\m@th \mkern \@dotsep mu \mkern \@dotsep
       mu$}\hfill \nobreak
           \hbox to\@pnumwidth{\hfil\reset@font\normalfont#5}\par}\fi\vskip5pt}}




\def\@dottedtoclinesec#1#2#3#4#5{{%
  \renewcommand\@dotsep{3}%
    \setlength\@tempdimab{2pc}%
\def\numberline##1{\hb@xt@\@tempdimab{{\fontsize{10}{13}\selectfont{##1}}\hfil}\hangindent8pt}%
\ifnum #1>\c@tocdepth \else%
\vskip-4pt%
    \setlength\@tempdima{40pt}%
  {\leftskip #2\relax \rightskip \@tocrmarg \parfillskip -\rightskip
    \parindent #2\relax\@afterindenttrue%
   \interlinepenalty\@M
   \leavevmode
   \@tempdima #3\relax \advance\leftskip \@tempdima \hskip -\leftskip
    \fontsize{10}{13}\selectfont#4\nobreak\leaders\hbox{$\m@th \mkern \@dotsep mu\mkern \@dotsep
       mu$}\hfill \nobreak
           \hbox to\@pnumwidth{\hfil\reset@font\normalfont#5}\par}\fi\vskip5pt}}


\def\@dottedtoclinesubsec#1#2#3#4#5{{%
  \renewcommand\@dotsep{3}%
    \setlength\@tempdimab{2.5pc}%
\def\numberline##1{\hb@xt@\@tempdimab{{\fontsize{10}{13}\selectfont{##1}}\hfil}\hangindent0pt}%
\ifnum #1>\c@tocdepth \else%
\vskip-4pt%
    \setlength\@tempdima{40pt}%
  {\leftskip #2\relax \rightskip \@tocrmarg \parfillskip -\rightskip
    \parindent #2\relax\@afterindenttrue%
   \interlinepenalty\@M
   \leavevmode
   \@tempdima #3\relax \advance\leftskip \@tempdima \hskip -\leftskip
    \fontsize{10}{13}\selectfont#4\nobreak\leaders\hbox{$\m@th \mkern \@dotsep mu\mkern \@dotsep
       mu$}\hfill \nobreak
           \hbox to\@pnumwidth{\hfil\reset@font\normalfont#5}\par}\fi\vskip5pt}}

\newcommand{\textslc}[1]{%
   \tikz[baseline=(N.base)]%
   % The transform says:
   % x' = 1x + 0.22y + 0pt
   % y' = 0x + 1y    + 0pt
   % This gives a slant - adjust the value for each font!
   \pgfsys@transformcm{1}{0}{0.22}{1}{0pt}{0pt}%
   \node[inner sep=0pt] (N) {#1};%
}








% %%%%%%%%%%% MATH KEYWORDS %%%%%%%%%%%%%%%%%%%%%%%%%%
\DeclareMathOperator*{\argmin}{arg~min}
\DeclareMathOperator*{\argmax}{arg~max}
\DeclareMathOperator{\dom}{dom}
\DeclareMathOperator{\interior}{int}
\DeclareMathOperator{\rank}{rank}
\DeclareMathOperator{\ri}{ri}
\DeclareMathOperator{\sgn}{sgn}
\DeclareMathOperator{\trace}{Tr}
\DeclareMathOperator{\Diag}{Diag}
\DeclareMathOperator{\range}{range}
\DeclareMathOperator{\vect}{vec}
\DeclareMathOperator{\prox}{prox}
\DeclareMathOperator{\intr}{int}
\DeclareMathOperator{\relint}{ri}


%%Theorem defined by mu

\let\proof\relax
\let\endproof\relax

\usepackage{amsthm}

\thm@notefont{\bfseries}

\def\thmhead@plain#1#2#3{%
  \thmname{#1}\thmnumber{\@ifnotempty{#1}{ }\@upn{#2}\hspace*{4pt}}%
  \thmnote{\hspace*{4pt}{\the\thm@notefont\bf#3}}}

\newtheoremstyle{headfourmath}
    {7.2pt}% above space (default) plus 5\p@ minus 2\p@
    {7.2pt}% below space plus 5\p@ minus 2\p@
    {}% body
    {0em}% indent
    {\scshape}% head
    {}% punct
    {.6em}% space
    {}% custom

\theoremstyle{headfourmath}
\newtheorem{theorem}{Theorem}[chapter]
\newtheorem{definition}[theorem]{Definition}
\newtheorem{proposition}[theorem]{Proposition}
\newtheorem{corollary}[theorem]{Corollary}
\newtheorem{lemma}[theorem]{Lemma}
\newtheorem{assumption}[theorem]{Assumption}
\newtheorem{rules}[theorem]{Rules}


\newtheoremstyle{headfivemath}
    {7.2pt}% above space (default) plus 5\p@ minus 2\p@
    {7.2pt}% below space plus 5\p@ minus 2\p@
    {}% body
    {0em}% indent
    {\itshape}% head
    {}% punct
    {.5em}% space
    {}% custom


\theoremstyle{headfivemath}
\newtheorem{examples}{Example}[chapter]
\newtheorem{remark}{Remark}[chapter]
\newtheorem{demonstrations}{Demonstrations}[chapter]
\newtheorem{solution}{Solution}[chapter]

\newtheoremstyle{boxheaddef}
    {24pt}% above space (default) plus 5\p@ minus 2\p@
    {0pt}% below space plus 5\p@ minus 2\p@
    {\fontsize{8}{9}\selectfont}% body
    {0em}% indent
    {\fontsize{8}{9}\selectfont\bfseries}% head
    {}% punct
    {.5em}% space
    {}% custom

\theoremstyle{boxheaddef}
\newtheorem{xboxhead}{Box}

%\bibpunct[, ]{(}{)}{;}{a}{}{,}

\def\notesname{NOTES}%

\def\enoteheading{\section*{\notesname}%
  \mbox{}\par\vskip-\baselineskip\vskip4pt}

\def\enotesize{\fontsize{7}{9}\selectfont}


\def\thetextendnotes#1{\immediate\closeout\@enotes \global\@enotesopenfalse
  \begingroup
    \makeatletter
    %
    % The machinery with \@ResetGT and > here ensures that
    % \@doanenote works properly even if > is an active character
    % at the point where \theendnotes is invoked. > needs to have
    % catcode 12 when the arguments of \@doanenote are scanned, so
    % that the > in the string "macro:->" is matched.  The actual
    % footnote text is not an argument to \@doanenote, but just
    % follows it in the .ent file; so \@ResetGT can reset the
    % category code for > that should be used when processing
    % that text.  That resetting takes place within a
    % \begingroup-\endgroup block set up by \@doanenote and
    % \@endanenote, so the catcode for > is back to 12 for the
    % next note.
    %
    \edef\@tempa{`\string >}%
    \ifnum\catcode\@tempa=12%
      \let\@ResetGT\relax
    \else
      \edef\@ResetGT{\noexpand\catcode\@tempa=\the\catcode\@tempa}%
      \@makeother\>%
    \fi
    \def\@doanenote##1##2>{\def\@theenmark{##1}\par\begingroup
        \@ResetGT
        \edef\@currentlabel{\csname p@endnote\endcsname\@theenmark}%
        \enoteformat}
    \def\@endanenote{\par\endgroup}%
    \enoteheading
    \enotesize
    \noindent#1\par\vskip6pt%
    \input{\jobname.ent}%
  \endgroup}



\def\XC@display
 {\XC@bcolor\XC@let@cN{\string\color@.}\XC@current@color
  \ifnum\XC@type{.}=1
\else
  \ifnum\XC@tracing>2
    \begingroup \let\xcolor@\@empty \def\@nil{\string\@nil}%
    \PackageInfo{xcolor}{Setting color `\XC@current@color'}%
    \endgroup
  \fi\fi
  \XC@mcolor\set@color\XC@ecolor\ignorespaces}




\def\hangparbox#1{\hspace*{\algorithmicindent}\parbox[t]{\dimexpr\linewidth-\algorithmicindent-\algorithmicindent}{%
  \hspace*{-\algorithmicindent}#1\par\vskip4pt}}

\def\exsource#1{\enspace(#1)}

\newenvironment{extract}
               {\list{}{\let\source\exsource\fontsize{9}{11}\selectfont\topsep=9pt%
               \listparindent0pt%
                        \itemindent0pt%
                        \labelsep=0pt%
                        \rightmargin0pt%
                        \leftmargin0pt%
                        \parsep0pt}%
                \item\relax}
               {\endlist\vskip-2pt}


\newenvironment{appextract}
               {\list{}{\let\source\exsource\fontsize{8}{9}\selectfont\topsep=7pt%
               \listparindent0pt%
                        \itemindent-5pt%
                        \labelsep=0pt%
                        \rightmargin0pt%
                        \leftmargin2pc%
                        \parsep0pt}% 
                \item\relax}
               {\endlist\vskip2pt}


\newenvironment{boxextract}
               {\list{}{\let\source\exsource\fontsize{8}{9}\selectfont\topsep=11pt%
               \listparindent0pt%
                        \itemindent0pt%
                        \labelsep=0pt%
                        \rightmargin0pt%
                        \leftmargin2pc%
                        \parsep0pt}% 
                \item\relax}
               {\endlist\vskip2pt}


\def\extenumargs{%
   \leftmargini   0pt
   \topsep     7pt
   \itemsep       3pt
   \parsep        \z@
   \labelsep      6.1pt
   \rightmargin   \z@
   \listparindent \parindent
   \itemindent    \z@}

\def\extractlist{%
    \@ifnextchar[{\@extnumerate}{\@extnumerate[0.]}}

\def\@extnumerate[#1]{%
     \ifnum \@enumdepth >3 \@toodeep\else
     \advance\@enumdepth \@ne
     \edef\@enumctr{enum\romannumeral\the\@enumdepth}
     \list{\csname label\@enumctr\endcsname}{%
       \extenumargs
       \setlength{\leftmargin}{\csname leftmargin\romannumeral\the\@enumdepth\endcsname}
       \usecounter{\@enumctr}
       \settowidth\labelwidth{#1}
       \addtolength{\itemindent}{\labelwidth}
       \addtolength{\itemindent}{\labelsep}
       \def\makelabel##1{\hss\llap{{##1}}}}%
     \fi
   }
\let\endextractlist\endlist


\def\seriesenumargs{%
   \leftmargini   0pt
   \topsep     25.5pt
   \itemsep       10pt
   \parsep        \z@
   \labelsep      6.1pt
   \rightmargin   \z@
   \listparindent \parindent
   \itemindent    \z@}

\def\seriesentry{\let\labelenumi\numsenlabelenumi%%
    \@ifnextchar[{\@seriesnumerate}{\@seriesnumerate[0]}}

\def\@seriesnumerate[#1]{%
     \ifnum \@enumdepth >3 \@toodeep\else
     \advance\@enumdepth \@ne
     \edef\@enumctr{enum\romannumeral\the\@enumdepth}
     \list{\csname label\@enumctr\endcsname}{%
       \seriesenumargs\itshape
       \setlength{\leftmargin}{\csname leftmargin\romannumeral\the\@enumdepth\endcsname}
       \usecounter{\@enumctr}
       \settowidth\labelwidth{#1}
       \addtolength{\itemindent}{\labelwidth}
       \addtolength{\itemindent}{\labelsep}
       \def\makelabel##1{\hss\llap{{\normalfont##1}}}}%
     \fi
   }
\let\endseriesentry\endlist


\newcommand\numsenlabelenumi{\theenumi}
\def\numsenenumargs{%
   \leftmargini   0pt
   \topsep     7pt
   \itemsep       7pt
   \parsep        \z@
   \labelsep      6.1pt
   \rightmargin   \z@
   \listparindent \parindent
   \itemindent    \z@}

\def\numsentence{\let\labelenumi\numsenlabelenumi%
    \@ifnextchar[{\@numsennumerate}{\@numsennumerate[(0)]}}

\def\@numsennumerate[#1]{%
     \ifnum \@enumdepth >3 \@toodeep\else
     \advance\@enumdepth \@ne
     \edef\@enumctr{enum\romannumeral\the\@enumdepth}
     \list{(\csname label\@enumctr\endcsname)}{%
       \numsenenumargs\raggedright
       \setlength{\leftmargin}{\csname leftmargin\romannumeral\the\@enumdepth\endcsname}
       \usecounter{\@enumctr}
       \settowidth\labelwidth{#1}
       \addtolength{\itemindent}{\labelwidth}
       \addtolength{\itemindent}{\labelsep}
       \def\makelabel##1{\hss\llap{{##1}}}}%
     \fi
   }
\let\endnumsentence\endlist

\def\unnumsenenumargs{%
   \leftmargini   0pt
   \topsep     7pt
   \itemsep       7pt
   \parsep        \z@
   \labelsep      6.1pt
   \rightmargin   \z@
   \listparindent 0pt
   \itemindent    \z@}

\def\unnumsentence{%
    \@ifnextchar[{\@unnumsennumerate}{\@unnumsennumerate[(0)]}}

\def\@unnumsennumerate[#1]{%
     \ifnum \@enumdepth >3 \@toodeep\else
     \advance\@enumdepth \@ne
     \edef\@enumctr{enum\romannumeral\the\@enumdepth}
     \list{}{%
       \unnumsenenumargs\raggedright
       \setlength{\leftmargin}{\csname leftmargin\romannumeral\the\@enumdepth\endcsname}
       \usecounter{\@enumctr}
       \settowidth\labelwidth{#1}
%       \addtolength{\itemindent}{\labelwidth}
%       \addtolength{\itemindent}{\labelsep}
       \def\makelabel##1{\hss\llap{{##1}}}}%
     \fi
   }
\let\endunnumsentence\endlist



\def\diaenumargs{%
   \leftmargini   0pt
   \topsep     7pt
   \itemsep       3pt
   \parsep        \z@
   \labelsep      6.1pt
   \rightmargin   \z@
   \listparindent \parindent
   \itemindent    \z@}

\def\dialogue{%
    \@ifnextchar[{\@dianumerate}{\@dianumerate[(0)]}}

\def\speak#1{\item[]\textit{#1}\enspace}
\def\speaks#1{\item[]\textit{#1}\enspace}

\def\@dianumerate[#1]{%
     \ifnum \@enumdepth >3 \@toodeep\else
     \advance\@enumdepth \@ne
     \edef\@enumctr{enum\romannumeral\the\@enumdepth}
     \list{(\csname label\@enumctr\endcsname)}{%
       \diaenumargs
       \setlength{\leftmargin}{\csname leftmargin\romannumeral\the\@enumdepth\endcsname}
       \usecounter{\@enumctr}
       \settowidth\labelwidth{#1}
%       \addtolength{\itemindent}{\labelwidth}
%       \addtolength{\itemindent}{\labelsep}
       \def\makelabel##1{\hss\llap{{##1}}}}%
     \fi
   }
\let\enddialogue\endlist


%table
\newif\if@rotate \@rotatefalse
\newif\if@rotatecenter \@rotatecenterfalse
\def\rotatecenter{\global\@rotatecentertrue}
\def\rotateendcenter{\global\@rotatecenterfalse}
\def\rotate{\global\@rotatetrue}
\def\endrotate{\global\@rotatefalse}
\newdimen\rotdimen
\def\rotstart#1{\special{ps: gsave currentpoint currentpoint translate
    #1 neg exch neg exch translate}}
\def\rotfinish{\special{ps: currentpoint grestore moveto}}
\def\rotl#1{\rotdimen=\ht#1\advance\rotdimen by \dp#1
    \hbox to \rotdimen{\vbox to\wd#1{\vskip \wd#1
    \rotstart{270 rotate}\box #1\vss}\hss}\rotfinish}
\def\rotr#1{\rotdimen=\ht #1\advance\rotdimen by \dp#1
    \hbox to \rotdimen{\vbox to \wd#1{\vskip \wd#1
    \rotstart{90 rotate}\box #1\vss}\hss}\rotfinish}


\newdimen\tempdime
\newbox\temptbox


\newlength{\tabbotskip}%
\setlength{\tabbotskip}{\z@}%


\newenvironment{processtable}[3]{\setbox\temptbox=\hbox{{\fontsize{8}{9}\selectfont#2}}%
\tempdime\wd\temptbox\@processtable{#1}{#2}{#3}{\tempdime}}
{\relax}

\newenvironment{@processtable}[4]{%
\if@rotate
\setbox4=\vbox to \textwidth{\vss\hbox to \textheight{\hss%
\begin{minipage}{#4}%
\fontsize{8}{9}\selectfont%
\caption{#1}{#2}%
\vskip1pt\noindent
\parbox{#4}{\fontsize{8}{9}\selectfont\raggedright #3\par}%
\end{minipage}}\vss}%
\else
\setbox4=\hbox to \textwidth{\vbox{\begin{minipage}[t]{#4}%
\fontsize{8}{9}\selectfont%
\caption{#1}{#2}%
\vskip2.5pt\noindent
\parbox{#4}{\fontsize{8}{9}\selectfont #3\vphantom{y}\par}%
\if!#3!\setlength{\tabbotskip}{-19\p@}\else\setlength{\tabbotskip}{-9.3\p@}\fi%
%\vspace*{\tabbotskip}%
\end{minipage}}}%
\fi
\if@rotate\rotl{4}\else\box4\fi}
{\relax}

\newenvironment{unprocesstable}[3]{\setbox\temptbox=\hbox{{#2}}%
\tempdime\wd\temptbox\@unprocesstable{#1}{#2}{#3}{\tempdime}}
{\relax}

\newenvironment{@unprocesstable}[4]{%
\if@rotate
\setbox4=\vbox to \textwidth{\vss\hbox to \textheight{\hss%
\begin{minipage}{#4}%
\fontsize{10}{13}\selectfont
%\caption
{#1}{#2}%
\vskip1pt\noindent
\parbox{#4}{\fontsize{10}{13}\selectfont #3\par}%
\end{minipage}}\vss}%
\else
\setbox4=\hbox to \textwidth{\vbox{\begin{center}\begin{minipage}[t]{#4}%
\fontsize{10}{13}\selectfont
%\caption
{#1}{#2}%
\vskip.5pt\noindent
\parbox{#4}{\fontsize{10}{13}\selectfont\raggedright#3\vphantom{y}\par}%
\if!#3!\setlength{\tabbotskip}{-19\p@}\else\setlength{\tabbotskip}{-9.3\p@}\fi%
\vspace*{\tabbotskip}%
\end{minipage}\end{center}}}%
\fi
\if@rotate\rotl{4}\else\box4\fi}
{\relax}


%%exercise

\def\exerciseenumargs{%
   \leftmargini   0pt
   \topsep     7pt
   \itemsep       7.1pt
   \parsep        \z@
   \labelsep      19pt
   \rightmargin   \z@
   \listparindent \parindent
   \itemindent    \z@}

\def\exerciseenumerate{\let\enumerate\exersubenumerate%
    \@ifnextchar[{\@exercisenumerate}{\@exercisenumerate[0.]}}

\def\@exercisenumerate[#1]{%
     \ifnum \@enumdepth >3 \@toodeep\else
     \advance\@enumdepth \@ne
     \edef\@enumctr{enum\romannumeral\the\@enumdepth}
     \list{\csname label\@enumctr\endcsname}{%
       \exerciseenumargs\fontsize{8}{9}\selectfont
       \setlength{\leftmargin}{\csname leftmargin\romannumeral\the\@enumdepth\endcsname}
       \usecounter{\@enumctr}
       \settowidth\labelwidth{#1}
       \addtolength{\leftmargin}{\labelwidth}
       \addtolength{\leftmargin}{\labelsep}
       \def\makelabel##1{\hss\llap{{##1}}}}%
     \fi
   }
\let\endexerciseenumerate\endlist


\def\exersubenumargs{%
   \leftmargini   0pt
   \topsep     3pt
   \itemsep       3pt
   \parsep        \z@
   \labelsep      6.1pt
   \rightmargin   \z@
   \listparindent \parindent
   \itemindent    \z@}

\def\exersubenumerate{\let\enumerate\subsubenumerate%
    \@ifnextchar[{\@exersubnumerate}{\@exersubnumerate[0.]}}

\def\@exersubnumerate[#1]{%
     \ifnum \@enumdepth >3 \@toodeep\else
     \advance\@enumdepth \@ne
     \edef\@enumctr{enum\romannumeral\the\@enumdepth}
     \list{\csname label\@enumctr\endcsname}{%
       \exersubenumargs
       \setlength{\leftmargin}{\csname leftmargin\romannumeral\the\@enumdepth\endcsname}
       \usecounter{\@enumctr}
       \settowidth\labelwidth{#1}
       \addtolength{\itemindent}{\labelwidth}
       \addtolength{\itemindent}{\labelsep}
       \def\makelabel##1{\hss\llap{{##1}}}}%
     \fi
   }
\let\endsubenumerate\endlist

\def\subsubenumargs{%
   \leftmargini   0pt
   \topsep     3pt
   \itemsep       3pt
   \parsep        \z@
   \labelsep      4pt
   \rightmargin   \z@
   \listparindent \parindent
   \itemindent    \z@}

\def\subsubenumerate{%
    \@ifnextchar[{\@subsubnumerate}{\@subsubnumerate[0.]}}

\def\@subsubnumerate[#1]{%
     \ifnum \@enumdepth >3 \@toodeep\else
     \advance\@enumdepth \@ne
     \edef\@enumctr{enum\romannumeral\the\@enumdepth}
     \list{\csname label\@enumctr\endcsname}{%
       \subsubenumargs
       \setlength{\leftmargin}{\csname leftmargin\romannumeral\the\@enumdepth\endcsname}
       \usecounter{\@enumctr}
       \settowidth\labelwidth{#1}
       \addtolength{\itemindent}{\labelwidth}
       \addtolength{\itemindent}{\labelsep}
       \def\makelabel##1{{{##1}}}}%
     \fi
   }
\let\endsubsubenumerate\endlist

%\markboth{Exercises}{}
\newenvironment{exercises} 
               {\chapter*{Exercises}\fontsize{8}{9}\selectfont\let\enumerate\exerciseenumerate}
               {}


%%notes
\def\notesenumargs{%
   \leftmargini   0pt
   \topsep     7pt
   \itemsep       3pt
   \parsep        \z@
   \labelsep      6.1pt
   \rightmargin   \z@
   \listparindent \parindent
   \itemindent    \z@}

\def\notes{\pagestyle{bmheadings}%
    \@ifnextchar[{\@notesnumerate}{\@notesnumerate[0.]}}

\def\@notesnumerate[#1]{%
     \ifnum \@enumdepth >3 \@toodeep\else
     \advance\@enumdepth \@ne
     \edef\@enumctr{enum\romannumeral\the\@enumdepth}
     \list{\csname label\@enumctr\endcsname}{%
       \notesenumargs\fontsize{8}{9}\selectfont
       \setlength{\leftmargin}{\csname leftmargin\romannumeral\the\@enumdepth\endcsname}
       \usecounter{\@enumctr}
       \settowidth\labelwidth{#1}
       \addtolength{\leftmargin}{\labelwidth}
       \addtolength{\leftmargin}{\labelsep}
       \def\makelabel##1{\hss\llap{{##1}}}}%
     \fi
   }
\let\endnotes\endlist


%%glossary
\def\glosssenumargs{%
   \leftmargini   -12pt
   \topsep     7pt
   \itemsep       7pt
   \parsep        \z@
   \labelsep      6.1pt
   \rightmargin   \z@
   \listparindent \parindent
   \itemindent    12pt}

\def\glossary{%
    \@ifnextchar[{\@glossnumerate}{\@glossnumerate[0.]}}

\def\@glossnumerate[#1]{%
     \ifnum \@enumdepth >3 \@toodeep\else
     \advance\@enumdepth \@ne
     \edef\@enumctr{enum\romannumeral\the\@enumdepth}
     \list{\csname label\@enumctr\endcsname}{%
       \glosssenumargs\fontsize{8}{9}\selectfont
       \setlength{\leftmargin}{\csname leftmargin\romannumeral\the\@enumdepth\endcsname}
       \usecounter{\@enumctr}
       \settowidth\labelwidth{#1}
       \addtolength{\leftmargin}{\labelwidth}
       \addtolength{\leftmargin}{\labelsep}
       \def\makelabel##1{{\fontsize{8}{9}\selectfont\textbf{##1}}}}%
     \fi
   }
\let\endglossary\endlist



\usepackage[numbers,sort&compress,comma]{natbib}

\def\refname{Bibliography}

\def\thebibliography#1{\chapter*{\refname}%
\@mkboth{{\refname}}{{\refname}}%
\fontsize{8}{9}\selectfont\list
   {[\arabic{enumi}]}{\settowidth\labelwidth{[#1]}
   \leftmargin\labelwidth
   \advance\leftmargin\labelsep
%   \advance\leftmargin\bibindent
 %  \itemindent -\bibindent
   \listparindent \itemindent
   \parsep \z@
   \itemsep3pt
   \usecounter{enumi}}
   \def\newblock{}
   \sloppy
   \sfcode`\.=1000\relax}

\usepackage{floatpag}
\rotfloatpagestyle{headings}

\setcounter{Maxaffil}{2}
\makeatother
%%%%%%%%%%%%%%%%%%%%%%%%%%%%


\endinput
%%
%% End of file `EDDT-MIT.cls'.
