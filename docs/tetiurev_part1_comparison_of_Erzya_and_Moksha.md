# Comparing parallel Erzya and Moksha corpus of Tetiurev

In this investigation of Erzya and Moksha, a parallel corpus was made on the basis of a single natural history reader written for schools of the Soviet Union by V.A. Tetûrev in the 1930s and subsequently translated separately into Erzya and Moksha. The sentences were aligned and both translations were morphologically analyzed, so as to facilitate queries for both languages.

As this is but a small increment in research of how well the two languages can be aligned, we set out to observe contrasts in directionality with regard to the indicative second preterite and the conjunctive. Although both the second preterite and the conjunctive are expressed by a singular paradigm in Moksha, Erzya has two distinct morphological paradigms for the two.

Although both languages had instances of the second preterite, a large portion of the Erzya second preterite forms were aligned with frequentative derivations of equivalent Moksha verbs in the first preterite. In fact, there was only one sentence where where both languages used the second preterite verb form.

the two languages with
 The first research question addressed the Moksha identical morphology for the indicative second preterite and conjunctive, whereas these two are distinct in Erzya.

, but soon found that distinctions might originate in actual linguistic diversity,on the one hand, and the writing style of the individual translator. 

Thus, the original research question behind this parallel corpus development, associated with the second preterite in Erzya and Moksha, was only the beginning of our learning process. Both languages have a second preterite, but Erzya morphologically distinguishes the second preterite from the conjunctive (aka subjunctive), while Moksha does not.
We found a correlation between Erzya second preterite and what might be Moksha habitual first preterite. There were also correlations between the Erzya and Moksha

## Background 

XXX we are interested in shallow-transfer machine translation, 


The idea of building parallel corpora for minority Finno-Ugric languages spoken in the former Soviet Union has become prominent due to the Kindred Language Digitization pilot projects conducted at the National Library of Finland. This work was directly associated with the five-year «Language Programme» funded by the Kone Foundation, which actually began preparatory work in 2011 through 2012 before funding was begun. One of the outcomes of the Kindred Language Digitization pilot projects was

The parallel corpus is based on the Erzya- and Moksha-language translations of a school reader written in Russian by V.A. Tetûrev. Estestvoznanie, častʹ I učebnik dlâ tretʹego klassa načalʹnoj školy.
The Erzya version 1939: Estestvoznaniâ vasence pelʹks, načalʹnoj školanʹ kolmoce klasso tonavtnema kniga (2nd edition), (translated: A. Tâguševa).
The Moksha version 1940: Estestvoznaniâ, vasence pâlʹkssʹ, načalʹnaj školanʹ 3-ce klassa tonafnema kniga (4th edition), (translator, not given).

XXX using finite-state morphology tools developed in the auspices of the GiellaLT infrastructure in Tromsoe, Norway as well as the Universities of Turku and Helsinki, Finland. 

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


Additional information:
Ютавтозь кинигасо 2090 валрисьметь.
Весе валрисьметнень эйстэ ансяк 28 те ёндо эрявикст.

erz:prt2,mks:hab.prt1 = эрзянь кельсэ омбоце ютазь шкась ды мокшонь кельсэ "Aspect=Habitual" ды васенце ютазь шкась весемезэ = 13

erz:conj,mks:conj = эрзянь ды мокшонь кельсэ конъюнктив весемезэ 5

erz:opt,mks:conj эрзянь кельсэ оптатив ды мокшонь кельсэ конъюнктив весемезэ 4

erz:prt2,mks:prt2 = эрзянь кельсэ омбоце ютазь шкась ды мокшонь кельсэяк теке  весемезэ 1Ютавтозь кинигасо 2090 валрисьметь.
Весе валрисьметнень эйстэ ансяк 28 те ёндо эрявикст.

erz:prt2,mks:hab.prt1 = эрзянь кельсэ омбоце ютазь шкась ды мокшонь кельсэ "Aspect=Habitual" ды васенце ютазь шкась весемезэ = 13

erz:conj,mks:conj = эрзянь ды мокшонь кельсэ конъюнктив весемезэ 5

erz:opt,mks:conj эрзянь кельсэ оптатив ды мокшонь кельсэ конъюнктив весемезэ 4

erz:prt2,mks:prt2 = эрзянь кельсэ омбоце ютазь шкась ды мокшонь кельсэяк теке  весемезэ 1