// Number of cards to print. Each card: GoA list on front, number on back.
#let n_cards = 30

#set page("a5", margin: (x: 1.2cm, y: 1.2cm))
#set text(lang: "de", size: 12pt, font: "Inter")

// -- GoA items from § Anträge zur Geschäftsordnung --------------------------
#let goa_items = (
  ("Änderung der beschlossenen Tagesordnung", "(umfasst nicht die nachträgliche Aufnahme fristversäumter Anträge)"),
  ("Beschränkung der Redezeit", none),
  ("Schließung der Redeliste", none),
  ("Schluss der Debatte, ggf. sofortige Beschlussfassung", none),
  ("Wiederaufnahme der Debatte", none),
  ("Nichtbehandlung eines Antrags", none),
  ("Vertagung eines Punktes der Tagesordnung", none),
  ("Verweisung in eine Arbeitsgruppe oder Branch des xHain", none),
  ("Fünfminütige Sitzungspause", "(maximal zwei pro Sitzung)"),
  ("Ausschluss der Öffentlichkeit", none),
  ("Feststellung der Beschlussfähigkeit", "(Keine Gegenrede; gilt mit Antragstellung als angenommen.)"),
  ("Schluss der Sitzung", none),
  ("Konstruktive Ablösung oder Abwahl der Sitzungsleitung", none),
  ("Einrichtung einer FLINTA*-Redeliste für den aktuellen Tagesordnungspunkt", none),
)

// -- Shared card header -----------------------------------------------------
#let card_header(title) = {
  text(size: 14pt, weight: "bold")[#title]
  v(2pt)
  text(size: 10pt, style: "italic")[xHain Round Table]
  v(6pt)
  line(length: 100%, stroke: 0.5pt)
  v(6pt)
}

// -- Shared card footer -----------------------------------------------------
#let card_footer(label) = {
  line(length: 100%, stroke: 0.5pt)
  align(center)[#text(size: 7pt, fill: luma(100))[#label]]
}

// -- GoA side ---------------------------------------------------------------
#let goa_page() = {
  align(center)[#card_header[Anträge zur Geschäftsordnung]]
  // List
  grid(
    columns: (1.5em, 1fr),
    row-gutter: 10pt,
    column-gutter: 2pt,
    ..goa_items
      .enumerate()
      .map(((i, item)) => {
        let (title, note) = item
        (
          text(weight: "bold")[#(i + 1).],
          if note == none { text(title) } else { [#title \ #text(size: 10pt, style: "italic")[#note]] },
        )
      })
      .flatten()
  )
  v(1fr)
  card_footer[Melden: Beide Hände heben]
}

// -- Number side ------------------------------------------------------------
#let number_page(n) = {
  place(top + center)[#card_header[Stimmkarte]]
  place(bottom)[#card_footer[Melden: Eine Hand heben]]
  align(center + horizon)[
    #text(size: 300pt, weight: "bold")[#n]
  ]
}

// -- Render all cards (alternating GoA / number pages for duplex printing) --
#for i in range(1, n_cards + 1) {
  goa_page()
  pagebreak()
  number_page(i)
  if i < n_cards { pagebreak() }
}
