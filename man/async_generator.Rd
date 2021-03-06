% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/async.R
\name{async_generator}
\alias{async_generator}
\alias{await_each}
\title{Construct an async generator}
\usage{
async_generator(fn)

await_each(x)
}
\arguments{
\item{fn}{An anonymous function describing an async generator
within which \code{await()} calls are allowed.}

\item{x}{An awaitable value, i.e. a \link[promises:promise]{promise}.}
}
\value{
A generator factory. Generators constructed with this
factory always return \code{\link[promises:promise]{promises::promise()}}.
}
\description{
An async generator constructs iterable functions that are also
awaitables. They support both the \code{yield()} and \code{await()} syntax.
An async iterator can be looped within async functions and
iterators using \code{await_each()} on the input of a \code{for} loop.

The iteration protocol is derived from the one described in
\code{\link{iterator}}. An async iterator always returns a
promise. When the iterator is exhausted, it returns a resolved
promise to the exhaustion sentinel.
}
\examples{
# Creates awaitable functions that transform their inputs into a stream
generate_stream <- async_generator(function(x) for (elt in x) yield(elt))

# Maps a function to a stream
async_map <- async_generator(function(.i, .fn, ...) {
  for (elt in await_each(.i)) {
    yield(.fn(elt, ...))
  }
})

# Example usage:
if (interactive()) {
  library(magrittr)
  generate_stream(1:3) \%>\% async_map(`*`, 2) \%>\% async_collect()
}
}
\seealso{
\code{\link[=async]{async()}} for creating awaitable functions;
\code{\link[=async_collect]{async_collect()}} for collecting the values of an async iterator;
\code{\link[=coro_debug]{coro_debug()}} for step-debugging.
}
