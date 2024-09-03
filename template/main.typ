#import "@preview/not-tudabeamer-2023:0.1.0": *

#let tuda_logo = read("tuda_logo.svg")

#show: not-tudabeamer-2023-theme.with(
  config-info(
    title: [Title],
    short-title: [Title],
    subtitle: [Subtitle],
    short-subtitle: [Subtitle],
    author: "Author",
    short-author: "Author",
    date: datetime.today(),
    department: [Department],
    institute: [Institute],
    logo: tuda_logo
  )
)

#title-slide()

= Section

#new-section-slide("Test")

== Subsection

- Some text
- More text
  - This is pretty small, you may want to change it
    - nested
      - bullet
        - points

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
