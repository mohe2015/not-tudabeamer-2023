# not-tudabeamer-2023

A [touying](https://github.com/touying-typ/touying) presentation template matching the TU Darmstadt Beamer Template 2023.

## Usage

Install Roboto font for your system or download them from https://github.com/googlefonts/roboto/releases/download/v2.138/roboto-unhinted.zip.

Run `typst init @preview/not-tudabeamer-2023:0.1.0`

Download https://download.hrz.tu-darmstadt.de/protected/ULB/tuda_logo.pdf.

Run `pdf2svg tuda_logo.pdf tuda_logo.svg` or convert to `.svg` using e.g. Inkscape.

### Examples

```typst
#import "@preview/touying:0.5.1": utils
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

This template currently only follows the TU Darmstadt Beamer template in spirit but not pixel-perfect. As the PowerPoint template uses non-free fonts a goal of this project is to more closely match the LaTeX TU Darmstadt Beamer 2023 template. Pull requests to improve this are really welcome.

```
mkdir -p ~/.cache/typst/packages/preview/not-tudabeamer-2023
ln -s $PWD ~/.cache/typst/packages/preview/not-tudabeamer-2023/0.1.0
```