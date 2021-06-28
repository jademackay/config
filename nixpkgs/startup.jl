using Pkg

if isfile("Project.toml") && isfile("Manifest.toml")
    Pkg.activate(".")
end

try
    using Revise
catch e
    @warn "Error initializing Revise" exception=(e, catch_backtrace())
end
