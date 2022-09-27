set -ex
touch "full.md"
cat header.md > "full.md"
cat haskell.md >> "full.md"
cat lambda.md >> "full.md"
cat types.md >> "full.md"
cat prolog.md >> "full.md"
cat unifikation.md >> "full.md"
cat parallel_processing.md >> "full.md"

pandoc full.md -o full.pdf
