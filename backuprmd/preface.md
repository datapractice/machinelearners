# Preface

Although book is not an ethnography, it has an ethnographic situation. If it has a field site, it lies close to the places where the writing was done -- in universities, on campuses, in classrooms and online training courses (including MOOCs), and then amidst the books, documents, websites, software manuals and documentation,  and a rather vast accumulation of scientific publications. It's a case of 'dig where you stand,' or 'auto-archaeology.' \index{archaeology!auto-}

Readers familiar with textbooks in computer science and statistics can detect the traces of this setting in various typographic conventions drawn from the fields I write about. Important conventions include:

1. Typesetting  the name of any code or devices that do machine learning  and datasets on which machine learners operate  in a `monospace` or terminal font: `machine learner` or `iris`;
2. Presenting formulae, functions, and equations using the bristling indexicality of mathematical typography: $\hat{\beta}$

I emulate the apparatus of science and engineering publication as an experiment in *in-situ* hybridization. Social science and humanities researchers, even when they are observant participants in their field sites, rarely experience a coincidence between their own writing practices and that of the participants in the research site they study. The object of study in this book, however, is a knowledge practice that documents itself in code, equations, diagrams and statements circulated in articles, books and various online formats (blogs, wikis, software repositories). It is possible for a social researcher to also adopt some of these practices.  

I've been writing code for years [@Mackenzie_2006]. Writing code was nearly always something  distant from writing about code since coding was about software projects and writing was about thinking and knowledge. I was slow to realise they are much entangled.  Recent  developments in ways of analysing and publishing scientific data bring coding and writing closer together. Implementing code can be done almost  in the same space, in the same screen or pane,  as writing about code. The mingling of coding and writing about code brings about sometimes generative, sometimes frustrating, encounters with various scientific knowledge (mathematics, statistics, computer science), with infrastructures and devices on many scales (ranging across networks, text editors, databases here and there, hardware and platforms of various kinds, as well as interfaces) and many domains.

At many points in researching the book, I digressed a long way into quite technical domains of statistical inference, probability theory, linear algebra, dynamic models as well as database design and data standards. In the interests of maintaining a strong  feedback signal running through the many propositions, formulations, diagrams, equations, citations and images in this book, much of the code I've written in implementing machine learning models or in reconstructing certain data practices does not appear in this text, just as not all of the words I've written in trying to construct arguments or think about data practices has been included. Much has been cut away and left on the ground (although the `git` repository of the book preserves many traces of the writing and code; see [https://github.com/datapractice/machinelearning](https://github.com/datapractice/machinelearning)). As in  the many machine learning textbooks, recipe books, cookbooks, how-tos, tutorials and manuals I have read, code, graphics and prose have been tidied here. Many exploratory forays are lost and almost forgotten. 

The several years I have spent  doing and writing about data practice has felt substantially different to any other project by virtue of the hybridization between code in text, and text in code. Practically, this is made possible by working on code and text within the same file, in the same text editor. Switching between writing  `R` and  Python code (about which I say more below) to retrieve data, to transform it, to produce graphics, to construct models or some kind of graphic image, and within the same file be writing academic prose, might be one way to write about machine learning as a data practice. 

The capacity to mingle  text, code and images depends on an ensemble of open source, often command-line software tools that differ somewhat from the typical social scientist or humanities researchers' software toolkit of word processor, bibliographic software, image editor and web browser. In particular, I have  relied on software packages in the `R` programming language such as the '`knitr`' [@Xie_2013; @Xie_2012] and in `python,` the `ipython` notebook environment [@Perez_2007]. Both have been developed by scientists and statisticians in the name of 'reproducible research.' \index{science!reproducible research} Many examples of this form of writing can be found on the web: see [IPython Notebook Viewer](http://nbviewer.ipython.org/) for a sample of these. These packages are designed to allow a combination of code written in `R`, python or other programming languages, scientific writing (including mathematical formula) and images to be included, and importantly, executed together to produce a document.[^P1] \index{programming languages!as mode of writing}

In making use of the equipment created by the people I study,  I've attempted  to bring the writing of code and writing about code-like operations into critical proximity. Does  proximity or mixing of writing code and writing words make a practical difference to an account of practice?  If recent theories of code and software as forms of speech, expression or performative utterance [@Cox_2012;@Coleman_2012], or more generally praxiography as a reality-making descriptive practice [@Mol_2003] are right,   it should.  Weaving code through writing in one domain of contemporary technical practice, machine learning, might be one way of keeping multiple practices present,   developing a concrete sense of abstraction  and allowing an affective expansion in relation to machines. 

[^P1]: In order to do this, they typically combine some form of text formatting or 'markup,' that ranges from very simple formatting conventions (for instance, the 'Markdown' format used in this book is much less complicated than HTML, and uses markup conventions readable as plain text and modelled on email [@Gruber_2004];) to the highly technical (LaTeX, the de-facto scientific publishing format or 'document preparation system' [@Lamport_1986] elements of which are also used here to convey mathematical expressions). They add to that blocks of code and inline code fragments that are executed as the text is formatted in order to produce results that are shown in the text or inserted as figures in the text.

    There are a few different ways of weaving together text, computation and images together.  Each suffers from different limitations. In `ipython`, a scientific computing platform dating from 2005 [@Perez_2007] and used across a range of scientific settings, interactive visualization and plotting, as well as access to operating system functions are brought together in a `Python` programming environment. Especially in using the `ipython` notebook, where editing text and editing code is all done in the same window, and the results of changes to code can be seen immediately, practices of working with data can be directly woven together with writing about practice. By contrast, `knitr` generates documents by combining text passages and the results (graphs, calculations, tabulations of data) of code interleaved between the text into one output document. When `knitr` runs, it executes the code and inserts the results (calculations, text, images) in the flow of text. \index{R!packages!\textit{knitr}}

    Practically, this means that the text editor used to write code and text, remains somewhat separate from the software that executes the code. By contrast, `ipython` combines text and `Python` code more continuously, but at the cost of editing and writing code and text in a browser window. Most of the conveniences and affordances of text editing software is lost.   While `ipython` focuses on interactive computation, `knitr` focuses on bringing together scientific document formatting and computation.  Given that both can include code written in other languages (that is, `python` code can be processed by `knitr`, and `R` code executed in `ipython`), the differences are not crucially important. This whole book could have been written using just Python, since Python is a popular general purpose programming language, and many statistical, machine learning and data analysis libraries have been written for Python. I have used both, sometimes to  highlight  tensions between the somewhat more research-oriented `R` and the more  practical applications typical of Python, and sometimes because code in one language is more easily understood than the other.  \index{programming languages!R} \index{programming languages!Python}