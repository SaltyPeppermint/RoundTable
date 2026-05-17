// Number of cards to print. Each card: GoA list on front, number on back.
#let n_cards = 30

#set page(size: "A5", margin: (x: 1.3cm, y: 1.2cm))
#set text(lang: "de", size: 9pt)

// -- GoA items from § Anträge zur Geschäftsordnung --------------------------
#let goa_items = (
  ("Änderung der beschlossenen Tagesordnung",
   "(umfasst nicht die nachträgliche Aufnahme fristversäumter Anträge)"),
  ("Beschränkung der Redezeit", none),
  ("Schließung der Redeliste", none),
  ("Schluss der Debatte, ggf. sofortige Beschlussfassung", none),
  ("Wiederaufnahme der Debatte", none),
  ("Nichtbehandlung eines Antrags", none),
  ("Vertagung eines Punktes der Tagesordnung", none),
  ("Verweisung in eine Arbeitsgruppe oder Branch des xHain", none),
  ("Fünfminütige Sitzungspause", "(maximal zwei pro Sitzung)"),
  ("Ausschluss der Öffentlichkeit", none),
  ("Feststellung der Beschlussfähigkeit", "¹"),
  ("Schluss der Sitzung", none),
  ("Konstruktive Ablösung oder Abwahl der Sitzungsleitung", none),
  ("Einrichtung einer FLINTA*-Redeliste für den aktuellen TOP", none),
)

// -- GoA side ---------------------------------------------------------------
#let goa_page() = {
  // Header
  align(center)[
    #text(size: 14pt, weight: "bold")[Anträge zur Geschäftsordnung]
    #v(2pt)
    #text(size: 8.5pt, style: "italic")[xHain Round Table]
  ]
  v(6pt)
  line(length: 100%, stroke: 0.5pt)
  v(7pt)

  // List
  grid(
    columns: (1.4em, 1fr),
    row-gutter: 5pt,
    column-gutter: 3pt,
    ..goa_items.enumerate().map(((i, item)) => {
      let (title, note) = item
      (
        text(weight: "bold")[#(i + 1).],
        if note == none {
          text(title)
        } else if note == "¹" {
          [#title #super[1]]
        } else {
          [#title \ #text(size: 7.5pt, style: "italic")[#note]]
        },
      )
    }).flatten()
  )

  v(1fr)
  line(length: 100%, stroke: 0.5pt)
  v(4pt)
  grid(
    columns: (1fr, 1fr),
    align(left)[
      #text(size: 7pt, fill: luma(100))[
        #super[1] Keine Gegenrede; gilt mit Antragstellung als angenommen.
      ]
    ],
    align(right)[
      #text(size: 7pt, fill: luma(100))[Anzeigen: beide Hände heben]
    ],
  )
}

// -- Number side ------------------------------------------------------------
#let number_page(n) = {
  align(center + horizon)[
    #text(size: 8.5pt, style: "italic")[xHain Round Table · Stimmkarte]
    #v(8pt)
    #text(size: 100pt, weight: "bold")[#n]
  ]
}

// -- Render all cards (alternating GoA / number pages for duplex printing) --
#for i in range(1, n_cards + 1) {
  goa_page()
  pagebreak()
  number_page(i)
  if i < n_cards { pagebreak() }
}
