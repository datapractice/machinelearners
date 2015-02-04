28:in function approximation.
30:   Viewed as a function over the p-dimensional input space, f (X) = X T β
30:RSS(β) is a quadratic function of the parameters, and hence its minimum
33:should be approximately an increasing function of k, and will always be 0
36:put variable, with joint distribution Pr(X, Y ). We seek a function f (X)
36:function L(Y, f (X)) for penalizing errors in prediction, and by far the most
36:the conditional expectation, also known as the regression function. Thus
37:tion is that one assumes that the regression function f (x) is approximately
37:of the functional relationship to pool over values of X. The least squares
37:       function.
38:       constant function.
38:This retains the additivity of the linear model, but each coordinate function
38:ditional expectations simultaneously for each of the coordinate functions.
38:L2 loss function with the L1 : E|Y − f (X)|? The solution in this case is
38:resistant loss functions will be mentioned in later chapters, but squared
38:paradigm works here, except we need a different loss function for penalizing
38:classes. Our loss function can be represented by a K × K matrix L, where
38:class Gk as G . Most often we use the zero–one loss function, where all
39:With the 0–1 loss function this simplifies to
42:more generally. The complexity of functions of many variables can grow
42:such functions with the same accuracy as function in low dimensions, then
42:such functions with the same accuracy as function in low dimensions, then
42:example, the function is a complex interaction of all p variables involved.
42:function always involves only a few dimensions as in Figure 2.8, then the
43:variance curves as a function of dimension p.
44:the function is constant in all but one dimension: F (X) = 12 (X1 + 1)3 . The
44:Here we see that the expected EPE increases linearly as a function of p,
45:complexity of functions in high dimensions by drawing heavily on these
46:Our goal is to find a useful approximation fˆ(x) to the function f (x) that
46:to the regression function f (x) = E(Y |X = x) for a quantitative response.
46:the goal is to be able to color any point. Here the function is deterministic,
47:get function p(X) is the conditional density Pr(G|X), and this is modeled
47:function-fitting paradigm from a machine learning point of view. Suppose
47:matics and statistics has been from the perspective of function approxima-
47:(p + 1)-dimensional Euclidean space. The function f (x) has domain equal
48:supervised learning as a problem in function approximation encourages the
48:where the hk are a suitable set of functions or transformations of the input
48:as a function of θ. This seems a reasonable criterion for an additive error
48:model. In terms of function approximation, we imagine our parameterized
48:function as a surface in p + 1 space, and what we observe are noisy re-
48:mization problem. This is also true for the basis function methods, if the
48:basis functions themselves do not have any hidden parameters. Otherwise
49:FIGURE 2.10. Least squares fitting of a function of two inputs. The parameters
49:sion function Pr(G|X) for a qualitative output G. Suppose we have a model
50:directly on estimating the function at a point, they face problems in high
50:Consider the RSS criterion for an arbitrary function f ,
50:Minimizing (2.37) leads to infinitely many solutions: any function fˆ passing
50:solutions to (2.37) to a smaller set of functions. How to decide on the
51:discussed so far are based on the assumption that locally the function is
51:constant; close to a target input x0 , the function does not change much, and
51:as splines, neural networks and basis-function methods implicitly define
51:duce locally varying functions in small isotropic neighborhoods will run
52:Here the class of functions is controlled by explicitly penalizing RSS(f )
52:The user-selected functional J(f ) will be large for functions f that vary too
52:The user-selected functional J(f ) will be large for functions f that vary too
52:is imposed, and any interpolating function will do, while for λ = ∞ only
52:functions linear in x are permitted.
52:   Penalty functionals J can be constructed for functions in any dimension,
52:   Penalty functionals J can be constructed for functions in any dimension,
52:additive functions f (X) =       j=1 fj (Xj ) to create additive models with
52:smooth coordinate functions. Similarly, projection pursuit regression mod-
52:the functions gm can each have an associated roughness penalty.
52:   Penalty function, or regularization methods, express our prior belief that
52:the type of functions we seek exhibit a certain type of smooth behavior, and
52:gression function or conditional expectation by specifying the nature of the
52:local neighborhood, and of the class of regular functions fitted locally. The
52:neighborhood is specified by a kernel function Kλ (x0 , x) which assigns
53:example, the Gaussian kernel has a weight function based on the Gaussian
53:density function
53:and fθ is some parameterized function, such as a low-order polynomial.
53:    • fθ (x) = θ0 , the constant function; this results in the Nadaraya–
53:model for f is a linear expansion of basis functions
54:where each of the hm is a function of the input x, and the term linear here
54:methods. In some cases the sequence of basis functions is prescribed, such
54:by an appropriate sequence of M spline basis functions, determined in turn
54:by M − K knots. These produce functions that are piecewise polynomials
54:linear functions. One intuitively satisfying basis consists of the functions
54:linear functions. One intuitively satisfying basis consists of the functions
54:   Radial basis functions are symmetric p-dimensional kernels located at
54:   Radial basis functions have centroids µm and scales λm that have to
54:be determined. The spline basis functions have knots. In general we would
54:weights can be thought of as an adaptive basis function method. The model
54:where σ(x) = 1/(1 + e−x ) is known as the activation function. Here, as
54:   These adaptively chosen basis function methods are also known as dictio-
54:D of candidate basis functions from which to choose, and models are built
55:    • or the number of basis functions.
55:k, if the true function is reasonably smooth. For small k the few closest
56:FIGURE 2.11. Test and training error as a function of model complexity.
58:                     yi = f (xi ) + εi , f is the regression function
61:A linear regression model assumes that the regression function E(Y |X) is
61:scope. These generalizations are sometimes called basis-function methods,
62:The linear model either assumes that the regression function E(Y |X) is
63:       function of X that minimizes the sum of squared residuals from Y .
63:       This is a quadratic function in the p + 1 parameters. Differentiating
67:function f (x) = xT β, namely {xT β|β ∈ Cβ } (Exercise 3.2; see also
67:ure 5.4 in Section 5.2.2 for examples of confidence bands for functions).
69:Considering X to be fixed, this is a linear function cT0 y of the response
74:loss function (3.2) is
74:function (f1 (x), . . . , fK (x)), and yi the vector of K responses for
78:the “best” of the two. For example in the R package the step function uses
79:error curve as a function of the complexity parameter.
80:various selection and shrinkage methods. Each curve is plotted as a function
82:penalty β T β, the ridge regression solution is again a linear function of
82:cer example, plotted as functions of df(λ), the effective degrees of freedom
86:This monotone decreasing function of λ is the effective degrees of freedom
89:Shown are contours of the error and constraint functions. The solid blue
89:while the red ellipses are the contours of the least squares error function.
92:function of their L1 arc length 2 . Note that we do not need to take small
93:                      data, as a function of the L1 arc length. The right
96:(across simulation replicates and methods), we plot the MSE as a function
98:patterns corresponding to Figure 3.7, as a function of the principal component
99:function of y. It can be shown (Exercise 3.15) that partial least squares
107:where both the loss function L and the penalty function J are convex.
107:where both the loss function L and the penalty function J are convex.
107:   1. R is quadratic or piecewise-quadratic as a function of β, and
107:function used in the support vector machine. There the loss is piecewise
110:Alternatively, one can modify the lasso penalty function so that larger co-
111:sum of functions of the individual parameters (Friedman et al., 2008a). It
116:       L(β) + λ j (βj+ + βj− ). Show that the Lagrange dual function is
119:function. For an important class of procedures, these decision boundaries
119:that model discriminant functions δk (x) for each class, and then classify x
119:to the class with the largest value for its discriminant function. Methods
120:linear function is fit to the training data.
120:X2 , . . ., thereby adding p(p + 1)/2 additional variables. Linear functions
120:in the augmented space map down to quadratic functions in the original
124:                    on linear functions of x as well, they use them in such a
126:This linear log-odds function implies that the decision boundary between
127:priors were equal. From (4.9) we see that the linear discriminant functions
128:discriminant functions (QDA),
128:are functions of the parameters of the densities, counting the number of
129:between the discriminant functions where K is some pre-chosen class (here
129:ˆ to compute the LDA discriminant functions,
129:a much reduced function of it is all that is required to estimate the O(p)
134:coordinates, not to be confused with discriminant functions. They are also
135:FIGURE 4.10. Training and test error rates for the vowel data, as a function
137:probabilities of the K classes via linear functions in x, while at the same
137:linear function. It is widely used in biostatistical applications where
144:heart disease data, plotted as a function of the L1 norm. The variables
145:are linear functions of x (4.9):
145:trary density function Pr(X), and fits the parameters of Pr(G|X) by max-
145:unrestricted fashion, using the empirical distribution function which places
146:where φ is the Gaussian density function. Standard normal theory leads
146:parameters of the logistic form (4.33) are functions of the Gaussian param-
150:many basis-function transformations of the original variables. This is anal-
151:optimal separating hyperplane produces a function fˆ(x) = xT βˆ + βˆ0
157:It is extremely unlikely that the true function f (X) is actually linear in
158:basis functions hm have been determined, the models are linear in these
158:      of single inputs. More generally one can use similar functions involv-
158:Sometimes the problem at hand will call for particular basis functions h m ,
158:such as logarithms or power functions. More often, however, we use the basis
158:their global nature—tweaking the coefficients to achieve a functional form
158:in one region can cause the function to flap about madly in remote regions.
158:|D| of basis functions, far more than we can afford to fit to our data. Along
158:of our model, using basis functions from the dictionary. There are three
158:      of functions. Additivity is an example, where we assume that our
159:        The size of the model is limited by the number of basis functions Mj
159:        used for each component function fj .
159:        only those basis functions hm that contribute significantly to the
159:nomial function f (X) is obtained by dividing the domain of X into contigu-
159:constant, with three basis functions:
159:functions are needed: hm+3 = hm (X)X, m = 1, . . . , 3. Except in special
159:where t+ denotes the positive part. The function h3 is shown in the lower
159:right panel of Figure 5.1. We often prefer smoother functions, and these
160:5.1. The top left panel shows a piecewise constant function fit to some
160:ξ2 . The blue curve represents the true function, from which the data were
160:                    ear functions fit to the same data—the top right
160:                    linear basis function, h3 (X) = (X − ξ1 )+ ,
161:increasing orders of continuity at the knots. The function in the lower
161:There are six basis functions corresponding to a six-dimensional linear space
161:                    of functions. A quick check confirms the parameter count:
162:function in Figure 5.1 is an order-1 spline, while the continuous piece-
162:wise linear function is an order-2 spline. Likewise the general form for the
162:of basis functions or degrees of freedom, and have the observations xi de-
162:in R generates a basis matrix of cubic-spline functions evaluated at the N
162:   Since the space of spline functions of a particular order and knot
162:wise variance of spline functions fit by least squares (see the example in
162:cubic spline with four knots is eight-dimensional. The bs() function omits by
163:price paid in bias near the boundaries, but assuming the function is lin-
163:   A natural cubic spline with K knots is represented by K basis functions.
164:Each of these basis functions can be seen to have zero second and third
164:heart disease data. Here we explore nonlinearities in the functions using
164:natural splines. The functional form of the model is
164:vector of natural spline basis functions hj .
164:   More compactly we can combine all p vectors of basis functions (and
164:the parameters in each component term. Each basis function is evaluated
164:functions displayed are fˆj (Xj ) = hj (Xj )T θˆj for each variable Xj .
164:ˆ jj hj (Xj ) is the pointwise variance function of fˆj ,
165:FIGURE 5.4. Fitted natural-spline functions for each of the terms in the
166:the application comes under the general heading of functional modeling. In
166:a vector of evaluations of a function X(f ) over a grid of frequencies f . In
166:reality there is a continuous analog signal which is a function of frequency,
166:coefficients are also plotted as a function of frequency, and in fact we can
167:FIGURE 5.5. The top panel displays the log-periodogram as a function of fre-
167:frequencies. The lower panel shows the coefficients (as a function of fre-
168:   The coefficients compute a contrast functional, and will have appreciable
168:to vary smoothly as a function of frequency. The red curve in the
168:cubic splines. We can represent the coefficient function as an expansion of
168:frequencies. Here we used M = 12 basis functions, with knots uniformly
169:(nonlinear) function of the form x∗ = g(x). The derived features x∗ can
169:network is a powerful tool for constructing nonlinear functions of these
169:functions f (x) with two continuous derivatives, find one that minimizes the
169:to the data, while the second term penalizes curvature in the function, and
169:  λ = 0 : f can be any function that interpolates the data.
169:indexes an interesting class of functions in between.
169:The criterion (5.9) is defined on an infinite-dimensional function space—
169:in fact, a Sobolev space of functions for which the second term is defined.
170:sured at the spine in adolescents, as a function of age. A separate smoothing
170:where the Nj (x) are an N -dimensional set of basis functions for repre-
171:well. Suppose Bξ is a N × M matrix of M cubic-spline basis functions
171:which is also the number of basis functions, and hence the number of pa-
173:x, and as such is viewed as a function of x. The rug at the base of the
173:indicate the occurrence of data points. The damped functions represent the
173: smoothed versions of these functions (using the 5 df smoother).
174:      two-dimensional eigenspace of functions linear in x (Exercise 5.11),
174:• The eigenvalues ρk (λ) = 1/(1 + λdk ) are an inverse function of the
174:      linear functions are not penalized.
175:ing function in detail for the indicated rows.
177:show the data, the true functions (in purple), and the fitted curves (in
178:mate a badly biased version of the true function with great reliability!
178:  dfλ = 9: Here the fitted function is close to the true function, although
178:dfλ = 9: Here the fitted function is close to the true function, although a
178:  dfλ = 15: The fitted function is somewhat wiggly, but close to the true
178:       function. The wiggliness also accounts for the increased width of the
178:   Since we don’t know the true function, we do not have access to EPE, and
180:a basis of functions h1k (X1 ), k = 1, . . . , M1 for representing functions
180:basis of functions h1k (X1 ), k = 1, . . . , M1 for representing functions of
180:coordinate X1 , and likewise a set of M2 functions h2k (X2 ) for coordinate
180:can be used for representing a two-dimensional function:
181:Each two-dimensional function is the tensor product of the corresponding one
183:seek a d-dimensional regression function f (x). The idea is to set up the
183:where J is an appropriate penalty functional for stabilizing a function f in
183:where J is an appropriate penalty functional for stabilizing a function f in
183:penalty (5.9) for functions on IR2 is
183:• as λ → 0, the solution approaches an interpolating function [the one
183:       linear expansion of basis functions, whose coefficients are obtained
183:radial basis functions, which are discussed in more detail in the next
184:contour plot. The response is systolic blood pressure, modeled as a function
184:trarily large collection of basis functions, and control the complexity by
184:basis functions as in (5.35), using, for example, the univariate B-splines
185:growth in basis functions as the dimension increases, and typically we have
185:to reduce the number of functions per coordinate accordingly.
185:the functions fj are univariate splines. In this case the penalty is somewhat
185:simply impose an additional penalty on each of the component functions:
186:where L(y, f (x)) is a loss function, J(f ) is a penalty functional, and H is
186:where L(y, f (x)) is a loss function, J(f ) is a penalty functional, and H is
186:a space of functions on which J(f ) is defined. Girosi et al. (1995) describe
186:quite general penalty functionals of the form
186:the Fourier transform of f , and G         ˜ is some positive function
186:where the φk span the null space of the penalty functional J, and G is the
186:functional J is defined in terms of the kernel as well. We give a brief and
186:Let x, y ∈ IRp . We consider the space of functions generated by the linear
186:f (x) = m αm K(x, ym ), where each kernel term is viewed as a function
186:these eigen-functions,
187:where ||f ||HK is the norm induced by K. The penalty functional in (5.42)
187:functions with large eigenvalues in the expansion (5.45) get penalized less,
187:The basis function hi (x) = K(x, xi ) (as a function of the first argument)
187:basis function hi (x) = K(x, xi ) (as a function of the first argument) is
188:with prior covariance function K. The eigen-decomposition produces a se-
188:ries of orthogonal eigen-functions φj (x) with associated variances γj .
188:scenario is that “smooth” functions φj have large prior variance,
188:in H that we wish to leave alone, such as the linear functions for cubic
188:function L. We consider first regression using squared-error loss. In this
189:M = p+d  d   eigen-functions that span the space of polynomials in IRp of
189:One can represent h in terms of the M orthogonal eigen-functions and
189:   The number of basis functions M = p+d         d      can be very large,
189:tation for the solution function, we have only to evaluate the kernel N 2
190:products. In this example the kernel is chosen because of its functional
190:                      radial basis functions,
190:                      functions km (x) = K(x, xm ).
190:                      functions on IR1 (Exercise 5.17). Figure 5.15 shows the
190:ues of K. The leading eigenfunctions are smooth, and they are successively
190:where we see the coefficients of higher-order functions get penalized more
190:ith row of Φ is the estimated vector of basis functions φ(xi ), evaluated
191:as estimates φˆ of the eigenfunctions in (5.45), and are represented as
191:                       functions in IR1 with the observed values superimposed
191:                       the functions in the left panel, for which the kernel
192:ing feature space representation of the eigenfunctions
192:shrinks most of the functions down to zero, leaving an effective dimension
192:basis function. The kernel scale parameter ν plays a role here as well;
192:ν implies more local km functions, and increases the effective dimension of
192:is an expansion in radial basis functions, generated by the kernel
192:Radial basis functions are discussed in more detail in Section 6.7.
192:the piecewise-zero nature of the loss function in (5.67)], and so fˆ is an
192:functions. With regression splines, we select a subset of the bases, using
193:for the Haar and symmlet families. The functions have been scaled to suit the
193:tation. Just as a smooth function can be represented by a few spline basis
193:                  functions, a mostly flat function with a few isolated bumps
193:functions, a mostly flat function with a few isolated bumps can be repre-
193:sented with a few (bumpy) basis functions. Wavelets bases are very popular
193:smooth and/or locally bumpy functions in an efficient way—a phenomenon
194:Since there are many basis functions at each scale, it can use bases where
194:ing function φ(x) (also known as the father). The red curves in Figure 5.18
194:are the Haar and symmlet-8 scaling functions. The Haar basis is particu-
194:an orthonormal basis for functions with jumps
194:basis for a space V1 ⊃ V0 of functions piecewise constant on intervals of
194:represent a function in Vj+1 by a component in Vj plus the component in
194:of this component to zero. It is easy to see that the functions ψ(x−k)
195:                      the waveshrink function in S-PLUS, which implements the
196:     function by its level-j detail and level-j rough components, the latter
196:Notice that since these spaces are orthogonal, all the basis functions are
197:       constant function.
197:   The symmlet-p scaling functions are one of many families of wavelet
197:at zero. The fitted function (vector) is then given by the inverse wavelet
198:   The space W could be any basis of orthonormal functions: polynomials,
198:form of basis functions used, which allows for a representation localized in
198:descend all the way to V0 , but stop at V4 which has 16 basis functions.
198:characteristics of the signal localized in time (the basis functions at each
198:N × N basis matrix W has columns which are the wavelet basis functions
198:    • The splines build in a bias toward smooth functions by imposing
198:       treated all scales equally. The S+wavelets function waveshrink() has
199:the spikes. In the lower panel, the true function is smooth, and the noise is
199:using RKHS approaches. Modeling functional data, as in Section 5.2.3, is
199:Ex. 5.1 Show that the truncated power basis functions in (5.3) represent a
201:(e) Show that an order-M B-spline basis function is the density function
201:(e) Show that an order-M B-spline basis function is the density function
201:Ex. 5.6 Suppose you wish to fit a periodic function, with a known period T .
202:with a knot at every xi ; being an N -dimensional space of functions, we can
202:g˜ be any other differentiable function on [a, b] that interpolates the N
202:by functions linear in X.
204:Section 5.8.2 to estimates of the eigenfunctions of K.
204:Ex. 5.18 The wavelet function ψ(x) of the symmlet-p wavelet basis has
204:   Denote by Bi,m (x) the ith B-spline basis function of order m for the
205:i = 1, . . . , K + 2M − 1. These are also known as Haar basis functions.
205:basis functions for the knot sequence ξ. This recursion can be contin-
205:    To fully understand the properties of these functions, and to show that
205:derivative, i.e., the function is discontinuous at x = ξj . This is exactly
205:putations with N observations and K + M variables (basis functions) take
207:regression matrix consisting of the K + M B-spline basis functions evalu-
207:coefficients and the Bj are the cubic B-spline basis functions. The solution
207:negligible effect on the fit. For example, the smooth.spline function in S-
209:flexibility in estimating the regression function f (X) over the domain IRp
209:fit the simple model, and in such a way that the resulting estimated function
209:is smooth in IRp . This localization is achieved via a weighting function
210:as an estimate of the regression function E(Y |X = x). Here Nk (x) is the set
211:The fitted function is now continuous, and quite smooth in the right panel
211:function (indexed by λ) that determines the width of the neighborhood at
211:       sume the true function is constant within the window).
212:                       is based on the tri-cube function
213:boundaries of the domain. The true function is approximately linear here, but
213:Define the vector-valued function b(x)T = (1, x). Let B be the N × 2
214:and a series expansion of the true function f around x0 ,
215:                      function. Local quadratic fits tend to eliminate this
215:linear fits tend to be biased in regions of curvature of the true function, a
216:FIGURE 6.6. The variances functions ||l(x)||2 for local constant, linear and
217:the width goes to zero, the estimates approach a piecewise-linear function
218:function, such as the radial Epanechnikov or tri-cube kernel
219:dictors. The trellis display here shows ozone as a function of radiation,
220:The trellis display shows ozone as a function of radiation, conditioned
221:function of the predictors can be used to tailor a metric A that focuses
221:where low-rank versions of A imply ridge functions for fˆ(X). More general
221:for the regression function discussed next.
221:We are trying to fit a regression function E(Y |X) = f (X1 , X2 , . . . , Xp
221:local regression of Y − j=k gj (Xj ) on Xk . This is done for each function
222:model the diameter of the aorta as a linear function of age, but allow the
222:slope as a function of depth.
223:FIGURE 6.11. The intercept and slope of age as a function of distance down
225:ease) as a function of a risk factor for the South African heart disease
225:sion function.
230:In Chapter 5, functions are represented as expansions in basis functions:
230:In Chapter 5, functions are represented as expansions in basis functions:
230:consists of picking an appropriate family of basis functions, and then con-
230:both. Some of the families of basis functions have elements that are defined
230:by more basis functions (which in the case of B-splines translates to more
230:knots). Tensor products of IR-local basis functions deliver basis functions
230:knots). Tensor products of IR-local basis functions deliver basis functions
230:local in IRp . Not all basis functions are local—for example, the truncated
230:power bases for splines, or the sigmoidal basis functions σ(α0 + αx) used
230:in neural-networks (see Chapter 11). The composed function f (x) can nev-
230:of functions; the cancellation is exact in this case.
230:   Radial basis functions combine these ideas, by treating the kernel func-
230:tions Kλ (ξ, x) as basis functions. This leads to the model
230:density function. There are several approaches to learning the parameters
231:FIGURE 6.16. Gaussian radial basis functions in IR with fixed width can leave
231:(top panel). Renormalized Gaussian radial basis functions avoid this prob-
231:lem, and produce basis functions similar in some respects to B-splines.
231:basis functions,
231:viewed as an expansion in renormalized radial basis functions,
232:with a basis function hi located at every observation and coefficients yi ;
232:basis functions form the bridge between the modern “kernel methods” and
234:an expansion in M basis functions costs O(M ) for one evaluation, and
234:typically M ∼ O(log N ). Basis function methods have an initial cost of at
234:   Popular implementations of local regression, such as the loess function in
237:The loss function for measuring errors between Y and fˆ(X) is denoted by
239:G(X)    directly. Typical loss functions are
239:   The log-likelihood can be used as a loss-function for general response
240:this depends on the signal-to-noise ratio of the underlying function, and
242:error between the best-fitting linear approximation and the true function.
247:   For squared error, 0–1, and other loss functions, one can show quite
247:or basis functions. For example,
248:the number d of inputs or basis functions we use, but decreases as the
248:eral tools can be used with any loss function, and with nonlinear, adaptive
248:error by a factor proportional to the number of basis functions used.
248:estimate of Errin when a log-likelihood loss function is used. It relies
249:The function AIC(α) provides an estimate of the test error curve, and we
249:fαˆ (x). Note that if the basis functions are chosen adaptively, (7.23) no
249:coefficient function β(f ) = m=1 hm (f )θm , an expansion in M spline ba-
249:sis functions. For any given M , a basis of natural cubic splines is used
249:d(α) = d(M ) = M ). Using AIC to select the number of basis functions will
250:P       of Section 5.2.3. The logistic regression coefficient function
250:) = M  m=1 hm (f )θm is modeled as an expansion in M spline basis functions.
251:   For models like neural networks, in which we minimize an error function
251:to the error function at the solution (Bishop, 1995).
252:parameters in model Mm . If we define our loss function to be
255:FIGURE 7.5. The solid curve is the function sin(50x) for x ∈ [0, 1]. The
255:and blue (hollow) points illustrate how the associated indicator function
255:Suppose we have a class of functions {f (x, α)} indexed by a parameter
255:vector α, with x ∈ IRp . Assume for now that f is an indicator function,
255:            cator function I(α0 + α1T x > 0), then it seems reasonable to
255:            function sin(50 · x) is shown in Figure 7.5. This is a very
255:function sin(50 · x) is shown in Figure 7.5. This is a very wiggly function
255:less complexity than the linear indicator function I(α0 + α1 x) in p = 1
256:plexity of a class of functions by assessing how wiggly its members can
256:A set of points is said to be shattered by a class of functions if, no matter
256:   Figure 7.6 shows that the VC dimension of linear indicator functions
256:set of lines. In general, a linear indicator function in p dimensions has VC
256:   So far we have discussed the VC dimension only of indicator functions,
256:but this can be extended to real-valued functions. The VC dimension of a
256:class of real-valued functions {g(x, α)} is defined to be the VC dimension
256:error when using a class of functions. An example of such a result is
256:following. If we fit N training points using a class of functions {f (x, α)}
257:f (x, α), they give probabilistic upper bounds for all functions f (x, α),
257:of a class of functions. Often only a crude upper bound for VC dimension
260:function that indicates the partition to which observation i is allocated by
260:the randomization. Denote by fˆ−k (x) the fitted function, computed with
260:The function CV(fˆ, α) provides an estimate of the test error curve, and we
268:empirical distribution function Fˆ for the data (z1 , z2 , . . . , zN ).
272:curves ErrT as a function of subset size (top left). The next two panels show
276:the cumulative Gaussian distribution function. This is an increasing func-
277:Ex. 7.8 Show that the set of functions {I(sin(αx) > 0)} can shatter the
280:seven B-spline basis functions. The broken vertical lines indicate the
280:ear space of functions, and can be represented, for example, by a linear
280:expansion of B-spline basis functions (see Section 5.9.2):
280:the hj (x), j = 1, 2, . . . , 7 are the seven functions shown in the right
282:bootstrap samples goes to infinity. A function estimated from a bootstrap
283:   We begin by specifying a probability density or probability mass function
283:Maximum likelihood is based on the likelihood function, given by
283:We think of L(θ; Z) as a function of θ, with our data Z fixed.
283:   The likelihood function can be used to assess the precision of θ.  ˆ We
283:a few more definitions. The score function is defined by
284:likelihood function, by using the chi-squared approximation
285:(density or probability mass function) for our data given the parameters,
286:functions are fairly complex entities: one approach is to use a Gaussian
286:function values µ(x) and µ(x ) (Wahba, 1990; Neal, 1996).
287:            bution for the function µ(x).
287:Here we are willing to say the function µ(x) should be smooth, and have
287:Σ = I. When the number of basis functions is large, this might not be suf-
287:generate posterior values of the function µ(x), we generate values β from
288:                      for the function µ(x), for two different values of the
290:that is, the prior probability mass function is proportional to            =1
290:mass function N wˆ ∗ ,...,N w
291:green) of the left component density for observation y, as a function of y.
293:radial basis functions.
294:FIGURE 8.6. EM algorithm: observed data log-likelihood as a function of the
295:       as a function of the dummy argument θ .
295:the actual objective function (θ ; Z). Why does it succeed in maximizing
295:inequality) is maximized as a function of θ ∗ , when θ ∗ = θ (see
295:increases as a function of the first argument, that is, Q(θˆ(j+1) , θˆ(j)
295:algorithm. Consider the function
296:the observed data, from (8.46)1 . The function F expands the domain of
300:only when the latter is a nonlinear or adaptive function of the data. For
301:Here it is useful to consider an underlying indicator-vector function fˆ(x),
301:an underlying function f (x) that estimates the class probabilities at x (for
303:error of the original tree and bagged trees as a function of the number of
311:Ex. 8.1 Let r(y) and q(y) be probability density functions. Jensen’s in-
311:equality states that for a random variable X and a convex function φ(x),
311:is maximized as a function of r(y) when r(y) = q(y). Hence show that
311:Ex. 8.5 Suggest generalizations of each of the loss functions in Figure 10.4
311:       function of age. Use cross-validation to estimate the optimal amount
311:       derlying function.
311:  (b) Compute the posterior mean and covariance for the true function via
312:Lange, 2007). A function g(x, y) to said to minorize a function f (x) if
312:Lange, 2007). A function g(x, y) to said to minorize a function f (x) if
312:There are analogous definitions for majorization, for minimizing a function
313:for the unknown regression function, and by doing so they finesse the curse
313:we described techniques that used predefined basis functions to achieve
314:are unspecified smooth (“nonparametric”) functions. If we were to model
314:each function using an expansion of basis functions (as in Chapter 5), the
314:each function using an expansion of basis functions (as in Chapter 5), the
314:here is different: we fit each function using a scatterplot smoother (e.g., a
314:simultaneously estimating all p functions (Section 9.1.1).
314:the logit link function:
314:general functional form
314:where again each fj is an unspecified smooth function. While the non-
314:parametric form for the functions fj makes the model more flexible, the
314:a response Y is related to an additive function of the predictors via a link
314:function g:
314:Examples of classical link functions are the following:
314:g(µ) = logit(µ) as above, or g(µ) = probit(µ), the probit link function,
314:for modeling binomial probabilities. The probit function is the inverse
314:       Gaussian cumulative distribution function: probit(µ) = Φ−1 (µ).
314:   The functions fj are estimated in a flexible manner, using an algorithm
315:of the functions fj need to be nonlinear. We can easily mix in linear and
315:    • g(µ) = f (X) + g(Z, W ) where g is a nonparametric function in two
315:of (9.7) is an additive cubic spline model; each of the functions fj is a
316:       until the functions fˆj change less than a prespecified threshold.
316:can add or subtract any constants to each of the functions fj , and adjust
316:0 ∀j—the functions average zero over the data. It is easily seen that α
316:− α           ˆ − k=j fˆk (xik )}N          1 , as a function of xij ,
316:the current estimates of the other functions fˆk when computing yi − α
317:   The functions f1 , f2 , . . . , fp are estimated by a backfitting
318:   3. Continue step 2. until the change in the functions falls below a pre-
319:0.1)), but the plots in Figure 9.1 are shown as a function of the original
320:function is summarized by the coefficient, standard error and Z-score; the
320:of the estimated function. Note, however, that the effect of each predictor
320:   Figure 9.1 shows the estimated functions for the significant predictors
321:9.1. Spam analysis: estimated functions for significant predictors. The
327:9.3. Node impurity measures for two-class classification, as a function
329:if, as a function of k, Lkk doesn’t depend on k . Observation weighting can
330:function to be smooth. The MARS procedure, described in Section 9.4,
331:error rate as a function of the size of the pruned tree, along with ±2 stan-
332:estimate of misclassification rate as a function of tree size, with standard
336:for maxima in the target function, an exercise known as bump hunting. (If
337: FIGURE 9.8. Box mean as a function of number of observations in the box.
339:   MARS uses expansions in piecewise linear basis functions of the form
340:            FIGURE 9.9. The basis functions (x − t)+ (solid orange) and (t
340:            As an example, the functions (x − 0.5)+ and (0.5 − x)+ are
340:              Each function is piecewise linear, with a knot at the value t.
340:terminology of Chapter 5, these are linear splines. We call the two functions
340:            Therefore, the collection of basis functions is
340:If all of the input values are distinct, there are 2N p basis functions alto-
340:gether. Note that although each basis function depends only on a single
340:, for example, h(X) = (Xj − t)+ , it is considered as a function over the
340:but instead of using the original inputs, we are allowed to use functions
340:            where each hm (X) is a function in C, or a product of two or more
340:            functions.
340:real art, however, is in the construction of the functions hm (x). We start
340:            with only the constant function h0 (X) = 1 in our model, and all
340:with only the constant function h0 (X) = 1 in our model, and all functions
340:in the set C are candidate functions. This is depicted in Figure 9.10.
340:At each stage we consider as a new basis function pair all products of a
340:            function hm in the model set M with one of the reflected pairs in
341:the left are the basis functions currently in the model: initially, this is
341:                    function h(X) = 1. On the right are all candidate basis
341:h(X) = 1. On the right are all candidate basis functions to be considered
341:building the model. These are pairs of piecewise linear basis functions as in
341:each stage we consider all products of a candidate pair with a basis function
341:                    the selected functions shown in red.  
342:         FIGURE 9.11. The function h(X1 , X2 ) = (X1 − x51 )+ · (x72 −
342:         from multiplication of two piecewise linear MARS basis functions.
342:For example, at the first stage we consider adding to the model a function
342:         the constant function just produces the function itself. Suppose the
342:the constant function just produces the function itself. Suppose the best
342:(X2 − x72 )+ + βˆ2 (x72 − X2 )+ . Then this pair of basis functions
342:         The third choice produces functions such as (X1 − x51 )+ · (x72
343:   Thus if there are r linearly independent basis functions in the model, and
343:   Why these piecewise linear basis functions, and why this particular model
343:strategy? A key property of the functions of Figure 9.9 is their ability to
343:part of the feature space where both component functions are nonzero. As
343:run out quickly. The use of other basis functions such as polynomials, would
343:   The second important advantage of the piecewise linear basis function
343:concerns computation. Consider the product of a function in M with each
343:simple form of the piecewise linear function. We first fit the reflected pair
343:time to the left, the basis functions differ by zero over the left part of
344:cedure, as a function of the rank (number of independent basis functions) in
344:as a function of the rank (number of independent basis functions) in the
344:in a more stable way with piecewise linear functions.
344:pairwise products of piecewise linear functions, but not three- or higher-
344:function nonetheless (see Section 9.4.3). Figure 9.12 shows the test error
344:misclassification rate as a function of the rank (number of independent ba-
344:sis functions) in the model. The error rate levels off at about 5.5%, which
346:set of basis functions for all response variables. Classification is made to
346:to the multinomial log-likelihood to search for the next basis-function pair.
346:• Replace the piecewise linear basis functions by step functions I(x−t >
346:• Replace the piecewise linear basis functions by step functions I(x−t >
346:tree-growing algorithm. Multiplying a step function by a pair of reflected
347:step functions is equivalent to splitting a node at the step. The second
347:Each such partition generates a pair of piecewise constant basis functions—
347:indicator functions for the two sets of categories. This basis pair is now
347:basis functions already in the model.
347:multiway, not just binary, and the splits are probabilistic functions of a
349:The log-likelihood is a smooth function of the unknown weights and hence
352:   MARS requires N m2 + pmN operations to add a basis function to a
353:      Here each fj is an N -vector of evaluations of the jth function at
354:        function of temperature, wind speed, and radiation. Compare your
358:as a function of the number of iterations. Also shown are the test error rate
358:        optimizing a novel exponential loss function. This loss function is
358:        optimizing a novel exponential loss function. This loss function is
359:    • The population minimizer of the exponential loss function is shown
359:    • We describe loss functions for regression and classification that are
359:       trees with any loss function (Section 10.10).
359:of elementary “basis” functions. Here the basis functions are the
359:elementary “basis” functions. Here the basis functions are the individual
359:Gm (x) ∈ {−1, 1}. More generally, basis function expansions take
359:are usually simple functions of the multivariate argument x, characterized
359:γ1T x), where σ(t) = 1/(1 + e−t ) is the sigmoid function, and γ param-
359:       power spline basis functions where γ parameterizes the variables and
360:   Typically these models are fit by minimizing a loss function averaged
360:function,
360:For many loss functions L(y, f (x)) and/or basis functions b(x; γ), this re-
360:For many loss functions L(y, f (x)) and/or basis functions b(x; γ), this re-
360:solve the subproblem of fitting just a single basis function,
360:tially adding new basis functions to the expansion without adjusting the
360:basis function b(x; γm ) and corresponding coefficient βm to add to the
361:stagewise additive modeling (Algorithm 10.2) using the loss function
361:   For AdaBoost the basis functions are the individual classifiers Gm (x) ∈
361:{−1, 1}. Using the exponential loss function, one must solve
364:function is
364:any probability mass function for a binary random variable Y ∈ {−1, 1}.
364:this section we examine the different loss functions for classification and
364:functions of the “margin” yf (x). In classification (with a −1/1
365:            FIGURE 10.4. Loss functions for two-class classification. The
365:            Section 12.3). Each function has been scaled so that it passes
365:            criteria as a function of the margin y · f (x). Also shown is
366:is not a monotone decreasing function of increasing margin yf (x). For mar-
366:creasing criterion serves as a better surrogate loss function. Figure 12.4 on
366:(x) > 1, and becomes linear for y · f (x) < −1. Since quadratic functions
366:here we have K different functions, one per class. There is a redundancy
366:in the functions fk (x), since adding an arbitrary h(x) to each leaves the
367:to the K-class multinomial deviance loss function:
367:Figure 10.5 compares these three loss functions.
368:10.5. A comparison of three loss functions for regression, plotted as a
368:            function of the margin y−f . The Huber loss function combines
368:of the margin y−f . The Huber loss function combines the good properties
371:general agreement with the corresponding functions found by the additive
371:be much lower and roughly constant as a function of !. As the frequency
371:of hp decreases, the functional relationship with ! strengthens.
377:calculate for any differentiable loss function L(y, f (x)), whereas solving
378:            TABLE 10.2. Gradients for commonly used loss functions.
378:   Table 10.2 summarizes the gradients for commonly used loss functions.
378:   For classification the loss function is the multinomial deviance (10.22),
378:ized or pseudo residuals, r. Gradients for commonly used loss functions are
380:of the “target” function
380:The target function η(x) is the one with minimum prediction risk on future
380:data. This is the function we are trying to approximate.
380:The first sum in (10.40) is over functions of only a single predictor
380:Xj . The particular functions ηj (Xj ) are those that jointly best
380:“main effect” of Xj . The second sum is over those two-variable functions
381:generative function is additive (sum of quadratic monomials), so boosting
381:error. Figure 10.10 compares the coordinate functions found by boosted
381:stumps with the true functions.
382:FIGURE 10.10. Coordinate functions estimated by boosting stumps for the sim-
382:example used in Figure 10.9. The true quadratic functions are shown for
382:                    as a function of M on a validation sample. The value of M
385:the models were fit by gbm using a binomial deviance loss function; in the
387:f (X) on their joint values. Graphical renderings of the f (X) as a function
387:We can easily display functions of one or two arguments, either continuous
387:   For more than two or three variables, viewing functions of the corre-
387:with S ∪ C = {1, 2, . . . , p}. A general function f (X) will in principle
387:   Partial dependence functions can be used to interpret the results of any
388:   It is important to note that partial dependence functions defined in
388:and is the best least squares approximation to f (X) by a function of XS
388:Thus each fk (X) is a monotone increasing function of its respective prob-
389:using different loss functions as appropriate.
389:as a function for number of iterations M on both the training data and test
390:FIGURE 10.13. Average-absolute error as a function of number of iterations
393:ence, abundance and richness as a function of environmental variables.
394:(GBM)4 with binomial deviance loss function, depth-10 trees, and a shrink-
396:FIGURE 10.19. The left panel shows the mean deviance as a function of the
402:multiplicative functions (10.50) and (10.51), while the conditional expec-
403: (b) Show that a multiclass boosting using this loss function leads to a
404:deviance loss function (10.22) and the symmetric logistic transform, use
404:Ex. 10.11 Show how to compute the partial dependence function fS (XS )
404:though f is not a function of X2 .
407:a nonlinear function of these features. The result is a powerful learning
407:than the inputs themselves. The functions gm are unspecified and are esti-
408:FIGURE 11.1. Perspective plots of two ridge functions.          √
408:                       The function gm (ωm  T
408:X) is called a ridge function in IRp . It varies only
408:some examples of ridge functions. In the example on the left ω = (1/ 2)(1,
408:                    so that the function only varies in the direction X1 + X2
408:                    nonlinear functions of linear combinations generates a
408:PPR model can approximate any continuous function in IRp arbitrarily
408:                    We seek the approximate minimizers of the error function
409:over functions gm and direction vectors ωm , m = 1, 2, . . . , M . As in
410:and then the target Yk is modeled as a function of linear combinations of
410:   The activation function σ(v) is usually chosen to be the sigmoid σ(v) =
410:radial basis functions (Chapter 6) are used for the σ(v), producing what is
410:known as a radial basis function network.
411:   The output function gk (T ) allows a final transformation of the vector of
411:T . For regression we typically choose the identity function gk (T ) =
411:. Early work in K-class classification also used the identity function, but
411:this was later abandoned in favor of the softmax function
411:tion 4.2 we discuss other problems with linear activation functions, in par-
411:basis functions are learned from the data.
412:FIGURE 11.3. Plot of the sigmoid function σ(v) = 1/(1+exp(−v)) (red
412:Notice that if σ is the identity function, then the entire model collapses
412:        function.
412:The difference is that the PPR model uses nonparametric functions gm (v),
412:while the neural network uses a far simpler function based on σ(v), with
412:surprising that a neural network might use 20 or 100 such functions, while
413:to use of a step function for σ(Z) and gm (T ). Later the neural network was
413:purpose the step function is not smooth enough for optimization. Hence the
413:step function was replaced by a smoother threshold function, the sigmoid
413:step function was replaced by a smoother threshold function, the sigmoid
413:function)
413:activation function and the cross-entropy error function, the neural network
413:activation function and the cross-entropy error function, the neural network
415:squares error function, and are derived in Exercise 11.3.
415:function at each update. With online learning γr should decrease to zero
416:penalty to the error function R(θ) + λJ(θ), where
417:Both use the softmax activation function and cross-entropy error.  
418:     The error function R(θ) is nonconvex, possessing many local minima. As
419:   A radial function is in a sense the most difficult for the neural net, as
420:Bayes error (broken horizontal line). True function is a sum of two sigmoids
420:on the left, and a radial function is on the right. The test error is
421:Bayes error. True function is a sum of two sigmoids. The test error is
421:11.8. Boxplots of test error, for simulated data example. True function
424:FIGURE 11.11. Test performance curves, as a function of the number of train-
424:sum-of-squares error function. The first network has no hidden layer, and
425:the same linear functional, and consequently these networks are sometimes
425:function R with respect to a shared weight is the sum of the gradients of
427:functions of real-valued parameters. This facilitates the development of
428:which the potential function is the target density. This is done to avoid
433:using squared-error loss and identity output function gk (t) = t. Suppose
433:cross-entropy loss function.
434:      where σ is the sigmoid function, Z is standard normal, X T = (X1 , X2
434:      test error curves as a function of the number of training epochs, for
436:(x) = xT β +β0 = 0. Since the classes are separable, we can find a function
438:   The Lagrange (primal) function is
438:tive function
438:which gives a lower bound on the objective function (12.8) for any feasible
439:Given the solutions βˆ0 and β,ˆ the decision function can be written as
441:late to nonlinear boundaries in the original space. Once the basis functions
441:. . , N , and produce the (nonlinear) function fˆ(x) = h(x)T βˆ + βˆ0 .
441:hibitive. It would also seem that with sufficient basis functions, the data
441:classifier is solving a function-fitting problem using a particular criterion
441:   The Lagrange dual function (12.13) has the form
441:From (12.10) we see that the solution function f (x) can be written
442:knowledge of the kernel function
442:symmetric positive (semi-) definite function; see Section 5.8.1.
444:FIGURE 12.4. The support vector loss function (hinge loss), compared to the
444:               function of yf rather than f , because of the symmetry between
444:penalty, which is a familiar paradigm in function estimation. It is easy to
444:of the “hinge” loss function L(y, f ) = [1 − yf ]+ shows that
444:               traditional loss functions. Figure 12.4 compares it to the
445:12.1. The population minimizers for the different loss functions in Fig-
445:   We can characterize these loss functions in terms of what they are es-
445:properties of logistic regression (smooth loss function, estimates probabili-
445:   Formulation (12.25) casts the SVM as a regularized function estimation
446:   All the loss-function in Table 12.1 except squared-error are so called
446:“margin maximizing loss-functions” (Rosset et al., 2004b). This means
446:Here we describe SVMs in terms of function estimation in reproducing
447:where H is the structured space of functions, and J(f ) an appropriate reg-
447:functions f (x) = j=1 fj (xj ), and J(f ) = j {f j (xj )}2 dxj . Then the
447:described in (12.22) above can be used with any convex loss function, and
447:Figure 12.5 uses the same kernel functions as in Figure 12.3, except using
447:binomial log-likelihood as a loss function2 . The fitted function is hence
447:binomial log-likelihood as a loss function2 . The fitted function is hence
448:loss instead of the SVM loss function. The two broken contours correspond to
450:FIGURE 12.6. Test-error curves as a function of the cost parameter C for the
450:Figure 12.6 shows the test error on the mixture data as a function of
453:FIGURE 12.8. The left panel shows the -insensitive error function used by the
453:vector regression machine. The right panel shows the error function used
453:robust regression (blue curve). Beyond |c|, the function changes from
453:shown in the right panel of Figure 12.8. This function reduces from quadratic
453:ˆ βˆ0 are the minimizers of H, the solution function can be shown to
454:function V , just like c is for VH . Note that both V and VH depend on the
454:function in terms of a set of basis functions {hm (x)}, m = 1, 2, . . . , M :
454:function in terms of a set of basis functions {hm (x)}, m = 1, 2, . . . , M :
455:as both the radial basis function expansion and a regularization estimate,
455:or evaluate the large set of functions h1 (x), h2 (x), . . . , hM (x). Only
455:of hm (such as the eigenfunctions of particular, easy-to-evaluate kernels
456:one could use the multinomial loss function along with a suitable kernel,
456:of functions {G(x), β ≤ A} has VC-dimension h satisfying
458:each having measured features X. Suppose θ : G → IR1 is a function that
459:LDA. We have in mind generalized additive fits, spline functions, MARS
459:spline models. Also included are the classes of functions and associated
459:quadratic surfaces, since each of the fitted functions is quadratic, and as
460:large basis set (N ×p basis functions for additive splines), but then
461:is used to fit the model; plotted are the fitted regression functions
461:functions to model the η (x), and the points plotted in the right plot have
462:fixed, as does MARS once the basis functions are selected. The subscript λ
463:       the vector of fitted regression functions.
463:   The first of the K functions in η(x) is the constant function— a
463:The first of the K functions in η(x) is the constant function— a trivial
463:solution; the remaining K −1 functions are the discriminant functions. The
463:solution; the remaining K −1 functions are the discriminant functions. The
463:constant function, along with the normalization, causes all the remaining
463:functions to be centered.
463:section on page 455 makes good use of this modularity; the fda function
463:has a method= argument that allows one to supply any regression function,
463:as long as it follows some natural conventions. The regression functions
463:neously computes all the optimal scoring functions.
463:useful discriminant functions that are devoid of these pitfalls. Exercise
464:on spline basis functions, Ω might constrain η to be smooth over IRp . In
464:the case of additive splines, there are N spline basis functions for each
464:resulting in a total of N p basis functions in h(x); Ω in this case
465:inant coefficient functions for the digit recognition problem. The left
465:contrast functional for separating images with a dark central vertical strip
474:ratio. You decide to restrict all the prototypes to be smooth functions
474:       functions with J knots uniformly chosen in (0, 255) and boundary
474:is a linear expansion of basis functions hm (x), m = 1, . . . , M . Let Dπ =
475:  (d) Suppose that the hj include the constant function. Show that the
483:as a function of the neighborhood size, for the two-class mixture problem.
485:shows the misclassification errors as a function of neighborhood size. Stan-
500:Ex. 13.4 Consider an image to be a function F (x) : IR2 → IR1 over the two-
503:answer. This is usually characterized by some loss function L(y, yˆ),
504:considered as functions of a smaller set of “latent” variables. Cluster
513:lem into one of supervised function approximation. This forms the basis
513:(x) be a specified probability density function used for reference. For ex-
514:since gˆ(x) = µ         ˆ(x)), is a monotone function. The contours
514:should be chosen so that the resulting functions µ(x) or f (x) are approx-
514:the primary goal. Both µ(x) and f (x) are monotonic functions of the den-
516:for which the target function µ(x) = E(Y | x) is relatively large. In
517:them, rather than trying to model the target function over the entire data
520:     cost function in prediction problems (supervised learning). There the
521:data were collected as similarities, a suitable monotone-decreasing function
522:      define the “error” between them as a monotone-increasing function
525:probability density function. This density function is characterized by a pa-
525:probability density function. This density function is characterized by a pa-
525:rameterized model taken to be a mixture of component density functions;
525:ing to directly estimate distinct modes of the probability density function.
526:observations. These are adjusted so as to minimize a “loss” function that
526:   One approach is to directly specify a mathematical loss function and
526:(or “energy”) function would be
530:relative density under each mixture component is a monotone function of
536:cluster dissimilarity WK as a function of the number of clusters K. Separate
537:function of K. As with other aspects of clustering procedures, this approach
547:where the neighborhood function h gives more weight to prototypes mk with
549:of mj . The weight function may be rectangular, that is, equal to 1 for the
559:curve in IRp . Hence f (λ) is a vector function with p coordinates, each a
559:smooth function of the single parameter λ. The parameter λ can be chosen,
560:         functions f (λ) = [f1 (λ), f2 (λ), . . . , fp (λ)] and let X T =
561:conditional expectations in step (a) by smoothing each Xj as a function of
561:                      principal surface, with coordinate functions
561:data. Plotted are the data points as a function of the estimated nonlinear
561:kernel surface smoother to estimate each coordinate function fj (λ1 , λ2 ),
562:of its coordinate functions, while SOMs are discrete and produce only the
562:simple examples the estimates coordinate functions themselves can be in-
566:ple evaluations of principal component functions gm ∈ HK , with HK the
566:first principal component function g1 solves
566:constraint ||g1 ||HK = 1 controls the size and roughness of the function g1 ,
566:αj1 , j = 1, . . . , N above. The second principal component function is de-
572:over the weights W and B. This function is minimized in an alternating
585:   We fit the functions gj and directions aj by optimizing (14.91) in an
586:trast function as in (14.87). The fixed point update in step 2(b) is a
588:the so-called stress function13
589:scaling; the loss functions are different, and the mapping can be nonlinear.
589:Nonmetric scaling seeks to minimize the stress function
589:over the zi and an arbitrary increasing function θ. With θ fixed, we min-
592:neighbors of i , or vice-versa. Then we construct the stress function
594:minimizes the stress function (14.106) over zi , for fixed values of the
594:values to find a good minimum of the (nonconvex) stress function (14.106).
600:       functions. Compare them to the underlying functions cos(s), sin(s)
600:       functions. Compare them to the underlying functions cos(s), sin(s)
600:principal component functions are defined in a similar manner (hint: see
601:+ qˆ⊥ (s), where q is a quadratic function (in the null space of the
601:2007). A function g(x, y) to said to minorize a function f (x) if
601:2007). A function g(x, y) to said to minorize a function f (x) if
602:There are analogous definitions for majorization, for minimizing a function
602: (a) Consider maximization of the function L(W, H) in (14.73), written
603: (b) Hence show that, ignoring constants, the function
605:the variance of an estimated prediction function. Bagging seems to work
609:function of the number of trees in the models. Two random forests are shown,
617:regression algorithm, as a function of m. The boxplots represent the
618:a single random forest tree, as a function of m. “Within Z” refers to the
618:squared bias and variance of the ensemble, as a function of m. Note that the
619:   Any discussion of bias depend on the unknown true function. Figure 15.10
623:functions serving the role of weak learners.
624:δk (x) =         =1 |Ck − pˆ (x)|, the discriminant function for the
625:be realized on the training data as basis functions in IRp . The linear model
625:J(α) is a function of the coefficients that generally penalizes larger
626:sible trees will be relevant in approximating any particular target function.
626:   Owing to the very large number of basis functions Tk , directly solving
626:of tree basis functions Tk , the algorithm can be used with any set of ba-
626:sis functions. Initially all coefficients are zero in line 1; this
626:3. Here, instead of using trees Tk (X) as basis functions, we use the origi-
627:if all of the basis functions Tk are mutually uncorrelated, then as ε ↓ 0,
627:                      functions of λ. This is often the case when the
628:cient paths are piece-wise linear functions, both for the lasso and forward
628:at each step the loss function for a given increase in the arc length of the
628:tree-induction algorithm. For other loss functions, such as the exponential
628:with shrinkage approximately minimizes the same loss function with a
628:“model space” and adding shrunken basis functions derived from impor-
628:to deal with, as shown in Section 12.3.7. With the basis functions and L 2
628:individual basis functions.
629:functions with nonzero coefficients (among all possible choices).
629:       on the unknown true target function, and the chosen dictionary T .
629:       dictionary may lead to a sparser representation for our function, but
631:functions they have an appealing limiting form.
634:sifier on the mixture data, as a function of the number of 4-node trees. The
634:functions. They show that as λ ↓ 0, for particular loss functions the
634:They show that as λ ↓ 0, for particular loss functions the solution
634:a more effective and efficient ensemble model. Again we consider functions
635:where T is a dictionary of basis functions, typically trees. For gradient
635:A finite dictionary TL = {T1 (x), T2 (x), . . . , TM (x)} of basis functions
635:    • A family of functions fλ (x) is built by fitting a lasso path in
635:basis functions, we want a collection that covers the space well in places
636:using the lasso, as a function of the number of trees with nonzero
636:and importance sampling. They view the unknown function as an integral
636:where γ ∈ Γ indexes the basis functions b(x; γ). For example, if the
636:functions are trees, then γ indexes the splitting variables, the
636:function (16.9):
637:   If a single basis function were to be selected (e.g., a tree), it would be
639:(η, ν). We report mean-squared error from the true (known) function.
639:function is
642:of the hidden units (basis functions), along with how to combine them.
646:density function f over a Markov graph G can be can represented as
647:C is the set of maximal cliques, and the positive functions ψC (·) are
647:called clique potentials. These are not in general density functions1 , but
647:is the normalizing constant, also known as the partition function. Alterna-
648:(Koller and Friedman, 2007). Here there is a potential function for each
648:structure. The models for both continuous and discrete data are functions
650:µ. The quantity − (Θ) is a convex function of Θ. It is easy to show that
653:likelihood is a convex function of Θ.
655:one can also quickly compute and examine the solution paths as a function
656:of pairwise interactions. Φ(Θ) is the log of the partition function,
656:The partition function ensures that the probabilities add to one over the
657:of the (log) potential functions (17.5), and for technical reasons requires
660:a function of the other nodes, and then symmetrize the edge parameter
662:partition function as it is the same for all of these combinations.
671:FIGURE 18.2. Soft thresholding function sign(x)(|x| − ∆)+ is shown in
671:absolute value is less than zero. The soft-thresholding function is shown
678:problem where we use a linear function f (X) = β0 + X T β to model a
678:by minimizing some loss function i=1 L(yi , f (xi )) over the data with a
682:This is an example of functional data; the predictors can be viewed as a
682:function of m/z. There has been much interest in this problem in the past
684:the mass-to-charge ratio m/z. More generally, we may have functional fea-
684:We can represent xi (t) by their coefficients in a basis of functions in t,
686:functional and structural classes based on their sequence similarities. Pro-
693:        function for the 80 patients in the test set, along with
696:       outcome as a function of each feature separately.
713:version W + λI, leading to a regularized discriminant function δλ (x) =
714:       can be viewed as a nonparametric discriminant function correspond-
714:  (b) How would you modify this function to introduce class prior probabil-
718:     sigmoid function, IEEE Transactions on Information Theory 39: 930–
719:    inant function,“Naive Bayes”, and some alternatives when there are
720:     Discovering functional relationships between RNA expression and
725:Friedman, J. (1994b). An overview of predictive learning and function
726:Friedman, J. (2001). Greedy function approximation: A gradient boosting
740:      and belief-function propagation, AAAI Workshop on Uncertainty in
755:Activation function, 392–395            flow cytometry, 637
756:Basis functions, 141, 186, 189, 321,  Bottom-up clustering, 520–528
757:Confusion matrix, 301                   functions, 109–110
758:    stagewise additive modeling,      Haar basis function, 176
758:Gaussian radial basis functions,      ICA, see Independent components
759:Junction tree, 629                   Likelihood function, 265, 273
759:K-medoid clustering, 515–520         Linear discriminant function, 106–
759:     function, 209                   Link function, 296
759:     function, 209                   Link function, 296
759:Laplacian, 545                       Logistic (sigmoid) function, 393
759:68–69, 86–90, 609, 635, 636,  Loss function, 18, 21, 219–223, 346
761:Partition function, 638               Pruning, 308
761:          317–321, 499–501            Quadratic discriminant function,
761:          tion                        Radial basis function (RBF) net-
761:          449                         Radial basis functions, 212–214,
762:Reproducing property, 169            Softmax function, 393
763:Stress function, 570–572            Validation set, 222
763:Tangent distance, 471–475                basis functions, 176–179
763:Tanh activation function, 424            smoothing, 174
