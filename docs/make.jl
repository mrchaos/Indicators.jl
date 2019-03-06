using Documenter, Indicators, Plots

makedocs(
    modules = [Indicators],
    sitename = "Indicators",
    authors="Jacob Amos",
    format = Documenter.HTML(),
    doctest=false,
    clean=true,
)

deploydocs(deps=Deps.pip("mkdocs", "python-markdown-math"),
           repo="github.com/dysonance/Indicators.jl.git",
           devbranch="master",
           devurl="dev",
           versions=["stable" => "v^", "v#.#", "dev" => "dev"])
