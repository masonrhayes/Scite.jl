using JSON, HTTP, DataFrames
using Base.Iterators

function scite(issn::String)
    issn = strip(issn)
    base_url = "https://api.scite.ai/issn-tallies" # base url
    url = base_url * "?issn=" * issn # append issn to base url

    if occursin(r"^\d{4}-\d{3}[\dxX]", issn)
        try
            response = HTTP.get(url) # make the API request
            issn_tallies = JSON.parse(String(response.body)) # parse the JSON response
            df = DataFrame(issn_tallies) # store the JSON response in a DataFrame
            select!(df, Cols(contains("journal")), Cols(contains("issn")), Cols(contains("Cites")), :) # select the variables in a specific order (for preference only)
        catch e # catch any errors and print them
            println(e)
        end
    else
        throw(DomainError("Invalid ISSN", "Please enter only ISSNs of the format dddd-dddX"))
    end
end

function chunks(X::AbstractVector, n::Int)
    collect(partition(X,n)) # partition a vector X into chunks of size n
end

function scite(issns::Vector{String})
    issns = strip.(filter!(x -> occursin(r"^\d{4}-\d{3}[\dxX]", x), issns)) # filter issns to only those that match the regex
    df = DataFrame()
    issn_chunks = chunks(issns, 500) # only 500 issns per request are allowed
    println(issn_chunks)
    for issn_chunk in issn_chunks # loop through each chunk of issns, max 500 at a time
        issn_chunk = join(issn_chunk, ",") # join the issns in the chunk with a comma
        try 
            results = scite(issn_chunk) # get the results
            append!(df, scite(issn_chunk)) # append the results of the API request to the DataFrame
        catch e # catch errors
            e
        end
    end
    df # return the DataFrame
end
