#!/bin/csh -f

set listFileName = $1
set iJob = $2
set iLabel = $3
set iJes = $4
set iJer = $5
set Selection = $6


echo $listFileName

set sample = ${listFileName}
echo $sample
echo "JES " $iJes
echo "JER "$iJer

echo "Selection is turned" $Selection
if($Selection =~ On) then
	set Sel = 1
endif
if($Selection =~ Off) then
	set Sel = 0
endif
#set outDirName = batchBEAN/${sample}_${iLabel}_Sel${Selection}/log
#echo $outDirName


if ($iJes == 0) then
    if ($iJer == 0) then
        set outDirName = batchBEAN/${sample}_${iLabel}_Sel${Selection}/log
    endif
    if ($iJer == -1) then
        set outDirName = batchBEAN/${sample}_${iLabel}_Sel${Selection}_JerDown/log
    endif
    if ($iJer == 1) then
        set outDirName = batchBEAN/${sample}_${iLabel}_Sel${Selection}_JerUp/log
    endif
endif
if ($iJes == -1) then
	set outDirName = batchBEAN/${sample}_${iLabel}_Sel${Selection}_JesDown/log
endif
if ($iJes == 1) then
    set outDirName = batchBEAN/${sample}_${iLabel}_Sel${Selection}_JesUp/log
endif

if (! -e $outDirName) then
	mkdir -p $outDirName
endif

echo $outDirName

echo "run LepJetsTree TreeLepJets_condor_cfg.py "${sample}" "$iJob" "$iJes" "$iJer"  "$iLabel" "$Sel 
LepJetsTree TreeLepJets_condor_cfg.py ${sample} $iJob $iLabel $iJes $iJer $Sel  > & ! $outDirName/lepjetsAnalysis_${sample}_${iLabel}_${Selection}_${iJob}.log
