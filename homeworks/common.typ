#import "requirements.typ": *

// Fancy colors
#let accent = blue.darken(25%)
#let warn = rgb("#b45309")
#let good = rgb("#15803d")


#let template(dark: false, doc) = {
  // Dark mode
  set text(fill: white) if dark
  set page(fill: luma(12%)) if dark

  set text(12pt, lang: "ru")
  set par(justify: true)

  show emph: set text(fill: accent)
  show link: set text(fill: accent)

  // Fix emptyset symbol
  show sym.emptyset: set text(font: "Libertinus Sans")

  // Show i.e. in italic:
  show "i.e.": set text(style: "italic")
  // Show e.g. in italic:
  show "e.g.": set text(style: "italic")
   // Shot etc. in italic:
  show "etc.": set text(style: "italic")

  // Matrix setup
  set math.mat(column-gap: 1em)

  // Task headings setup: fancy line, bold, accent color
  show heading.where(level: 2): set text(
    size: 14pt,
    weight: "bold",
    fill: accent,
  )
  show heading.where(level: 2): it => block(
    width: 100%,
    above: 1.6em,
    below: 0.9em,
    sticky: true,
    inset: (bottom: 0.55em),
    stroke: (bottom: 0.8pt + accent.lighten(40%)),
    it,
  )

  doc
}

// Task list helper
#let tasklist(id, cols: 1, format: "1.", start:1, body) = {
  let s = counter(id)
  s.update(start)
  set enum(numbering: _ => context {
    s.step()
    s.display(format)
  })
  columns(cols, gutter: 1em)[#body]
}

// Horizontal rule
#let hrule = line(length: 100%)

// Blob for fletcher diagrams
#let blob(
  pos,
  label,
  tint: none,
  shape: auto,
  ..args,
) = fletcher.node(
  pos,
  align(center, label),
  fill: if (tint != none) { tint.lighten(80%) } else { auto },
  stroke: if (tint != none) { tint.darken(20%) } else { auto },
  shape: shape,
  ..args,
)

// Colored box around a content
#let fancy-box(
  tint: green,
  diagram-style: (:),
  blob-style: (:),
  content,
) = fletcher.diagram(
  node-corner-radius: 2pt,
  node-stroke: .8pt,
  ..diagram-style,
  blob(
    (0, 0),
    content,
    tint: tint,
    ..blob-style,
  ),
)

// Fancy tags to segregate tasks by their difficulty
#let Tag(label, color) = {
  set text(size: 0.8em)
  box(
    label,
    radius: 5pt,
    inset: (x: 0.4em),
    outset: (y: 0.4em),
    stroke: 0.6pt + color.darken(20%),
    fill: color.lighten(80%),
  )
}
#let TagCore = Tag("Core", green)
#let TagEssential = Tag("Essential", blue)
#let TagChallenge = Tag("Challenge", purple)
#let TagBonus = Tag("Bonus", yellow)

// Block for organizing content (grey box)
#let Block(body, ..args) = {
  block(
    body,
    inset: (x: 1em),
    stroke: (left: 3pt + gray),
    outset: (y: 3pt, left: -3pt),
    ..args,
  )
}

// Link with icon
#let href(..args) = link(..args, super(fontawesome.fa-external-link()))

// Aliases
#let neg = sym.not
#let imply = sym.arrow.r
#let implies = imply
#let iff = sym.arrow.l.r
#let to = sym.arrow.r
#let maps = sym.arrow.bar
#let neq = sym.eq.not
#let leq = sym.lt.eq
#let geq = sym.gt.eq
#let models = sym.tack.double
#let entails = sym.tack.r
#let notin = sym.in.not
#let setminus = sym.without
#let intersect = sym.inter
#let symdiff = sym.triangle
#let sim = sym.tilde
#let bmat = math.mat.with(delim: "[")
#let Bmat = math.mat.with(delim: "{")
#let vmat = math.mat.with(delim: "|")
#let Vmat = math.mat.with(delim: "||")

#import ctheorems: *

#let definition = thmbox(
  "definition",
  "Definition",
  fill: rgb("#e8f8e8"),
  inset: 0.8em,
  padding: (),
  base_level: 0,
)
#let theorem = thmbox(
  "theorem",
  "Theorem",
  fill: rgb("e8e8f8"),
  inset: 0.8em,
  padding: (),
  base_level: 0,
)
#let corollary = thmbox(
  "corollary",
  "Corollary",
  base: "theorem",
  fill: rgb("f8e8e8"),
  inset: 0.8em,
  padding: (),
)
#let proof = thmproof(
  "proof",
  "Proof",
  inset: (x: 0em, y: 0em),
  titlefmt: it => strong(it),
)
#let example = thmplain(
  "example",
  "Example",
  inset: (x: 0em, y: 0em),
  titlefmt: it => text(style: "italic", it),
).with(numbering: none)
#let examples = example.with(title: "Examples")
#let note = thmplain(
  "note",
  "Note",
  inset: (x: 0em, y: 0em),
  titlefmt: it => strong(it),
).with(numbering: none)
