# A praxiography of machine learning

## Overview

- reconstruction vs problematization -- Rabinow
- data: its giveness, abstraction and actuality
    - the case of iris (science), digits (transactions), spam (media) and kittens -- in that order
- practice and writing about practice - developing Mol
    - observant participation -- developing Wacquant; participating by observing
    - writing recursively -- developing Kelty w.r.t subjects
    - implementation as a practice -- the executable paper 
- Implementing machine learning
    - the case of R -- the scientific
    - the case of Python -- the business/industry
    - the case of javascript -- popular culture
- computation -- psychic engagement - Wilson
- convergence and learning: for fitting a line; but then for choosing which features to use to learn

## Quotes to use

    >The main point of this description is the concept of actuality as something that matters, by reason of its own self-enjoyment, which includes enjoyment of others and transitions towards the future. Whitehead, Modes, 161

    >But this enhancement of energy presupposes that the abstraction is preserved with its adequate relevance to the concrete sense of value-attainment from which it is derived. In this way, the effect of the abstraction stimulates the vividness and depth of the whole of experience. 169

    >Matter-of-fact is an abstraction, arrived at by confining thought to purely formal relations which then masquerade as the final reality. 25

    >A feeling in which the forms exemplified in the datum concern geometrical, straight, and flat loci will be called a 'strain.' In a strain, qualitative elements, other than the geometrical forms, express themselves as qualities implicated in those forms Whitehead,  PR, 310

    >Sometimes machines are the very means by which we can stay alive psychically, and they can  just as readily be a means for affective expansion and amplification as for affective attenuation. This is especially the case of computational machines. 30

## Introduction

The broad project of artificial intelligence, at least as envisaged in its 1960s-1970s heydey, is today largely regarded as a failure. There is no general, well-rounded artificial intelligence in existence. But in the course of its failure, many interesting problems were generated. [TBA - references on the history of AI] The field of machine learning might be seen as one such offshoot. The so-called 'learning problem' and the theory of learning machines was developed largely by researchers in the 1960-1970s based on work already done in the 1950s on learning machines such as the perceptron, the  neural network model developed by the psychologist Frank Rosenblatt in the 1950s [@rosenblatt_perceptron:_1958]. Drawing on McCulloch-Pitts model of the neurone, Rosenblatt implemented the perceptron, which today would be called a single-layer neural network on a computer at the Cornell University Aeronautical Laboratory in 1957. As Vladimir Vapnik, a leading machine learning theorist, observes: 'the perceptron was constructed to solve pattern recognition problems; in the simplest case this is the problem of constructing a rule for separating data of two different categories using given examples' [@vapnik_nature_1999, 2]. While computer scientists in artificial intelligence of the time, such as Marvin Minsky and Seymour Papert, were sceptical about the capacity of the perceptron model to distinguish  or 'learn' different patterns [@minsky_perceptron:_1969], later work showed that perceptrons could 'learn universally.' For present purposes, the key point is not that neural networks have turned out several decades later to be extremely powerful algorithms in learning to distinguish patterns, and that intense research in neural networks has led to their ongoing development and increasing sophistication in many 'real world' applications (see for instance, for their use in sciences [@hinton_reducing_2006], or in commercial applications such as drug prediction[@dahl_deep_2012]). Rather, the important point is that it began to introduce learning machines as an ongoing project in which trying to understand what machines can learn, and to predict how they will classify or predict became central concerns. At the same time, and less visibly, the proliferation of implementations and applications of techniques derived from artificial intelligence and adjacent scientific disciplines gathered pace. 

In describing these techniques, I'm not attempting to provide any detailed history of their development. For the most part, I leave controversies about the techniques to one side. Also, in describing these developments, I focus mainly on what happens from the 1980s onwards. Rather than history or controversies, I focus on implementations, and the many configurational shifts associated with their implementations. While many of the machine learning techniques I discuss have much longer lineages (in some cases, runnning back to the 1930s), machine learning techniques begin to circulate much more widely in the 1980s as a result of personal computers, and then in the mid-1990s, the internet. The proliferation of programming languages such as FORTRAN, C, C++, Pascal, then Perl, Java, Python and R, and computational scripting environments such as Matlab, multiplied the paths along which  implementation of machine learning techniques could proceed. For instance, a  perceptron that 'learns' the binary logical operation NAND (Not-AND) is  expressed in twenty lines of python code on the Wikipedia 'Perceptron' page [@perceptron_2013]. 

```{r perceptron, echo=TRUE, cache=TRUE, message=FALSE, warning=FALSE, comment=NA, size='smallsize', results='markup', engine='python' }
    
    threshold = 0.5
    learning_rate = 0.1
    weights = [0, 0, 0]
    training_set = [((1, 0, 0), 1), ((1, 0, 1), 1), ((1, 1, 0), 1), ((1, 1, 1), 0)]
     
    def dot_product(values):
        return sum(value * weight for value, weight in zip(values, weights))
     
    while True:
        print '-' * 60
        error_count = 0
        for input_vector, desired_output in training_set:
            print weights
            result = dot_product(input_vector) > threshold
            error = desired_output - result
            if error != 0:
                error_count += 1
                for index, value in enumerate(input_vector):
                    weights[index] += learning_rate * error * value
        if error_count == 0:
            break
 ```

While perceptrons and neural networks are the topic of a later chapter, the typical features of this code as the implementation of a machine learning algorithm are the presence of the 'learning rate', a 'training_set,' 'weights', an 'error count', a loop function that  multiplies values ('dot_product'). Some of the terms present in the code bear the marks of the theory of learning machines that we will discuss. But much of the code here is much more familiar, generic programming. It defines variables, sets up data structures (lists of numerical values), checks conditions, loops through statements or prints results. Executing this code (by pasting it into a python terminal) produces several dozen lines of numbers that are initially different to each other, but that gradually converge on the same values (see printout). These numbers are the 'weights' of the nodes of the perceptron as it iteratively learns to recognise patterns in the input values. None of the workings of the perceptron need concern us at the moment. It is a typical machine learning algorithm, almost always included in ML textbooks and usually taught in introductory ML classes.  Perhaps more strikingly than its persistence as an algorith over half a century, the implementation of the whole algorithm in twenty lines of code on a Wikipedia page suggests the mobility of these methods. What required the resources of a major research engineering laboratory in the 1950s can be re-implemented by a cut and paste operation between wikipedia pages and a terminal window on a laptop in 2013. This is now a familiar observation, and perhaps not very striking at all. But the question of who implements perceptrons or neural networks, and where they implement them today is rather more interesting. 


## Notion of praxiography: where practices are the feature

What would we learn by studying the proliferation of implementations of artificial intelligence or machine learning algorithms rather than their history or the controversies associated with them? The question that guides much of this book is how to live with machine learning? This is a largely affirmative question, rather than a critical one. I am looking for ways of thinking with machine learning. Several general  possibilities present themselves here. 

Science studies scholars such as Anne-Marie Mol and John Law have long urged the need to keep practice together with ontology. Towards the beginning of _The Body Multiple: Ontology in Medical Practice_[@TBA], Mol writes:

>If it is not removed from the practices that sustain it, reality is multiple. This may be read as a description that beautifully fits the facts. But attending to the multiplicity of reality is also an act. It is something that may be done – or left undone [@mol_body_2003, 6]

Mol's work offers a cogent case for developing accounts of what is real steeped in the practices that make it real. Similar affirmations of the sustaining role of practice can be found in many parts of social sciences and humanities. So for the first part, looking at implementations and the flow of implementations is a way of keeping practices in the picture, and therefore, a heuristic for learning reality as multiple. This already suggests that describing machine learning in terms of practices could be an act that attends to their multiplicity. 

A second  and related tack comes from the work of Alfred North Whitehead. Whitehead's work on how abstractions are embodied is highly relevant to thinking about machine learning. While Whitehead is comprehensively critical of certain tendencies in modern science (the fallacy of misplaced concreteness; the reduction of space-time to discrete locations, etc), he is very enthusiastic about the potential for better abstractions. While voiced in terminology that takes some getting used to, the broad affirmative point can be grasped:

>But this enhancement of energy presupposes that the abstraction is preserved with its adequate relevance to the concrete sense of value-attainment from which it is derived. In this way, the effect of the abstraction stimulates the vividness and depth of the whole of experience. [@whitehead_modes_1958,169]

[HERE]

## Reshaping of data and the problem of spatiality

The dimensionality of data practice is something that we hardly think of when we think of models, algorithms, predictions and smart devices. But in terms of multiplyin matrices, dimensionality is 

- multiplying
- commutative
- associative
- identity matrix
- inverse - singular/degenerate
- transpose

> Almost any programming language you use will have great linear algebra libraries. And they will be high optimised to do that matrix-matrix multiplication very efficiently including taking advantage of any parallelism your computer. So that you can very efficiently make lots of predictions of lots of hypotheses [Ng, lecture 10.50]

```{r matrix, echo=TRUE, cache=TRUE, message=FALSE, warning=FALSE, comment=NA, size='smallsize', results='markup' } 
    
    a_vector = c(1,2,3)
    a_matrix = matrix(c(1,2,3,4,5,6,7,8,9), nrow=3)
    matrix_product = a_matrix %*% a_vector
    
    cat('Matrix:', a_matrix, '\n')
    cat('Vector:', a_vector, '\n')
    cat('Matrix times vector:', matrix_product, '\n')
```

## R: mobility of methods

- The number of packages
- The history of the language
- The increase in popularity

## Python: connectivity of practices

- The place of python amongst languages
- Python as symptom of industry, business and science more broadly
- The rise of industrial machine learning

## Irises, digits, spam and kittens, titanic survivors: iterating through data


## Reconstruction and problematization

Dewey on the need for reconstruction
Foucault on problematization
'Problematic implementation'

## Conclusion