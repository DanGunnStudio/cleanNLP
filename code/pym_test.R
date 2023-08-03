#installing packages
library(tidyverse)
library(cleanNLP)
library(reticulate)
py_config()
use_python("/Users/danhome/Documents/r_projects/cleanNLP/.venv/bin/python")
py_config()
py_discover_config()
#importing Arthur Gordon Pym of Nantucket text from Project Gutenberg
pym_full_raw <- read_delim("https://www.gutenberg.org/cache/epub/51060/pg51060.txt", delim = "\t")


#turning it into a character vector.
pym_full_flat <- str_flatten(deframe(pym_full_raw), collapse = " ") 

#strip out before the title
pym_full <- pym_full_flat %>% str_split_i(., "THE NARRATIVE OF ARTHUR GORDON PYM. OF NANTUCKET.",2) 

#strip out the ending after "THE END."
pym_full <- pym_full %>% str_split_i("THE END.",1)
str(pym_full)

#break up the full text into chapters.
str_count(pym_full, "CHAPTER") #24 chapters not including the preface
pym_chapters <- str_split_1(pym_full, "CHAPTER")
str(pym_chapters) #is a character vector of each chapter. 

#just a small excerpt
pym_excerpt <- "Augustus Barnard thoroughly entered into my state of mind. It is probable, indeed, that our intimate communion, Augustus and mine, had resulted in a partial interchange of character. About eighteen months after the period of the Ariel's disaster, the firm of Lloyd and Vredenburgh (a house connected in some manner with the Messieurs Enderby, I believe, of Liverpool) were engaged in repairing and fitting out the brig Grampus of Philadelphia for a whaling voyage."


#trying out the cleanNLP spacy integration
reticulate::py_discover_config(required_module = "cleannlp")
#
cnlp_download_spacy(model_name = "en_core_web_sm" )
cnlp_init_spacy(model_name = "en")
pym_spacy <- cnlp_annotate(pym_excerpt)


