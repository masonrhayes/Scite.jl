# Scite.jl

## **Note: This package uses the Scite API but is not endorsed, certified or otherwise approved in any way by Scite™**
Julia package to gather journal citation data from [scite](https://scite.ai/).

For information about scite and the data it provides, see here: https://help.scite.ai/.

The `scite()` function takes either an [ISSN](https://www.issn.org/understanding-the-issn/what-is-an-issn/), or vector of ISSNs, and returns a DataFrame containing the variables:
- journal (e.g, "Journal of Biological Chemistry")
- journalSlug (e.g., "journal-of-biological-chemistry-MVW30")
- issns (all ISSNs of the journal, e.g., `["0021-9258", "1083-351X"]`)
- totalContradictingCites, an Integer
- totalCites, an Integer
- totalMentioningCites, an Integer
- totalUnclassifiedCites, an Integer
- totalSupportingCites, an Integer


If you only want to search for a few journals, you can do this on scite's website, here: https://scite.ai/journals/.
