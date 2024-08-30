# not-tudabeamer-2023

A [touying](https://github.com/touying-typ/touying) presentation template matching the TU Darmstadt Beamer Template 2023.

## Usage

Install Roboto font for your system.

Download https://download.hrz.tu-darmstadt.de/protected/ULB/tuda_logo.pdf and convert it to `.svg` using e.g. Inkscape.

Run `typst init @preview/not-tudabeamer-2023:0.1.0`

### Examples

```typst
#import "@preview/touying:0.4.2": utils
#import "@preview/not-tudabeamer-2023:0.1.0": register

#let tuda_logo = read("tuda_logo.svg")

#let s = register(tuda_logo)

#let s = (s.methods.info)(
  self: s,
  title: [Title],
  short-title: [Title],
  subtitle: [Subtitle],
  short-subtitle: [Subtitle],
  author: "Author",
  short-author: "Author",
  date: datetime.today(),
  department: [Department],
  institute: [Institute],
)

#let (init, slides, speaker-note) = utils.methods(s)
#show: init

#let (slide, title-slide) = utils.slides(s)
#show: slides.with(outline-slide: true)

= Section

== Subsection

- Some text
```

## Development

```
mkdir -p ~/.cache/typst/packages/preview/not-tudabeamer-2023
ln -s $PWD ~/.cache/typst/packages/preview/not-tudabeamer-2023/0.1.0
```