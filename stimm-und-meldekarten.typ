// Number of cards to print. Each card: GoA list on front, number on back.
#let n_cards = 30

#set page("a5", margin: (x: 1cm, y: 1cm))
#set text(lang: "de", size: 10pt, font: "Inter")

// -- GoA items from § Anträge zur Geschäftsordnung --------------------------
// Each entry: ((DE title, EN title), (DE note, EN note) or none)
#let goa_items = (
  (
    ("Änderung der beschlossenen Tagesordnung", "Amendment of the adopted agenda"),
    (
      "(umfasst nicht die nachträgliche Aufnahme fristversäumter Anträge)",
      "(excl. subsequent addition of motions past the submission deadline)",
    ),
  ),
  (("Beschränkung der Redezeit", "Limitation of speaking time"), none),
  (("Schließung der Redeliste", "Closure of the speakers list"), none),
  (("Schluss der Debatte, ggf. sofortige Beschlussfassung", "Closure of debate, possibly with immediate vote"), none),
  (("Wiederaufnahme der Debatte", "Reopening of debate"), none),
  (("Nichtbehandlung eines Antrags", "Non-consideration of a motion"), none),
  (("Vertagung eines Punktes der Tagesordnung", "Deferral of an agenda item"), none),
  (
    ("Verweisung in eine Arbeitsgruppe oder Branch des xHain", "Referral to a working group or branch of the xHain"),
    none,
  ),
  (
    ("Fünfminütige Sitzungspause", "Five-minute session recess"),
    ("(maximal zwei pro Sitzung)", "(maximum two per session)"),
  ),
  (("Ausschluss der Öffentlichkeit", "Exclusion of the public"), none),
  (
    ("Feststellung der Beschlussfähigkeit", "Establishment of quorum"),
    ("(Keine Gegenrede möglich)", "(No counter-speech allowed)"),
  ),
  (("Schluss der Sitzung", "Closure of the session"), none),
  (
    (
      "Konstruktive Ablösung oder Abwahl der Sitzungsleitung",
      "Constructive vote of no confidence in or removal of the session chair",
    ),
    none,
  ),
  (
    (
      "Einrichtung einer FLINTA*-Redeliste für den aktuellen Tagesordnungspunkt",
      "Establishment of a FLINTA*-speakers list for the current agenda item",
    ),
    none,
  ),
)

// -- Shared card header -----------------------------------------------------
#let card_header(de, en) = {
  text(size: 12pt, weight: "bold")[#de\ ]
  text(size: 12pt, weight: "bold", fill: luma(100))[#en]
  parbreak()
  text(style: "italic")[xHain Round Table]
  parbreak()
  line(length: 100%, stroke: 0.5pt)
}

// -- Shared card footer -----------------------------------------------------
#let card_footer(de, en) = {
  line(length: 100%, stroke: 0.5pt)
  align(center)[
    #text(size: 8pt)[#de]
    #text(size: 8pt, fill: luma(50))[#sym.dot.c]
    #text(size: 8pt, fill: luma(100))[#en]
  ]
}

// -- Render one numbered grid row (number cell + bilingual content cell) -----
#let goa_row(i, item) = {
  let ((de_title, en_title), notes) = item
  let de_block = if notes == none { de_title } else {
    [#de_title #text(style: "italic")[#notes.at(0)]]
  }
  let en_block = if notes == none { en_title } else {
    [#en_title #text(style: "italic")[#notes.at(1)]]
  }
  (
    text(weight: "bold")[#(i + 1).],
    [#de_block \ #text(fill: luma(100))[#en_block]],
  )
}

// -- GoA side ---------------------------------------------------------------
#let goa_page() = {
  align(center)[#card_header("Anträge zur Geschäftsordnung", "Procedural Motions")]
  grid(
    columns: (1.5em, 1fr),
    row-gutter: 8pt,
    column-gutter: 2pt,
    ..goa_items
      .enumerate()
      .map(((i, item)) => {
        goa_row(i, item)
      })
      .flatten()
  )
  parbreak()
  card_footer(
    [Geschäftsordnungsantrag: #underline[Beide] Hände heben],
    [Procedural Motion: Raise #underline[both] hands],
  )
}

// -- Number side ------------------------------------------------------------
#let number_page(n) = {
  place(top + center)[#card_header("Stimm- und Meldekarte", "Voting and Speaker's Card")]
  align(center + horizon)[
    #text(size: 300pt, weight: "bold")[#n]
  ]
  place(bottom)[#card_footer(
    [Abstimmen/Melden: #underline[Eine] Hand heben],
    [Vote/Signal: Raise #underline[one] hand],
  )]
}

// -- Render all cards (alternating GoA / number pages for duplex printing) --
#for i in range(1, n_cards + 1) {
  number_page(i)
  pagebreak()
  goa_page()
  if i < n_cards { pagebreak() }
}
