# xHain Round Table

This repository contains:

- [Geschäftsordnung xHain Round Table.md](Geschäftsordnung%20xHain%20Round%20Table.md): The standing orders of the xHain Round Table
- [stimmkarten.typ](stimmkarten.typ): Typst source for voting cards

## Geschäftsordnung

TODO: Short summary and english translation (both nonbinding)

## Voting Cards

The voting cards have the Geschäftsordnungsanträge on one side and a unique
card number on the other.

### Building

```sh
nix run .#build   # compiles stimmkarten.pdf into the current directory
nix run .#watch   # recompiles automatically on file changes
```

### Configuration

The number of cards is set at the top of `stimmkarten.typ`:

```typst
#let n_cards = 30
```

### Printing

The PDF alternates between GoA side and number side (page 1 = GoA, page 2 = 1,
page 3 = GoA, page 4 = 2, ...), so duplex printing works in a single pass.
Print double-sided, then cut the pages to size.
