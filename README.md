# EU Climate Policy Explorer

An open, non-commercial resource that explains and visualises EU climate policy: the Emissions
Trading System and its sub-systems, CBAM, effort sharing, indirect cost compensation, and a map of
how the legislation fits together.

**Live site:** https://ets-overview.github.io/free-allocation-benchmarks/

It exists because EU climate law is written on the assumption that you already know the rest of it.
Directives amend directives, implementing regulations set the numbers that actually bind, and the
figure a rule produces usually sits several documents away from the rule itself. These pages try to
put the two next to each other, in plain language and from the legal text.

## What is here

| Page | Covers |
| --- | --- |
| `index.html` | Entry point and orientation |
| `ets.html` | The EU ETS: cap, Market Stability Reserve, outcomes since 2005, auction revenue, allowance price, scope changes |
| `benchmarks.html` | All 54 free allocation benchmarks across three periods, the Article 10a(2) derivation of each value, the CBAM overlay, an installation-level calculator |
| `ets2.html` | EU ETS 2 — fuels for buildings, road transport and small industry, pricing from 2028 |
| `maritime.html` | Shipping in the ETS since 2024, FuelEU Maritime, the IMO Net-Zero Framework |
| `aviation.html` | Aviation in the ETS, CORSIA, the non-CO₂ effects nobody prices |
| `cbam.html` | The Carbon Border Adjustment Mechanism: scope, calendar, default values, cost calculator |
| `indirect-costs.html` | Compensation for indirect carbon costs — the third leakage instrument |
| `effort-sharing.html` | The Effort Sharing Regulation: 27 national targets and five flexibilities |
| `legislation.html` | Interactive map of 107 acts, their amendment chains and current status |
| `changelog.html` | What changed on this site and when |

## Scope, and what is deliberately left out

The site covers legislation that addresses climate change as a **primary** objective. Energy law
overlaps heavily with climate policy and mostly sits outside the map; adaptation is included only
where it is carried by binding law rather than by a Commission communication. The starting points
are admittedly somewhat arbitrary — for carbon pricing the timeline begins with the ETS, for other
areas with a selected act. The reasoning behind each judgement call is set out on the page it
affects rather than hidden here.

Proposals in negotiation are shown as proposals, clearly separated from the law in force. Where a
chart projects beyond current law, the projection is drawn as a dashed line and labelled.

## Sources

- **Legal texts** — EUR-Lex and the Official Journal. Every act on the site links to its own text.
- **Emissions** — European Environment Agency EU ETS data viewer.
- **Free allocation, compliance and ETS 2 reported emissions** — EU Union Registry daily extracts.
- **Auction revenue and its use** — EEA indicator on the use of ETS auctioning revenue.
- **Allowance price** — ICAP Allowance Price Explorer.
- **Indirect cost compensation** — successive Commission reports on the functioning of the European
  carbon market.
- **CBAM default values** — the implementing regulation's Annex I, as corrected.

Sourcing works at two levels, and the distinction matters: **acts** are sourced individually, while
**figures** are sourced at dataset level. Each page's "data and caveats" tab names the release, the
extract date and the field used, rather than footnoting every number. Where a figure is a judgement
or a reading of an ambiguous provision, the page says so.

## Getting the data out

Every chart has a download button underneath it that exports the plotted series as CSV, reflecting
whatever series toggles are currently set. The legislation map exports all 107 acts with their
relations, status and EUR-Lex links. These are the series as drawn — grouped and rounded — not the
source datasets; for those, go to the source named in the caveats tab.

## Update policy

EU climate legislation moves monthly. Rather than one site-wide review date, **every page carries
its own last-updated date**, and `changelog.html` records what changed, when, and whether the change
was a correction or an update. If you cited something from this site, the changelog is where you
check whether it still says what it said.

Corrections are the most useful thing anyone can send. If something here is wrong, please say so.

## Technical notes

Plain static HTML, one self-contained file per page, no build step and no framework. Charts use
[Chart.js](https://www.chartjs.org/) from a CDN; everything else — styles, data, interaction — is
inline in the page it belongs to. Deployed with GitHub Pages from the default branch.

To work on it locally, clone and open any page in a browser, or serve the folder:

```
python3 -m http.server 8000
```

Tabs are addressable: `ets.html#price`, `cbam.html#calc`, `benchmarks.html#table` open that tab
directly, and the address bar follows whichever tab you are on.

## Contributing

Corrections, missing legislation and factual disputes are all welcome at
**eu-climate-overview@pm.me**, or as an issue or pull request. For a correction it helps enormously
to include the source — an OJ citation or a link to the consolidated text — since almost every
disagreement about these numbers turns out to be a disagreement about which version of a document
is being read.

## Disclaimer

Orientation, not legal advice. The visualisations simplify: they group, round and summarise. Before
relying on anything here for compliance, filings or contracts, check the consolidated text on
[EUR-Lex](https://eur-lex.europa.eu/). Several of the acts shown are under active revision.

## Licence

Content and code are released under [CC BY 4.0](LICENSE) — use it, adapt it, build on it, with
attribution. This is an independent project and is not affiliated with, endorsed by, or speaking
for the European Commission or any EU institution.
