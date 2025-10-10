set -ex
touch "full.md"
cat header.md > "full.md"
cat haskell.md >> "full.md"
cat lambda.md >> "full.md"
cat types.md >> "full.md"
cat curry_howard.md >> "full.md"
cat unifikation.md >> "full.md"
cat parallel_processing.md >> "full.md"
cat java.md >> "full.md"
cat compiler.md >> "full.md"

pandoc full.md -o full.pdf --toc
