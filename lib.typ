#import "@preview/touying:0.4.2": *

#let show-copyright = state("show-copyright", false)

#let figure-with-copyright(copyright: none, caption: none, ..args) = {
  figure(caption: context [
    #if show-copyright.get() {
      copyright
    } else {
      caption
    }
  ], ..args)
}

#let header-font(..args) = {
  text(font: "roboto", fallback: false, weight: "black", tracking: 2pt, size: 10pt, ..args)
}

#let footer-font(..args) = {
  text(font: "roboto", fallback: false, fill: rgb("#898989"), size: 9pt, ..args)
}

#let title-font(..args) = {
  set par(leading: 0.1in)
  set text(font: "roboto", fallback: false, weight: "black", size: 42pt)
  text(..args)
}

#let subtitle-font(..args) = {
  text(font: "roboto", fallback: false, size: 22pt, ..args)
}

#let slide(self: none, title: none, ..args) = {
  (self.methods.touying-slide)(self: self, title: title, setting: body => {
    block(
      height: 1.99in - self.page-args.margin.top,
      below: 0.24in,
      width: 100% - 2in,
      align(bottom)[#heading(level: 2, upper(title))]
    )
    body
  }, ..args)
}

#let title-slide(self: none, ..args) = {
  self.enable-header = false
  let info = self.info + args.named()
  (self.methods.touying-slide)(self: self, repeat: none, setting: body => {
    grid(
      columns: 100%,
      rows: (
        2.76in - self.page-args.margin.top,
        1.18in,
        1.6in
      ),
      gutter: (0in, 0.2in),
      grid.cell([]),
      grid.cell(align: bottom + center, title-font(upper(info.title))),
      grid.cell(align: top + center, subtitle-font(info.subtitle)),
    )
    body
  }, ..args)
}

#let new-section-slide(self: none, section, ..args) = {
  (self.methods.touying-slide)(self: self, repeat: none, section: section, setting: body => {
    grid(
      columns: 100%,
      rows: (
        4.32in - self.page-args.margin.top,
        1.18in,
        1.18in
      ),
      gutter: (0in, 0.05in),
      grid.cell([]),
      grid.cell(align: bottom, heading(level: 2, upper(states.current-section-with-numbering(self)))),
      grid.cell(align: top, subtitle-font([]))
    )
    body
  }, ..args)
}

#let outline-slide(self: none, leading: 50pt) = {
  (self.methods.slide)(self: self, repeat: none, title: "Contents", (self.methods.touying-outline)(self: self))
}

#let d-outline(self: none, enum-args: (:), list-args: (:), cover: true) = states.touying-progress-with-sections(dict => {
  let (current-sections, final-sections) = dict
  current-sections = current-sections.filter(section => section.loc != none)
  final-sections = final-sections.filter(section => section.loc != none)
  let current-index = current-sections.len() - 1
  set enum(..enum-args)
  set enum(numbering: n => title-font[#n], spacing: 0.22in, body-indent: 0.25in)
  show enum : set align(horizon)
  v(2.91in-1.18in-self.page-args.margin.top)
  columns(2,
    for (i, section) in final-sections.enumerate() {
    {
        enum.item(i + 1, [#link(section.loc, section.title)<touying-link>])
      }
      parbreak()
  })
})

#let slides(self: none, title-slide: true, outline-slide: true, slide-level: 1, ..args) = {
  if title-slide {
    (self.methods.title-slide)(self: self)
  }
  if outline-slide {
    (self.methods.outline-slide)(self: self)
  }
  (self.methods.touying-slides)(self: self, slide-level: slide-level, ..args)
}

#let register(
  self: themes.default.register(),
  tuda_logo,
  ..args,
) = {
  self = (self.methods.datetime-format)(self: self, "[day].[month].[year]")
  self.enable-header = true
  let header = self => align(top)[
    #if self.enable-header {
      v(0.39in)
      header-font(upper(self.info.short-title + " / " + self.info.short-author))
    }
    #place(top + right, dx: 0.34in, dy: 0.2in)[#image.decode(tuda_logo, height: 0.99in)]
  ]
  let footer(self) = grid(
    rows: 0.125in,
    columns: (15%, 1fr, 15%),
    align: (bottom + left, bottom + center, bottom + right),
    footer-font(utils.info-date(self)),
    footer-font(self.info.department + " | " + self.info.institute + " | " + self.info.short-author),
    footer-font(states.slide-counter.display()),
  )
  self.page-args += (
    width: 13.33in,
    height: 7.5in,
    fill: self.colors.neutral-lightest,
    header: header,
    footer: footer,
    footer-descent: 0in,
    header-ascent: 0in,
    margin: (
      left: 0.39in,
      right: 0.34in,
      top: 1.2in,
      bottom: 0.33in
    ),
  )
  self.full-header = false
  self.full-footer = false
  self.methods.slide = slide
  self.methods.focus-slide = self.methods.touying-slide
  self.methods.title-slide = title-slide
  self.methods.outline-slide = outline-slide
  self.methods.touying-outline = d-outline
  self.methods.new-section-slide = new-section-slide
  self.methods.touying-new-section-slide = new-section-slide
  self.methods.slides = slides
  self.methods.init = (self: none, body) => {
    set document(title: self.info.title + " " + self.info.subtitle, author: self.info.author, date: self.info.date)
    set heading(outlined: false)
    set text(font: "roboto", fallback: false, size: 20pt)
    show heading.where(
      level: 1
    ): set text(font: "roboto", fallback: false, weight: "black", bottom-edge: "descender", size: 42pt)
    show heading.where(
      level: 2
    ): set text(font: "roboto", fallback: false, weight: "black", bottom-edge: "descender", size: 42pt)
    show heading.where(
      level: 2
    ): set par(leading: 0.1in)
    body
  }
  self
}