# This function will create the LaTeX file for homework sets
def homeworkStarting(
    numberQuestions,        # Number of questions on set
    fileName = "out.tex",   # File to output to
    courseName = "ERHSNNN", # Name of the course
    homeworkNumber = "NN",  # Set number
    monthDue = "MM",        # Month of due data
    dayDue = "DD",          # Day homework is due
    yearDue = "YYYY"        # Current Year
    ):
    
    # Open the file which will contain the LaTeX
    textFile = open(fileName, "w")
    
    # Initialize to the preamble used for homework.
    outputString = "".join([
        "\\documentclass{article}\n%%%% Definitions for Commands\n\\renewcommand\\thesection{}\n\\renewcommand\\thesubsection{}\n\\renewcommand\\thesubsubsection{}\n\\renewcommand\\refname{}\n% Packages\n\\usepackage[margin = 1 in]{geometry}\n\\usepackage{\n    filecontents,   % Input file within latex document\n    subfiles,       % Include different parts of document in different files\n    isotope,        % Display isotope\n    natbib,         % Better alternative to cite\n    amsmath,        % Math symbols\n    amssymb,        % Math symbols\n    amsthm,         % Math symbols\n    braket,         % Bras and Kets\n    calligra,       % Font family\n    graphicx,       % Graphics and figures\n    xifthen,        % Logic in defining formulas\n    float,          % Define where objects are located\n    lastpage,       % Display total number of pages\n    longtable,      % Allow tables to be broken up\n    titlesec,       % Change format of section titles\n    fancyhdr,       % Change page number styling\n    caption,        % Format captions for figures and tables\n    subcaption,     % Contain multiple figures in an environment\n    textgreek,      % Include greek letters in text\n    appendix,       % Allow for appendices in documents\n    enumitem        % More control over symbols for ennumeration\n}\n% Display code\n\\usepackage{listings}\n\\usepackage[utf8]{inputenc}\n\\setlength{\\parindent}{8pt}\n% -- Defining colors:\n\\usepackage[dvipsnames]{xcolor}\n\\lstdefinelanguage{Julia}%\n  {morekeywords={abstract,break,case,catch,const,continue,do,else,elseif,%\n  end,export,false,for,function,immutable,import,importall,if,in,%\n  macro,module,otherwise,quote,return,switch,true,try,type,typealias,%\n  using,while},%\n    sensitive=true,%\n    alsoother={$},%\n    morecomment=[l]\\#,%\n    morecomment=[n]{\\#=}{=\\#},%\n    morestring=[s]{\"}{\"},%\n    morestring=[m]{'}{'},%\n}[keywords,comments,strings]%\n\\lstset{%\n    language         = Julia,\n    keywordstyle     = \\bfseries\\color{blue},\n    stringstyle      = \\color{magenta},\n    commentstyle     = \\color{ForestGreen},\n    showstringspaces = false,\n    basicstyle=\\ttfamily\\bfseries\\small,\n    breakatwhitespace=false,         \n    breaklines=true,                 \n    captionpos=t,                    \n    keepspaces=true,                 \n    numbers=left,                    \n    numbersep=5pt,                  \n    showspaces=false,                \n    showstringspaces=false,\n    showtabs=false,                  \n    tabsize=4\n}\n\\title{",
        courseName,
        " Homework \\# ", #str2
        homeworkNumber,
        "}\n\\author{Noah J. Blair}\n\date{Due: ",
        yearDue,
        "/",
        monthDue,
        "/",
        dayDue,
        "}\n\n\\begin{document}\n\\maketitle"
    ])

    # Add information for each of the homework problems
    for i in range(1,numberQuestions + 1):
        outputString += "".join([
            "\\section{Problem ",
            str(i),
            "}\n\\begin{center}\\includegraphics[width = 0.85\\textwidth]{images/p",
            str(i),
            ".png}\\end{center}\n\n\n"
        ])
    
    # Add the closing information
    outputString += "\\section{References}\n\\bibliography{sources}{}\\label{toc:bibliography}\n\\bibliographystyle{apalike}\n\\begin{center}\\textbf{I pledge on my honor that I have not received or given unauthorized assistance in this assignment.}\\end{center}\n\\end{document}"

    # Write and close the file
    textFile.write(outputString)
    textFile.close()