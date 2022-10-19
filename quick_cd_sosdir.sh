#!/bin/bash
################################################################################################
# Function  : Switch the directories in sosreport or the system easily
# Version   : v1.0.0
# Copyright : Copyright (c) 2022 Reid Liu <guliu@redhat.com>
# Author    : Reid Liu <guliu@redhat.com>
# License   : https://github.com/reidliu41/qc/blob/main/LICENSE
#################################################################################################
FIRST_ARG=$1

# File Variables
TOP_DIR_PATH_FILE=~/.qc_sosreport_top_path
TOP_DIR_PATH_MULTI_FILE=~/.qc_sosreport_top_path_multi

# The path file
[ ! -f $TOP_DIR_PATH_FILE ] && touch $TOP_DIR_PATH_FILE
TOP_DIR_PATH=`cat $TOP_DIR_PATH_FILE`
[ ! -f $TOP_DIR_PATH_MULTI_FILE ] && touch $TOP_DIR_PATH_MULTI_FILE

# The switch to directory function
cd_to_dir_func() {
	if [[ -d ${TOP_DIR_PATH}/$1 && ${TOP_DIR_PATH} != "/" ]]
	then
		cd ${TOP_DIR_PATH}/$1
		echo -e "\033[33mSwitched to $PWD\033[0m"
	elif [[ -d ${TOP_DIR_PATH}/$1 && ${TOP_DIR_PATH} == "/" ]]
	then
		cd /$1
		echo -e "\033[33mSwitched to $PWD\033[0m"
	else
		echo -e "\033[33mNo such directory, cannot switch!\033[0m"
	fi
}

# Create the single sosreport path record
create_single_path_record(){
			THE_PATH_RECORD=$1
        	echo '========================================================'
        	echo -e "\033[36mThe sosreport top path record created.\033[0m"
        	echo -e "\033[36mThe sosreport top path is:\033[0m"
        	echo ${THE_PATH_RECORD} > $TOP_DIR_PATH_FILE
        	cat $TOP_DIR_PATH_FILE
        	echo '========================================================'
}

# Create the multiple record
multiple_path_record(){
			SET_KEY_ARG=$1
			THE_PATH_RECORD=$2
            grep ^${SET_KEY_ARG} $TOP_DIR_PATH_MULTI_FILE &>/dev/null
            if [ $? -eq 0 ]
            then
                echo -e "\033[33mThe key is existed. Please change another one.\033[0m"
            else
                echo '========================================================'
                echo -e "\033[36mThe multiple sosreport top path record created.\033[0m"
                echo -e "\033[36mThe multiple sosreport top path are:\033[0m"
                echo "${SET_KEY_ARG} ${THE_PATH_RECORD}" >> $TOP_DIR_PATH_MULTI_FILE
                cat $TOP_DIR_PATH_MULTI_FILE
                echo '========================================================'
            fi
}

# The help function
help_echo_function() {
	echo "To switch sosreport directories quickly.
Usage: qc [OPTION] [ARG]
Options:
  -h, h                              Show the commands usage
  -c, c                              Create the top directory record
  -ck, ck                            Check the top directory record
  -m, m                              Create the multiple top directory records, specify the short keyword as tag, e.g. a1
  -k, k                              Specify the keyword to switch for multiple sosreport situation , e.g. -k a1
  -r, r                              Remove the top directory record
  -g, g                              Grep the ck output
  -s, s                              Back to the top directory
  -e, e                              Edit the multiple sosreport record file, e.g. remove entry, edit key
  -l, l                              List files/dir under the current directory
  -p, p                              Show the current path
==> sos_commands:
  sab                               cd sos_commands/abrt
  sal                               cd sos_commands/alternatives
  san                               cd sos_commands/ansible
  sau                               cd sos_commands/auditd
  saut                              cd sos_commands/autofs
  sbl                               cd sos_commands/block
  sbo                               cd sos_commands/boot
  sbt                               cd sos_commands/btrfs
  scg                               cd sos_commands/cgroups
  scr                               cd sos_commands/cron
  scry                              cd sos_commands/crypto
  sca                               cd sos_commands/candlepin
  sce                               cd sos_commands/ceph
  sci                               cd sos_commands/cifs
  sco                               cd sos_commands/console
  sda                               cd sos_commands/date
  sdb                               cd sos_commands/dbus
  sdm                               cd sos_commands/devicemapper
  sde                               cd sos_commands/devices
  sdr                               cd sos_commands/dracut
  sdmr                              cd sos_commands/dmraid
  sdn                               cd sos_commands/dnf
  sfc                               cd sos_commands/fcoe
  sfs                               cd sos_commands/filesys
  sfw                               cd sos_commands/firewalld
  sfo                               cd sos_commands/foreman
  sgr                               cd sos_commands/grub2
  shw                               cd sos_commands/hardware
  sho                               cd sos_commands/host
  si1                               cd sos_commands/i18n
  sin                               cd sos_commands/insights
  sip                               cd sos_commands/ipmitool
  sis                               cd sos_commands/iscsi
  sja                               cd sos_commands/java
  skd                               cd sos_commands/kdump
  ske                               cd sos_commands/kernel
  skey                              cd sos_commands/keyutils
  skp                               cd sos_commands/kpatch
  skr                               cd sos_commands/krb5
  sla                               cd sos_commands/last
  sld                               cd sos_commands/ldap
  slib                              cd sos_commands/libraries
  slit                              cd sos_commands/libvirt
  slo                               cd sos_commands/login
  slr                               cd sos_commands/logrotate
  slog                              cd sos_commands/logs
  sls                               cd sos_commands/lstopo
  slv                               cd sos_commands/lvm2
  smd                               cd sos_commands/md
  sme                               cd sos_commands/memory
  smo                               cd sos_commands/mongodb
  smu                               cd sos_commands/multipath
  sne                               cd sos_commands/networking
  snm                               cd sos_commands/networkmanager
  snf                               cd sos_commands/nfs
  sni                               cd sos_commands/nis
  sns                               cd sos_commands/nscd
  snss                              cd sos_commands/nss
  snu                               cd sos_commands/numa
  sop                               cd sos_commands/opengl
  sope                              cd sos_commands/openssl
  sos                               cd sos_commands/openshift
  spa                               cd sos_commands/pam
  spc                               cd sos_commands/pci
  spe                               cd sos_commands/perl
  spo                               cd sos_commands/postfix
  spg                               cd sos_commands/postgresql
  spp                               cd sos_commands/ppp
  spr                               cd sos_commands/process
  spro                              cd sos_commands/processor
  sps                               cd sos_commands/psacct
  spu                               cd sos_commands/pulp
  spul                              cd sos_commands/pulpcore
  spup                              cd sos_commands/puppet
  spy                               cd sos_commands/python
  sqp                               cd sos_commands/qpid
  sqd                               cd sos_commands/qpid_dispatch
  sra                               cd sos_commands/rasdaemon
  sre                               cd sos_commands/release
  srp                               cd sos_commands/rpm
  sru                               cd sos_commands/ruby
  ssa                               cd sos_commands/samba
  ssar                              cd sos_commands/sar
  ssc                               cd sos_commands/scsi
  sse                               cd sos_commands/selinux
  sser                              cd sos_commands/services
  ssn                               cd sos_commands/snmp
  ssq                               cd sos_commands/squid
  ssm                               cd sos_commands/subscription_manager
  ssy                               cd sos_commands/system
  ssyst                             cd sos_commands/systemd
  ssys                              cd sos_commands/sysvipc
  stu                               cd sos_commands/tuned
  sus                               cd sos_commands/usb
  sx1                               cd sos_commands/x11
  sxf                               cd sos_commands/xfs
  syu                               cd sos_commands/yum
==> logs:
  vlog                              cd var/log/
  vlan                              cd var/log/anaconda
  vlau                              cd var/log/audit
  vlca                              cd var/log/candlepin
  vlfo                              cd var/log/foreman
  vlfi                              cd var/log/foreman-installer
  vlfm                              cd var/log/foreman-maintain
  vlfp                              cd var/log/foreman-proxy
  vlht                              cd var/log/httpd
  vlic                              cd var/log/insights-client
  vlng                              cd var/log/nginx
  vlrec                             cd var/log/receptor
  vlre                              cd var/log/redis
  vlrh                              cd var/log/rhsm
  vlsa                              cd var/log/sa
  vlsq                              cd var/log/squid
  vlsu                              cd var/log/supervisor
  vlto                              cd var/log/tomcat
  vltow                             cd var/log/tower
==> etc:
  edn                              cd etc/dnf
  efo                              cd etc/foreman
  efi                              cd etc/foreman-installer
  efp                              cd etc/foreman-proxy
  eht                              cd etc/httpd
  elo                              cd etc/logrotate.d
  elv                              cd etc/lvm
  emo                              cd etc/modprobe.d
  emu                              cd etc/multipath
  enm                              cd etc/NetworkManager
  eop                              cd etc/openldap
  epa                              cd etc/pam.d
  epo                              cd etc/postfix
  epu                              cd etc/pulp
  epup                             cd etc/puppetlabs
  erh                              cd etc/rhsm
  ers                              cd etc/rsyslog.d
  esa                              cd etc/samba
  ese                              cd etc/security
  esel                             cd etc/selinux
  ess                              cd etc/ssh
  esy                              cd etc/sysconfig
  esys                             cd etc/sysctl.d
  esyst                            cd etc/systemd
  esn                              cd etc/sysconfig/network-scripts/
  evw                              cd etc/etc/virt-who.d
  eyu                              cd etc/yum
  eyr                              cd etc/yum/yum.repos.d"
}

# Script usage.
if [ $# -eq 0 ]
then
	help_echo_function
	# Due to using the source command effect, cannot use exit here, so try to return
	return
elif [[ $# -eq 1 &&  "$FIRST_ARG" != 'h' && "$FIRST_ARG" != '-h' && "$FIRST_ARG" != '-ck' && "$FIRST_ARG" != 'ck' && "$FIRST_ARG" != '-c' && "$FIRST_ARG" != 'c' && "$FIRST_ARG" != '-m' && "$FIRST_ARG" != 'm' && "$FIRST_ARG" != '-k' && "$FIRST_ARG" != 'k' && "$FIRST_ARG" != '-r' && "$FIRST_ARG" != 'r' && "$FIRST_ARG" != 'e' && "$FIRST_ARG" != '-e' && "$FIRST_ARG" != 'l' && "$FIRST_ARG" != '-l' && "$FIRST_ARG" != 'p' && "$FIRST_ARG" != '-p' ]]
then
	if [ ! -s $TOP_DIR_PATH_FILE ]
	then
	 	echo -e "\033[33mThe top directory record is empty, please enter the operation directory and create with 'c/-c' first.\033[0m"
	 	echo -e "\033[33me.g.:\033[0m"
	 	echo -e "\033[33mcd /var/tmp/sosreport-rhel-test-2022-10-06-agwtdyg && qc c\033[0m"
		# Due to using the source command effect, cannot use exit here, so try to return
	    return
	fi
elif [[ "$FIRST_ARG" == '-k' || "$FIRST_ARG" == 'k' ]] && [ $# -ge 3 ]
then
	CHK_KEY_ARG=$2
	FIRST_ARG=$3
	if [ ! -s $TOP_DIR_PATH_MULTI_FILE ]
	then
	 	echo -e "\033[33mThe multiple top directory record is empty, please enter the operation directory and create with 'm/-m' first.\033[0m"
	 	echo -e "\033[33me.g.:\033[0m"
	 	echo -e "\033[33mcd /var/tmp/sosreport-rhel-test-2022-10-06-agwtdyg && qc m tmp\033[0m"
		# Due to using the source command effect, cannot use exit here, so try to return
		return
	fi
	grep ^${CHK_KEY_ARG} $TOP_DIR_PATH_MULTI_FILE &>/dev/null
	if [ $? -eq 0 ]
	then
		TOP_DIR_PATH=`grep ^${CHK_KEY_ARG} $TOP_DIR_PATH_MULTI_FILE | awk '{print $2}'`
	else
	 	echo -e "\033[33mThe key is not exist, please enter the operation directory and create with 'm/-m' first.\033[0m"
	 	echo -e "\033[33me.g.:\033[0m"
	 	echo -e "\033[33mcd /var/tmp/sosreport-rhel-test-2022-10-06-agwtdyg && qc m tmp\033[0m"
		# Due to using the source command effect, cannot use exit here, so try to return
		return
	fi
fi

# Options
case "$FIRST_ARG" in
	-h|h)
		help_echo_function
		;;
    -c|c)
		if [ $# -eq 1 ]
		then
			create_single_path_record $PWD
		elif [ $# -eq 2 ]
		then
			THE_SPECIFY_PATH=$2
			create_single_path_record ${THE_SPECIFY_PATH}
		fi
        ;;
    -ck|ck)
        echo '========================================================'
        echo -e "\033[36mThe sosreport top path is:\033[0m"
        cat $TOP_DIR_PATH_FILE
        echo '--------------------------------------------------------'
        echo -e "\033[36mThe multiple sosreport top path are:\033[0m"
        cat $TOP_DIR_PATH_MULTI_FILE
        echo '========================================================'
        ;;
    -g|g)
        if [ $# -eq 2 ]
        then
            echo '========================================================'
            echo -e "\033[36mThe sosreport top path is:\033[0m"
            FILTER_STRING=$2
            grep $FILTER_STRING $TOP_DIR_PATH_FILE
            echo '--------------------------------------------------------'
            echo -e "\033[36mThe multiple sosreport top path are:\033[0m"
            grep $FILTER_STRING $TOP_DIR_PATH_MULTI_FILE
            echo '========================================================'
        fi
        ;;
    -e|e)
        vi $TOP_DIR_PATH_MULTI_FILE
        ;;
    -r|r)
        echo '=================================='
        echo -e "\033[31mRemove the record file.\033[0m"
        rm $TOP_DIR_PATH_FILE
        rm $TOP_DIR_PATH_MULTI_FILE
        echo '=================================='
        ;;
    -m|m)
         if [ $# -eq 2 ]
         then
         	SET_KEY_ARG=$2
			multiple_path_record ${SET_KEY_ARG} ${PWD}
		elif [ $# -eq 3 ]
		then
         	SET_KEY_ARG=$2
			THE_SPECIFY_PATH=$3
			multiple_path_record ${SET_KEY_ARG}	${THE_SPECIFY_PATH}
         fi
        ;;
	-s|s)
		cd_to_dir_func
		;;
    -l|l)
        ls -l
        ;;
    -p|p)
        echo -e "\033[36mThe current path is: \033[0m"
        echo -e "\033[36m$PWD\033[0m"
        ;;
	# sos_commands directory
	sab)
		cd_to_dir_func sos_commands/abrt
		;;
	sal)
		cd_to_dir_func sos_commands/alternatives
		;;
	san)
		cd_to_dir_func sos_commands/ansible
		;;
	sau)
		cd_to_dir_func os_commands/auditd
		;;
	saut)
		cd_to_dir_func sos_commands/autofs
		;;
	sbl)
		cd_to_dir_func sos_commands/block
		;;
	sbo)
		cd_to_dir_func sos_commands/boot
		;;
	sbt)
		cd_to_dir_func sos_commands/btrfs
		;;
	scg)
		cd_to_dir_func sos_commands/cgroups
		;;
	scr)
		cd_to_dir_func sos_commands/cron
		;;
	scry)
		cd_to_dir_func sos_commands/crypto
		;;
	sca)
		cd_to_dir_func sos_commands/candlepin
		;;
	sce)
		cd_to_dir_func sos_commands/ceph
		;;
	sci)
		cd_to_dir_func sos_commands/cifs
		;;
	sco)
		cd_to_dir_func sos_commands/console
		;;
	sda)
		cd_to_dir_func sos_commands/date
		;;
	sdb)
		cd_to_dir_func sos_commands/dbus
		;;
	sdm)
		cd_to_dir_func sos_commands/devicemapper
		;;
	sde)
		cd_to_dir_func sos_commands/devices
		;;
	sdr)
		cd_to_dir_func sos_commands/dracut
		;;
	sdmr)
		cd_to_dir_func sos_commands/dmraid
		;;
	sdn)
		cd_to_dir_func sos_commands/dnf
		;;
 	sfc)
		cd_to_dir_func sos_commands/fcoe
        ;;
	sfs)
		cd_to_dir_func sos_commands/filesys
		;;
	sfw)
		cd_to_dir_func sos_commands/firewalld
		;;
	sfo)
		cd_to_dir_func sos_commands/foreman
		;;
	sgr)
		cd_to_dir_func sos_commands/grub2
		;;
	shw)
		cd_to_dir_func sos_commands/hardware
		;;
	sho)
		cd_to_dir_func sos_commands/host
		;;
	si1)
		cd_to_dir_func sos_commands/i18n
		;;
	sin)
		cd_to_dir_func sos_commands/insights
		;;
	sip)
		cd_to_dir_func sos_commands/ipmitool
		;;
	sis)
		cd_to_dir_func sos_commands/iscsi
		;;
	sja)
		cd_to_dir_func sos_commands/java
		;;
	skd)
		cd_to_dir_func sos_commands/kdump
		;;
	ske)
		cd_to_dir_func sos_commands/kernel
		;;
	skey)
		cd_to_dir_func sos_commands/keyutils
		;;
	skp)
		cd_to_dir_func sos_commands/kpatch
		;;
	skr)
		cd_to_dir_func sos_commands/krb5
		;;
	sla)
		cd_to_dir_func sos_commands/last
		;;
	sld)
		cd_to_dir_func sos_commands/ldap
		;;
	slib)
		cd_to_dir_func sos_commands/libraries
		;;
	slit)
		cd_to_dir_func sos_commands/libvirt
		;;
	slo)
		cd_to_dir_func sos_commands/login
		;;
	slr)
		cd_to_dir_func sos_commands/logrotate
		;;
	slog)
		cd_to_dir_func sos_commands/logs
		;;
	sls)
		cd_to_dir_func sos_commands/lstopo
		;;
	slv)
		cd_to_dir_func sos_commands/lvm2
		;;
	smd)
		cd_to_dir_func sos_commands/md
		;;
	sme)
		cd_to_dir_func sos_commands/memory
		;;
	smo)
		cd_to_dir_func sos_commands/mongodb
		;;
	smu)
		cd_to_dir_func sos_commands/multipath
		;;
	sne)
		cd_to_dir_func sos_commands/networking
		;;
	snf)
		cd_to_dir_func sos_commands/nfs
		;;
	sni)
		cd_to_dir_func sos_commands/nis
		;;
  	sns)
		cd_to_dir_func sos_commands/nscd
		;;
	snss)
		cd_to_dir_func sos_commands/nss
		;;
	snt)
		cd_to_dir_func sos_commands/ntp
		;;
	snu)
		cd_to_dir_func sos_commands/numa
		;;
    sop)
		cd_to_dir_func sos_commands/opengl
		;;
    sope)
		cd_to_dir_func sos_commands/openssl
		;;
    sos)
		cd_to_dir_func sos_commands/openshift
		;;
	spa)
		cd_to_dir_func sos_commands/pam
		;;
	spc)
		cd_to_dir_func sos_commands/pci
		;;
	spe)
		cd_to_dir_func sos_commands/perl
		;;
	spo)
		cd_to_dir_func sos_commands/postfix
		;;
	spg)
		cd_to_dir_func sos_commands/postgresql
		;;
	spp)
		cd_to_dir_func sos_commands/ppp
		;;
    spr)
		cd_to_dir_func sos_commands/process
		;;
	spro)
		cd_to_dir_func sos_commands/processor
		;;
	sps)
		cd_to_dir_func sos_commands/psacct
		;;
	spu)
		cd_to_dir_func sos_commands/pulp
		;;
	spul)
		cd_to_dir_func sos_commands/pulpcore
		;;
	spup)
		cd_to_dir_func sos_commands/puppet
		;;
	spy)
		cd_to_dir_func sos_commands/python
		;;
 	sqp)
		cd_to_dir_func sos_commands/qpid
		;;
	sqd)
		cd_to_dir_func sos_commands/qpid_dispatch
		;;
	sra)
		cd_to_dir_func sos_commands/rasdaemon
		;;
	sre)
		cd_to_dir_func sos_commands/release
		;;
	srp)
		cd_to_dir_func sos_commands/rpm
		;;
	sru)
		cd_to_dir_func sos_commands/ruby
		;;
	ssa)
		cd_to_dir_func sos_commands/samba
		;;
	ssar)
		cd_to_dir_func sos_commands/sar
		;;
	ssc)
		cd_to_dir_func sos_commands/scsi
		;;
	sse)
		cd_to_dir_func sos_commands/selinux
		;;
	sser)
		cd_to_dir_func sos_commands/services
		;;
	ssn)
		cd_to_dir_func sos_commands/snmp
		;;
	ssq)
		cd_to_dir_func sos_commands/squid
		;;
	ssm)
		cd_to_dir_func sos_commands/subscription_manager
		;;
	ssy)
		cd_to_dir_func sos_commands/system
		;;
	ssyst)
		cd_to_dir_func sos_commands/systemd
		;;
	ssy)
		cd_to_dir_func sos_commands/sysvipc
		;;
	stu)
		cd_to_dir_func sos_commands/tuned
		;;
	sus)
		cd_to_dir_func sos_commands/usb
		;;
	sx1)
		cd_to_dir_func sos_commands/x11
		;;
	sxf)
		cd_to_dir_func sos_commands/xfs
		;;
	syu)
		cd_to_dir_func sos_commands/yum
		;;
	# logs directory
	vlog)
		cd_to_dir_func var/log/
		;;
	vlan)
		cd_to_dir_func var/log/anaconda
		;;
	vlau)
		cd_to_dir_func var/log/audit
		;;
	vlca)
		cd_to_dir_func var/log/candlepin
		;;
	vlfo)
		cd_to_dir_func var/log/foreman
		;;
	vlfi)
		cd_to_dir_func var/log/foreman-installer
		;;
	vlfm)
		cd_to_dir_func var/log/foreman-maintain
		;;
	vlfp)
		cd_to_dir_func var/log/foreman-proxy
		;;
	vlht)
		cd_to_dir_func var/log/httpd
		;;
	vlic)
		cd_to_dir_func var/log/insights-client
		;;
	vlng)
		cd_to_dir_func var/log/nginx
		;;
	vlrec)
		cd_to_dir_func var/log/receptor
		;;
	vlre)
		cd_to_dir_func var/log/redis
		;;
	vlrh)
		cd_to_dir_func var/log/rhsm
		;;
	vlsa)
		cd_to_dir_func var/log/sa
		;;
	vlsq)
		cd_to_dir_func var/log/squid
		;;
	vlsu)
		cd_to_dir_func var/log/supervisor
		;;
	vlto)
		cd_to_dir_func var/log/tomcat
		;;
	vltow)
		cd_to_dir_func var/log/tower
		;;
	# etc directory
	edn)
		cd_to_dir_func etc/dnf
		;;
	efo)
		cd_to_dir_func etc/foreman
		;;
	efi)
		cd_to_dir_func etc/foreman-installer
		;;
	efp)
		cd_to_dir_func etc/foreman-proxy
		;;
	eht)
		cd_to_dir_func etc/httpd
		;;
	elo)
		cd_to_dir_func etc/logrotate.d
		;;
	elv)
		cd_to_dir_func etc/lvm
		;;
	emo)
		cd_to_dir_func etc/modprobe.d
		;;
	emu)
		cd_to_dir_func etc/multipath
		;;
	enm)
		cd_to_dir_func etc/NetworkManager
		;;
	eop)
		cd_to_dir_func etc/openldap
		;;
	epa)
		cd_to_dir_func etc/pam.d
		;;
	epo)
		cd_to_dir_func etc/postfix
		;;
	epu)
		cd_to_dir_func etc/pulp
		;;
	epup)
		cd_to_dir_func etc/puppetlabs
		;;
	erh)
		cd_to_dir_func etc/rhsm
		;;
	ers)
		cd_to_dir_func etc/rsyslog.d
		;;
	esa)
		cd_to_dir_func etc/samba
		;;
	ese)
		cd_to_dir_func etc/security
		;;
	esel)
		cd_to_dir_func etc/selinux
		;;
	ess)
		cd_to_dir_func etc/ssh
		;;
	esy)
		cd_to_dir_func etc/sysconfig
		;;
	esys)
		cd_to_dir_func etc/sysctl.d
		;;
	esyst)
		cd_to_dir_func etc/systemd
		;;
	esn)
		cd_to_dir_func etc/sysconfig/network-scripts/
		;;
	evw)
		cd_to_dir_func etc/virt-who.d
		;;
	eyu)
		cd_to_dir_func etc/yum
		;;
	eyr)
		cd_to_dir_func etc/yum.repos.d
		;;
	*)
		echo -e "\033[33mThe key/option is not define, please consider add a new one!\033[0m"
		;;
esac
