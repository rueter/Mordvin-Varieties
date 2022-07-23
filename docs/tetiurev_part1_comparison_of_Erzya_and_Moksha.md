# Comparing parallel Erzya and Moksha corpus of Tetiurev

The idea of building parallel corpora for minority Finno-Ugric languages spoken in the former Soviet Union has become prominent due to the Kindred Language Digitization project conducted at the National Library of Finland.

This parallel corpus is based on the Erzya- and Moksha-language translations of a school reader written in Russian by V.A. Tetûrev. Estestvoznanie, častʹ I učebnik dlâ tretʹego klassa načalʹnoj školy.
The Erzya version 1939: Estestvoznaniâ vasence pelʹks, načalʹnoj školanʹ kolmoce klasso tonavtnema kniga (2nd edition), (translated: A. Tâguševa).
The Moksha version 1940: Estestvoznaniâ, vasence pâlʹkssʹ, načalʹnaj školanʹ 3-ce klassa tonafnema kniga (4th edition), (translator, not given).

Moksha tokens 22991, missing tokens 710
Erzya tokens 22609, missing tokens 255

While Erzya distinguishes Prt2 from Conj morphologically, their cognates in Moksha are morphologically ambiguous.
Since the cognates
Investigate myv Prt2 and its equivalent in mdf
myv Conj and its equivalent in mdf
mdf Conj and its equivalent myv, which at time is Opt

There are twelve instances where the Erzya second preterite is matched with Moksha use of a continuative derivation in the first past.

There are two instance where the Erzya second preterite is matched with Moksha second preterite.

Out of 25 instances of conjunctive readings in Moksha, 20 include the subjunction ‹штоба›.
The remaining five instances 

## Moksha conjunctive disambiguation

The ambiguity of conjunctive mood versus second preterite indicative is seldom a problem in Moksha. There is contextual evidence that can be used for this disambiguation:


There are a number of ambiguous nouns in Moksha:
‹сталь› can be either 'steel' or a verbal form of ‹стамс› 'to sew'.
‹уле› 'grey' ‹улемс› 'to be'
‹пиле› 'ear' ‹пимс› 'to cook v.i.'

Contextual indicators
‹ба› ‹штоба›

## Erzya conjunctive disambiguation

Passive versus non-passive ambiguity is a general problem in the orthography which allows syncope in stings ‹-воволь-› and ‹-вевель-›

‹теевель› can be either a conjunctive form of the verb ‹теевемс› 'to be/get made' or the verb ‹теемс› 'to make'

‹аволямс› vs ‹а: аволинек›

‹аволь› Neg Emphatic vs ‹а: аволь› Conj
A subsequent ConNeg can be used to remove the ‹Emphatic› reading, whereas the absence of ConNeg removes the Conj reading.

Both Erzya and Moksha use the Russian question particle ‹ли›, which regularly invokes a subsequent conjunctional reading.

Similar contextual disambiguation are found in the subjuction ‹штобу› (Erzya) and ‹штоба› (Moksha).


```
cat myv_Tetiurev_1-peljks_1939_bx000010893-83.conllu-prep|grep '#'|perl -wpne 's/(\#\ text\ \=\ *)(\{[^\n]*\}\[[^]\n]*\]|\{[^\n]*\}|\[[^]\n]*\])/\#\ comment\ \=\ $2\n$1/g; s/(\#\ comment\ \=\ [^\n]*)\{/$1YQB/g; s/(\#\ comment\ \=\ [^\n]*)\}/$1YQE/g; s/(\#\ comment\ \=\ [^\n]*)\[/$1ZQB/g; s/(\#\ comment\ \=\ [^\n]*)\]/$1ZQE/g;  s/(\#[^\n]*)/\[$1\]/g; s/(\#\ text\ \=\ )([^\n]*)(\])/$1$2$3\ $2/g;'| hfst-tokenise -S -g --giella-cg -W $GIELLA_HOME/lang-myv/tools/tokenisers/tokeniser-disamb-gt-desc.pmhfst | vislcg3 -g $GIELLA_HOME/lang-myv/src/cg3/disambiguator.cg3 |vislcg3  -g ../../../../Gitlab/mormula-cg/22_Erzya.cg3 | vislcg3  -g ../../../../Github/giellalt/lang-sms/src/cg3/dependency.cg3 | ../../../../Gitlab/clean_newline_and_colons_from_cg_output.pl |perl -wpne 's/(\[\#\ text)(\ \=\ [^\n]*)/$1_orig$2\n$1$2/g; s/\n\[/\n/g; s/\]\n/\n/g; s/^\[//g;' > output-myv
```

```
cat mdf_Tetiurev_1-paeljkssj_1940_bx000010890-82.conllu-prep |grep '#'|perl -wpne 's/(\#\ text\ \=\ *)(\{[^\n]*\}\[[^]\n]*\]|\{[^\n]*\}|\[[^]\n]*\])/\#\ comment\ \=\ $2\n$1/g; s/(\#\ comment\ \=\ [^\n]*)\{/$1YQB/g; s/(\#\ comment\ \=\ [^\n]*)\}/$1YQE/g; s/(\#\ comment\ \=\ [^\n]*)\[/$1ZQB/g; s/(\#\ comment\ \=\ [^\n]*)\]/$1ZQE/g;  s/(\#[^\n]*)/\[$1\]/g; s/(\#\ text\ \=\ )([^\n]*)(\])/$1$2$3\ $2/g;'| hfst-tokenise -S -g --giella-cg -W $GIELLA_HOME/lang-mdf/tools/tokenisers/tokeniser-disamb-gt-desc.pmhfst | vislcg3 -g $GIELLA_HOME/lang-mdf/src/cg3/disambiguator.cg3 |vislcg3  -g ../../../../Gitlab/mormula-cg/22_Erzya.cg3 | vislcg3  -g ../../../../Github/giellalt/lang-sms/src/cg3/dependency.cg3 | ../../../../Gitlab/clean_newline_and_colons_from_cg_output.pl |perl -wpne 's/(\[\#\ text)(\ \=\ [^\n]*)/$1_orig$2\n$1$2/g; s/\n\[/\n/g; s/\]\n/\n/g; s/^\[//g;' > output-mdf
```

# How the subjunction ‹штобу› 'in order to' used with infinitives and finites?