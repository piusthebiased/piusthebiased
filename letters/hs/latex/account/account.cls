\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{account}[2025/02/24 Accounting template, Pius Lee (academics@plee.app)]

% Load Base Class
\LoadClass{article}

% --- Package Imports ---
\usepackage{graphicx, parskip, enumitem, xstring} % Basic layout & formatting
\usepackage{calculator, siunitx, ifthen} % Arithmetic and number formatting

% --- siunitx Configuration ---
\sisetup{
    round-mode=places,
    round-precision=2,
    scientific-notation=false,
    round-direction=down
}

% ------------------------------
% ENVIRONMENTS
% ------------------------------
% --- Expense Environment ---
\newenvironment{expense}[1]{%
    \begin{center}
    \begin{tabular}{|p{0.9\textwidth}|} \hline
    \vspace{-1.5em} \subsection{#1}%
}{%
    \\ \hline
    \end{tabular}
    \end{center}
}%

% --- Itemized List with Optional Tax ---
\newenvironment{complist}[1][false]{%
    % Title & Subtotal Initialization
    \textbf{Items Ordered, Cost:}%
    \newcommand{\subtotal}{0.00}%
    \newcommand{\taxrate}{#1}%

    % Itemized List Formatting
    \begin{enumerate}[noitemsep, topsep=0pt]%
}{%
    % Display Subtotal
    \vspace*{0.2em}
    \item[] \hspace*{-2.8em} {\textbf{Subtotal:} \hfill \num{\subtotal} \hspace{0.5em} USD}%

    % If tax rate is provided, calculate tax & total
    \ifthenelse{\equal{\taxrate}{false}}{}{%
        \MULTIPLY{\subtotal}{\taxrate}{\taxamount} % taxamount = subtotal * taxrate
        \ADD{\subtotal}{\taxamount}{\total} % total = subtotal + taxamount
        \MULTIPLY{\taxrate}{100}{\taxpercent} % Convert tax rate to percentage

        \item[] \hspace*{-2.9em} {\textbf{Tax (\num{\taxpercent}\%):} \hfill \num{\taxamount} \hspace{0.5em} USD}%
        \item[] \hspace*{-2.9em} {\textbf{TOTAL:} \hfill \num{\total} \hspace{0.5em} USD}%
    }

    % Close the list
    \end{enumerate}%
}%

% ------------------------------
% COMMANDS
% ------------------------------
% --- Add an Item to the List ---
\newcommand{\comp}[3][1]{%
    \item[#1] #2 \hfill #3 \hspace{0.5em} USD%
    \ADD{#3}{\subtotal}{\subtotal}%
}

% --- Display Total Line ---
\newcommand{\tot}[2]{%
    \textbf{#1} \hfill #2 \hspace{0.5em} USD\\
}