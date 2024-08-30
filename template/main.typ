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
- More text
  - This is pretty small, you may want to change it

= Another Section

== Another Subsection

- Some text
- More text
  - This is pretty small, you may want to change it

= Another Section 2

= Another Section 3

= Another Section 4

= Another Section 5

= Another Section 6

= Another Section 7
