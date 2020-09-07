Skeleton of a thesis manuscript, greatly inspired by the ones of Clément Mommessin and Millian Poquet, which in turn are inspired by Raphaël Bleuse, David Beniamine and David Glesser.

The makefile provides convenient recipes to build the whole thesis or unique chapters, to check for missing refs, unreferenced labels or uncited references.
Feel free to hack the template however you like.


To build your own thesis you can use the provided Nix environment, or do it by yourself with:
  - `(GNU)make` (for the Makefile)
  - `texlive` (the full one is provided by Nix, just to be safe)
  - `rubber` (a nice latex tool to compile your document and the bibliography as many times as needed)
  - `python` (if you want to use the missing references script).


This template contains only the introduction and conclusion chapter.
To add a new chapter you'll need to:
  - Add a `.tex` file corresponding to your chapter (obviously)
  - Add an include line in `thesis.tex` (around lines 190)
  - Add a macro definition in `macros.include.default.tex`
  - Add a recipe for this chapter in the `Makefile`


If you have subfolders in the `fig`, `img` or `inputs` folders, don't forget to add a line for them at the beginning of `thesis.tex` (lines 3-6) so that Rubber can find the figures there.
