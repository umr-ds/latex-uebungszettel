%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LaTeX document for Exercises
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (c) 2005 by Tobias Schuh, FG ST, TU Darmstadt
% (c) 2017 adjustments by Milan Schmittner, SEEMOO, TU Darmstadt
% (c) 2017 adjustments by Hameer Abbasi and Robin Klose, SEEMOO, TU Darmstadt
% (c) 2017 adjustments by Artur Sterz and Jonas Höchst, Distributed Systems, Uni Marburg
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Identification %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{exercise}[2017/10/23]

\LoadClass[a4paper,10pt]{article}

\RequirePackage{ifthen}

\newboolean{@solution}
\setboolean{@solution}{false}
\newboolean{@compoundproblem}
\setboolean{@compoundproblem}{false}

% Options-Definition %%%%%%%%%%%%%%%%%%%%%%%%%%%%
\DeclareOption{solution}{\setboolean{@solution}{true}}

% Options-Execution %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\ProcessOptions

% packages%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage{ngerman}          % deutsche Strukturtexte
\PassOptionsToPackage{ngerman}{babel}
\PassOptionsToPackage{german}{hyperref}

\RequirePackage[utf8]{inputenc}
\RequirePackage[hidelinks]{hyperref}
\RequirePackage[headsepline,footsepline]{scrlayer-scrpage} %% KOMA header and footer
\RequirePackage{geometry}               % Detailierte Angabe von Seitenabst‰nden.
\RequirePackage{listings}               % Code-Beispiele
\RequirePackage{verbatim}
\RequirePackage{enumerate}
\RequirePackage[shortlabels]{enumitem}
\RequirePackage{array}
\RequirePackage{tabularx}               % Tabellen
\RequirePackage{multirow}
\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{xcolor}                 % verschiedene Boxen-Typen
\RequirePackage{etoolbox}               % For some various utility commands
\RequirePackage{pgffor}                 % For looping programatically
\RequirePackage{titlesec}
\RequirePackage{multirow}

\ifpdf
    \RequirePackage[pdftex]{graphicx}   % Grafiken
\else
    \RequirePackage[]{graphicx}         % Grafiken
\fi

\newcommand{\@examtypeblock}{}

\RequirePackage{courier}
\RequirePackage{helvet}
\renewcommand{\familydefault}{\sfdefault}
\def\arraystretch{1.2}

% Enables retrieval of ENV variables (https://tex.stackexchange.com/questions/62010/can-i-access-system-environment-variables-from-latex-for-instance-home/62032#62032)
\RequirePackage{catchfile}
\RequirePackage[ngerman]{babel}
\def\true{true }
\newcommand{\getenv}[2][]{%
  \CatchFileEdef{\temp}{"|kpsewhich --var-value #2"}{}%
  \if\relax\detokenize{#1}\relax\temp\else\let#1\temp\fi}

% if the SOLUTIONS env variable is set, solutions will be printed
\getenv[\SOLUTION]{SOLUTION}
\ifx\SOLUTION\true
	\setboolean{@solution}{true}
\fi


% def-commands %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\@solutiontitle{Lösungsvorschlag}
\def\@logo{base/marburg}

\def\@points{Punkte}
\def\@point{Punkt}

\def\@allowedresourcetitle{Erlaubte Hilfsmittel}
\def\@generalhintstitle{Hinweise}

\def\@correctionschematitle{Korrekturschema}

\def\@firstname{Vorname}
\def\@lastname{Nachname}
\def\@studyid{Matrikelnummer}
\def\@fb{Studiengang}
\def\@study{Semester}
\def\@code{Codewort}
\def\@studyregulations{Studienordnung}
\def\@lasttry{Letzter Prüfungsversuch?}
\def\@yes{Ja}
\def\@no{Nein}
\def\@twtruebox{w}

\def\@titleproblem{\textbf{Aufgabe}}
\def\@titleachievable{\textbf{Erreichbar}}
\def\@titlepoints{\textbf{Punkte}}
\def\@titlestudyid{Mat.Nr.}
    
\def\@titlegrade{Note}
\def\@titlefinalgrade{\textbf{Note}}


% set first line indent %%%%%%%%%%%%%%%%%%%%
\setlength{\parindent}{0em}

% make compact lists
\setitemize{noitemsep}

% Page definitions %%%%%%%%%%%%%%%%%%%%%%%%%
\geometry{left=1.5cm,right=1.5cm}
\geometry{top=2cm,bottom=2cm}

% Header & Footer %%%%%%%%%%%%%%%%%%%%%%%%%%
\pagestyle{scrheadings}

\ihead{\textsf{\@studyid:} \hspace{4cm}}
\ohead{}

% Footer
\ofoot{\thepage~/~\pageref{page:lastpage}}
\ifoot{\footnotesize
    \@course{} -- \@semester{} --  \@examtypeblock{}
}

%\scrlayer-scrpage{
%headsepline,                %% Separation line below the header
%footsepline,               %% Separation line above the footer
%}

% listing settings %%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\setlst}{
    \lstset{
        basicstyle=\small\ttfamily,
        tabsize=3,
        numbers=left,
        numberstyle=\tiny,
        frame=single,
        breaklines=true,
        breakindent=10pt,
        xleftmargin=3em,
        xrightmargin=1em,
	    frame=tlbr,
	    framesep=.5em,
	    framerule=0pt,
		showstringspaces=false
    }
}


% set pdf infos %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\setpdfinfo}{
    \ifpdf
        \hypersetup{
            pdftitle={\@course{} -- \@semester{}},
                pdfauthor={\@author},
                pdfsubject={\@course},
                pdfkeywords={},
                pdfview=Fit
        }
    \fi
}

\newcommand{\@exercisenumberblock}{}
\newcommand{\exercisenumber}[1] {\renewcommand{\@exercisenumberblock}{#1}}

% SetTitlePage %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\setTitlePage} {

	\vspace*{-1.5cm}
    \raisebox{-0.5\height}{\includegraphics[width=5cm]{\@logo}}
	\hfill
    \begin{minipage}{0.45\textwidth}
        \begin{flushright}
            Fachbereich Mathematik und Informatik\\
			\href{https://ds.mathematik.uni-marburg.de}{\textbf{AG Verteilte Systeme}}\\
			Prof. Dr. Bernd Freisleben
        \end{flushright}
    \end{minipage}

	\begin{center}

	\huge{\textbf{\@examtypeblock}}\\
	\vspace{0.5\baselineskip}
	\Large{\@course{} -- \@semester{}}\\
	\large{\@examdatetime}

    \vspace{3\baselineskip}

    %% Personal information
    \begin{minipage}[!h]{\textwidth}
        \centering
        \begin{tabular}{|r|p{8cm}|}
            \hline
            \@firstname&\\ \hline
            \@lastname&\\ \hline
            \@code&\\ \hline
            \@studyid&\\ \hline
            \@fb&\\ \hline
            \@studyregulations&\\ \hline
            \@study&\\ \hline
            \@lasttry & \qquad \qquad $\square$ \@yes \qquad \qquad \qquad $\square$ \@no \\ \hline
        \end{tabular}
    \end{minipage}

    \vspace{2\baselineskip}

    %% General hints
    \section*{\@generalhintstitle}
    \@generalhints

    \vspace{5\baselineskip}

    %% Points Table
    \@markstable

    \end{center}

    \clearpage
}

% public set commands %%%%%%%%%%%%%
% \newcommand{\titlepageheader}[1]{\def\@titlepageheader{#1}}
\newcommand{\course}[1]{\def\@course{#1}}
\newcommand{\semster}[1]{\def\@semester{#1}}
\newcommand{\returndate}[1]{\def\@returndate{#1}}
\newcommand{\allowedresources}[1]{\def\@allowedresources{#1}}
\newcommand{\markstable}[1]{\def\@markstable{#1}}
\newcommand{\points}[1]{\ifnum\pdf@strcmp{#1}{1}=\z@ \textbf{#1~\@point} \else \textbf{#1~\@points} \fi}
\newcommand{\examdatetime}[1]{\def\@examdatetime{#1}}
\newcommand{\generalhints}[1]{\def\@generalhints{#1}}

% Signature
\newcommand{\signature}[2]{
    \par\noindent\makebox[#1]{\hrulefill}
    \par\noindent\makebox[#1][l]{\textbf{#2}}
}

\newcommand{\examtype}[1] {\renewcommand{\@examtypeblock}{#1}}

% solution - environment %%%%%%%%%%
\ifthenelse{\boolean{@solution}} {
    \newenvironment{solution}{\color[rgb]{0.082, 0.153, 0.379} \bigskip \textbf{\@solutiontitle:}}{\color[rgb]{0,0,0}}
    % \newenvironment{solution}{\color[rgb]{0.584, 0.639, 0.729} \bigskip \textbf{\@solutiontitle:}}{\color[rgb]{0,0,0}}
}{
    \def\solution{\@bsphack
        \let\do\@makeother\dospecials\catcode`\^^M\active
        \let\verbatim@startline\relax
        \let\verbatim@addtoline\@gobble
        \let\verbatim@processline\relax
        \let\verbatim@finish\relax
        \verbatim@}
    \let\endsolution=\@esphack
}


% solution specials %%%%%%%%%%%%%%%%%%%%
\ifthenelse{\boolean{@solution}} {
%   \newcommand{\truebox}{$\boxtimes $~}
    \newcommand{\calcsolution}[1]{\textbf{~#1}}
    \newcommand{\solutionspace}[1]{}
    \newcommand{\solutionpagebreak}[1]{\pagebreak}
    \newcommand{\solutionpagefeed}[1]{\pagebreak}
}{
%   \newcommand{\truebox}{$\square $~}
    \newcommand{\calcsolution}[1]{}
    \newcommand{\solutionspace}[1]{\mbox{}\\[#1 plus 0.5cm minus 0.5cm]}
    \newcommand{\solutionpagebreak}[1]{\pagebreak}
    \newcommand{\solutionpagefeed}[1]{\pagebreak\ \pagebreak}
}

% tam changed the boxes to the following
% and added a \mynewpage command
\ifthenelse{\boolean{@solution}} {
    \newcommand{\falsebox}{\@twtruebox$\square $~f$\boxtimes $~}
    \newcommand{\truebox}{\@twtruebox$\boxtimes $~f$\square $~}
    \newcommand{\mynewpage}{}
}{
    \newcommand{\truebox}{\@twtruebox$\square $~f$\square $~}
    \newcommand{\falsebox}{\@twtruebox$\square $~f$\square $~}
    \newcommand{\mynewpage}{\newpage}
}



% at document begin
\AtBeginDocument{
    \setpdfinfo
    \setlst
    \thispagestyle{empty}
    \setTitlePage
}

% at document end
\AtEndDocument{
    \label{page:lastpage}
}

% Get the number of points associated with a particular exercise part/section
\newcommand\sectionpoints[1]{\csname sectionpointcounter@s#1\endcsname}

% Get the number of points associated with a particular exercise problem
\newcommand\problempoints[2]{\csname problempointcounter@s#1p#2\endcsname}

% Set a section point counter to a given value
\newcommand\definesectionpoints[2]{%
    \expandafter\edef\csname sectionpointcounter@s#1\endcsname{#2}%
}%

% Set a problem point counter to a given value
\newcommand\defineproblempoints[3]{%
    \expandafter\edef\csname problempointcounter@s#1p#2\endcsname{#3}%
}%

%% Set a counter for the number of total problems in a section to a given value
\newcommand\definetotalproblems[2]{%
    \expandafter\edef\csname totalproblems@s#1\endcsname{#2}%
}%

% Add a given number of points to a section point counter (used when a new subsection is encountered)
\newcommand\addtosectionpoints[2]{%
    \expandafter\edef\csname sectionpointcounter@s#1\endcsname{\the\numexpr\csname sectionpointcounter@s#1\endcsname+#2\relax}%
}%

% Add a given number of points to a problem point counter
\newcommand\addtoproblempoints[3]{%
    \expandafter\edef\csname problempointcounter@s#1p#2\endcsname{\the\numexpr\csname problempointcounter@s#1p#2\endcsname+#3\relax}%
}%

% Store a section point counter to the aux file
\newcommand\storesectionpoints[1]{%
    \immediate\write\@mainaux{%
        \string\expandafter\gdef\noexpand\csname sectionpointcounter@s#1\string\endcsname{\csname sectionpointcounter@s#1\endcsname}%
    }%
}%

% Store a problem point counter to the aux file
\newcommand\storeproblempoints[2]{%
    \immediate\write\@mainaux{%
        \string\expandafter\gdef\noexpand\csname problempointcounter@s#1p#2\string\endcsname{\csname problempointcounter@s#1p#2\endcsname}%
    }%
}%

% Store the total number of sections to the aux file
\newcommand\storetotalsections{%
    \immediate\write\@mainaux{%
        \string\expandafter\gdef\noexpand\csname totalsections@\string\endcsname{\arabic{section}}%
    }%
}%

% Store the total number of problems of a section to the aux file
\newcommand\storetotalproblems[1]{%
    \immediate\write\@mainaux{%
        \string\expandafter\gdef\noexpand\csname totalproblems@s#1\string\endcsname{\csname totalproblems@s#1\endcsname}%
    }%
}%

% Store the total number of points to the aux file
\newcommand\storetotalpoints{%
    \newcounter{pp}%
    \foreach \ii in {1,...,\value{section}}{%
        \addtocounter{pp}{\sectionpoints{\ii}}%
    }%
    \immediate\write\@mainaux{%
        \string\expandafter\gdef\noexpand\csname totalpoints@\string\endcsname{\arabic{pp}}%
    }%
}%

% Command for creating an exercise part/section
\newcommand{\Exercise}[1]{%
    \newpage
    \ifcsname totalproblems@s\the\numexpr\value{section}\relax\endcsname\else\definetotalproblems{\the\numexpr\value{section}\relax}{\the\numexpr\value{subsection}\relax}\fi%
    \ifcsname sectionpointcounter@s\the\numexpr\value{section}+1\relax\endcsname\else\definesectionpoints{\the\numexpr\value{section}+1\relax}{0}\fi%
    \section{#1 \hfill\points{\sectionpoints{\arabic{section}}}}%
    \definesectionpoints{\arabic{section}}{0}%
    \setboolean{@compoundproblem}{false}%
}%

% Command for defining an exercise problem with a particular number of points
\newcommand{\Task}[2]{%
    \ifnum\value{section}=0 \ClassError{exerciseexercisecls}{No exercise part defined}{Use \string\Exercise{} before \string\Task{}.}\fi%
    \addtosectionpoints{\arabic{section}}{#1}%
	\subsection{\normalfont\normalsize#2 \hfill\points{#1}}%
    \defineproblempoints{\arabic{section}}{\arabic{subsection}}{#1}%
    \setboolean{@compoundproblem}{false}%
}%

% Command for defining a compound exercise problem with several subproblems
\newcommand{\CompoundTask}[1]{%
    \ifnum\value{section}=0 \ClassError{exercise.cls}{No exercise part defined}{Use \string\Exercise{} before \string\CompoundTask{}.}\fi%
    \ifcsname problempointcounter@s\the\numexpr\value{section}\relax p\the\numexpr\value{subsection}+1\relax\endcsname\else\defineproblempoints{\the\numexpr\value{section}\relax}{\the\numexpr\value{subsection}+1\relax}{0}\fi%
	\subsection{\normalfont\normalsize#1 \hfill\points{\problempoints{\arabic{section}}{\arabic{subsection}}}}%
    \defineproblempoints{\arabic{section}}{\arabic{subsection}}{0}%
    \setboolean{@compoundproblem}{true}%
}%

% Redefine appearance of subproblems/subsubsections
\renewcommand\thesubsubsection{(\alph{subsubsection})}

% Command for defining a subproblem of a compound exercise problem
\newcommand{\SubTask}[2]{%
    \ifthenelse{\boolean{@compoundproblem}}{}{\ClassError{exercise.cls}{Usage of \string\SubTask{} outside of \string\CompoundTask{}}{The use of \string\SubTask{} is only allowed in a \string\CompoundTask{}.}}%
    \addtosectionpoints{\arabic{section}}{#1}%
    \addtoproblempoints{\arabic{section}}{\arabic{subsection}}{#1}%
    \subsubsection{\normalfont\normalsize#2 \hfill\points{#1}}%
}%

% Store point/section/problem counters to aux file after processing the document
\AtEndDocument{
    \ifnum\value{section}>0 % makes document compilable in case of empty exercise
        \ifcsname totalproblems@s\the\numexpr\value{section}\relax\endcsname\else\definetotalproblems{\the\numexpr\value{section}\relax}{\the\numexpr\value{subsection}\relax}\fi
        \storetotalsections
        \storetotalpoints
        \foreach \ii in {1,...,\arabic{section}}{
            \storetotalproblems{\ii}
            \storesectionpoints{\ii}
            \ifnum\the\numexpr\csname totalproblems@s\ii\endcsname\relax >0 % makes document compilable in case of empty exercise part/section
                \foreach \jj in {1,...,\csname totalproblems@s\ii\endcsname}{
                    \storeproblempoints{\ii}{\jj}
                }
            \fi
        }
    \fi
}

% Generate the marks table automatically with the encountered number of exam parts and their respective total point counts
\markstable{
    \newcounter{colsCounter}
    \setcounter{colsCounter}{2}

    % \Large
    % If totalsections@ is defined, totalpoints@ will also be defined
    \ifcsname totalsections@\endcsname
    \edef\rowdescriptor{|r|}
    \def\pointsdescriptor{\hspace*{0.75cm}}
    \foreach \ii in {1,...,\csname totalsections@\endcsname}{
        \gappto\rowdescriptor{c|}
        \xappto\problemdescriptor{\ii &}
        \xappto\achievabledescriptor{\sectionpoints{\ii}&}
        \gappto\pointsdescriptor{&\hspace*{0.75cm}}
        \stepcounter{colsCounter}
    }
    \expandafter\edef\csname totalsum@\endcsname{\csname totalpoints@\endcsname}
    \gappto\rowdescriptor{|c||c|}
    \expandafter\tabular\expandafter{\rowdescriptor}
    \hline
    \@titleproblem & \problemdescriptor $\sum$ & \@titlefinalgrade\\
    \hline \hline
    
    \@titleachievable & \achievabledescriptor \csname totalsum@\endcsname & \multirow{2}{*}{}\\
    \cline{1-\value{colsCounter}}
    \@titlepoints & \pointsdescriptor & \\
    \hline
    \endtabular
    \fi
}

% Get the total number of exercise parts in the document
\newcommand{\totalExercises}[0]{%
    \ifcsname totalsections@\endcsname{\csname totalsections@\endcsname}\else{0}\fi%
}%

% Get the total number of exercise points in the document
\newcommand{\totalExercisePoints}[0]{%
    \ifcsname totalpoints@\endcsname{\csname totalpoints@\endcsname}\else{0}\fi%
}%

