using Scite
using Test

@testset "Scite.jl" begin
    @test typeof(Scite.scite("0000-0000")) == DataFrame


    @test typeof(Scite.scite(["abc", "0028-0836"])) == DataFrame # test that the function returns data for the valid ISSNs, even if a non-valid ISSN is passed.


    @test_throws "Invalid ISSN" Scite.scite("abc")  # test that the function returns an error for an invalid ISSN
end