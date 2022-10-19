#!/bin/bash
###################################################################################
# This file is part of qc, providing intelligent qc tab-completion for BASH
# Deploy it to: ~/.bash_profile
#
# Latest version: <https://github.com/reidliu41/qc>
#
# Copyright : Copyright (c) 2022 Reid Liu <guliu@redhat.com>
###################################################################################
BASH_PROFILE_FILE=~/.bash_profile
[ ! -f ${BASH_PROFILE_FILE} ] && echo -e "\033[33m${BASH_PROFILE_FILE} is not exist! \033[0m" && exit

grep 'source quick_cd_sosdir.sh' ${BASH_PROFILE_FILE} &>/dev/null
if [ $? -ne 0 ]
then
cat << EOF >> ~/.bash_profile

###################qc alias###################
alias qc='source quick_cd_sosdir.sh'
EOF
echo -e "\033[36mThe qc alias is added! \033[0m"
else
	echo -e "\033[36mThe qc alias is already added! \033[0m"
fi

grep 'k -r -g -s -e sab sal san sau saut sbl sbo sbt' ${BASH_PROFILE_FILE} &>/dev/null
if [ $? -ne 0 ]
then
cat << EOF >> ~/.bash_profile

###################qc completion###################
_qc_completion() {
    local cur prev opts
    COMPREPLY=()
    cur="\${COMP_WORDS[COMP_CWORD]}"
    prev="\${COMP_WORDS[COMP_CWORD-1]}"
    opts="h c ck m k r g s e -h -c -ck -m -k -r -g -s -e sab sal san sau saut sbl sbo sbt scg scr scry sca sce sci sco sda sdb sdm sde sdr sdmr sfc sfs sfw sfo sgr shw sho si1 sin sip sis sja skd ske skey skp skr sla sld slib slit slo slr slog sls slv smd sme smo smu sne snm snf sni sns snss snu sop sope sos spa spc spe spo spg spp spr spro sps spu spul spup spy sqp sqd sra sre srp sru ssa ssar ssc sse sser ssn ssq ssm ssy ssyst ssys stu sus sx1 sxf syu vlog vlan vlau vlca vlfo vlfi vlfm vlfp vlht vlic vlng vlrec vlre vlrh vlsa vlsq vlsu vlto vltow edn efo efi efp eht elo elv emo emu enm eop epa epo epu epup erh ers esa ese esel ess esy esys esyst esn evw eyu eyr"

    case "\${prev}" in
		h|c|ck|m|k|r|g|s|e|-h|-c|-ck|-m|-k|-r|-g|-s|-e)
			[ \${COMP_CWORD} -eq 3 ] && echo
			;;
	       *)
			if [[  \${COMP_CWORD} -eq 3 ]]
			then
				opts="sab sal san sau saut sbl sbo sbt scg scr scry sca sce sci sco sda sdb sdm sde sdr sdmr sfc sfs sfw sfo sgr shw sho si1 sin sip sis sja skd ske skey skp skr sla sld slib slit slo slr slog sls slv smd sme smo smu sne snm snf sni sns snss snu sop sope sos spa spc spe spo spg spp spr spro sps spu spul spup spy sqp sqd sra sre srp sru ssa ssar ssc sse sser ssn ssq ssm ssy ssyst ssys stu sus sx1 sxf syu vlog vlan vlau vlca vlfo vlfi vlfm vlfp vlht vlic vlng vlrec vlre vlrh vlsa vlsq vlsu vlto vltow edn efo efi efp eht elo elv emo emu enm eop epa epo epu epup erh ers esa ese esel ess esy esys esyst esn evw eyu eyr"
			fi
			COMPREPLY=( \$(compgen -W "\${opts}" -- \${cur}) )
			;;
    esac
}
complete -F _qc_completion -o dirnames qc
EOF
	echo -e "\033[36mThe qc completion is added! \033[0m"
else
	echo -e "\033[36mThe qc completion is already added! \033[0m"
fi


echo
echo -e "\033[36m===>Double check output: \033[0m"
sleep 1
grep 'source quick_cd_sosdir.sh' ${BASH_PROFILE_FILE}
grep 'k -r -g -s -e sab sal san sau saut sbl sbo sbt' ${BASH_PROFILE_FILE} -B 7 -A 15
echo
echo -e "\033[36mPlease run: source ${BASH_PROFILE_FILE} \033[0m"
