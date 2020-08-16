java convert_UTF_WX_tam -i $1 -o ner_wx_interim1.txt
java Preprocess  ner_wx_interim1.txt > ner_inter2
perl preprocess-verb.pl ner_inter2 > toNER_CRF_inter3
crf_test -m model-ner-5Oct toNER_CRF_inter3  > crfner_interimOut.txt
perl merge-two-files.pl ner_wx_interim1.txt  crfner_interimOut.txt > inter1.txt
perl ne_npcheck_case.pl inter1.txt > inter2.txt
perl new-1assign-netag.pl inter2.txt > tag-dict.txt
perl new-ne-tag-dict.pl tag-dict.txt inter2.txt > inter-ner.txt
perl prune_ner.pl inter-ner.txt > ner_interimOut.txt

java convert_WX_UTF_tam -i ner_interimOut.txt -o $1_ner_out0.txt
perl colateFiles.pl $1 $1_ner_out0.txt > $1_ner_out_ii.txt

cat $1_ner_out_ii.txt
