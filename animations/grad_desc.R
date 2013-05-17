library(animation)

grad_desc <- function (FUN = function(x, y) x^2 + 2 * y^2, rg = c(-3, -3, 
    3, 3), init = c(-3, 3), gamma = 0.05, tol = 0.001, gr = NULL, 
    len = 50, interact = FALSE, col.contour = "red", col.arrow = "blue", 
    main) 
{
    nmax = ani.options("nmax")
    x = seq(rg[1], rg[3], length = len)
    y = seq(rg[2], rg[4], length = len)
    nms = names(formals(FUN))
    grad = if (is.null(gr)) {
        deriv(as.expression(body(FUN)), nms, function.arg = TRUE)
    }
    else {
        function(...) {
            res = FUN(...)
            attr(res, "gradient") = matrix(gr(...), nrow = 1, 
                ncol = 2)
            res
        }
    }
    z = outer(x, y, FUN)
    xy = if (interact) {
        contour(x, y, z, col = "red", xlab = nms[1], ylab = nms[2], 
            main = "Choose initial values by clicking on the graph")
        unlist(locator(1))
    }
    else init
    newxy = xy - gamma * attr(grad(xy[1], xy[2]), "gradient")
    gap = abs(FUN(newxy[1], newxy[2]) - FUN(xy[1], xy[2]))
    if (missing(main)) 
        main = eval(substitute(expression(z == x), list(x = body(FUN))))
    i = 1
    while (gap > tol && i <= nmax) {
        dev.hold()
        contour(x, y, z, col = col.contour, xlab = nms[1], ylab = nms[2], 
            main = main)
        xy = rbind(xy, newxy[i, ])
        newxy = rbind(newxy, xy[i + 1, ] - gamma * attr(grad(xy[i + 
            1, 1], xy[i + 1, 2]), "gradient"))
        arrows(xy[1:i, 1], xy[1:i, 2], newxy[1:i, 1], newxy[1:i, 
            2], length = par("din")[1]/50, col = col.arrow)
        gap = abs(FUN(newxy[i + 1, 1], newxy[i + 1, 2]) - FUN(xy[i + 
            1, 1], xy[i + 1, 2]))
        ani.pause()
        i = i + 1
        if (i > nmax) 
            warning("Maximum number of iterations reached!")
    }
    invisible(list(par = newxy[i - 1, ], value = FUN(newxy[i - 
        1, 1], newxy[i - 1, 2]), iter = i - 1, gradient = grad, 
        persp = function(...) persp(x, y, z, ...)))
}
