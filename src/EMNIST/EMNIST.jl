export MNIST

"""

##What is it?

The EMNIST dataset is a set of handwritten character digits 
derived from the NIST Special Database 19  and converted to 
a 28x28 pixel image format and dataset structure that directly 
matches the MNIST dataset . Further information on the dataset 
contents and conversion process can be found in the paper 
available at https://arxiv.org/abs/1702.05373v1.


## Formats

The dataset is provided in two file formats. Both versions of 
the dataset contain identical information, and are provided 
entirely for the sake of convenience. The first dataset is 
provided in a Matlab format that is accessible through both 
Matlab and Python (using the scipy.io.loadmat function). The 
second version of the dataset is provided in the same binary 
format as the original MNIST dataset as outlined in 
http://yann.lecun.com/exdb/mnist/

## Utilities

- [`MNIST.download`](@ref)
"""
module EMNIST
    using DataDeps
    using ColorTypes
    using Formatting
    using FixedPointNumbers
    using ..MLDatasets: bytes_to_type, datafile, download_dep, download_docstring,
                        _colorview

    export

        traintensor,
        testtensor,

        trainlabels,
        testlabels,

        traindata,
        testdata,

        # convert2image,
        # convert2features,

        download

    const DEPTYPES = Dict{Symbol, String}(:balanced=>"balanced", :byclass=>"byclass", :bymerge=>"bymerge", :digits=>"digits", :letters=>"letters", :mnist=>"mnist")
    const DEPNAME = "EMNIST"
    const TRAINIMAGES = FormatExpr("gzip/emnist-{}-train-images-idx3-ubyte.gz")
    const TRAINLABELS = FormatExpr("gzip/emnist-{}-train-labels-idx1-ubyte.gz")
    const TESTIMAGES  = FormatExpr("gzip/emnist-{}-test-images-idx3-ubyte.gz")
    const TESTLABELS  = FormatExpr("gzip/emnist-{}-test-labels-idx1-ubyte.gz")

    """
        download([dir]; [i_accept_the_terms_of_use])

    Trigger the (interactive) download of the full dataset into
    "`dir`". If no `dir` is provided the dataset will be
    downloaded into "~/.julia/datadeps/$DEPNAME".

    This function will display an interactive dialog unless
    either the keyword parameter `i_accept_the_terms_of_use` or
    the environment variable `DATADEPS_ALWAYS_ACCEPT` is set to
    `true`. Note that using the data responsibly and respecting
    copyright/terms-of-use remains your responsibility.
    """
    download(args...; kw...) = download_dep(DEPNAME, args...; kw...)

    include(joinpath("Reader","Reader.jl"))
    include("interface.jl")
    # include("utils.jl")

    function __init__()
        register(DataDep(
            DEPNAME,
            """
            Dataset: The EMNIST dataset is a set of handwritten 
            character digits derived from the NIST Special Database 19  
            and converted to a 28x28 pixel image format and dataset 
            structure that directly matches the MNIST dataset.
            Authors: Gregory Cohen, Saeed Afshar, Jonathan Tapson, and Andre van Schaik
                The MARCS Institute for Brain, Behaviour and Development
                Western Sydney University
                Penrith, Australia 2751
                Email: g.cohen@westernsydney.edu.au
            Website: https://www.nist.gov/itl/products-and-services/emnist-dataset

            Cohen, G., Afshar, S., Tapson, J., & van Schaik, A. (2017). 
            EMNIST: an extension of MNIST to handwritten letters. Retrieved 
            from http://arxiv.org/abs/1702.05373

            The files are available for download at the offical
            website linked above. Note that using the data
            responsibly and respecting copyright remains your
            responsibility. The authors of EMNIST aren't really
            explicit about any terms of use, so please read the
            website to make sure you want to download the
            dataset.
            """,
            "http://www.itl.nist.gov/iaui/vip/cs_links/EMNIST/gzip.zip",
            "fb9bb67e33772a9cc0b895e4ecf36d2cf35be8b709693c3564cea2a019fcda8e",
            post_fetch_method=unpack
        ))
    end
end
