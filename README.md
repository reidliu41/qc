# Switch sosreport or system directories quickly 

* qc - quick cd

* qck - quick check from qc -h

## Background

* During the sosreport analysis or accessing long system directories, it is very often to switch the directory to check the different information(e.g. log).

## Function 

The script which is helping to switch to the different sosreport or the system directories easily.

## Implementation

1. Download the repo, apply executable permissions to the script and move `quick_cd_sosdir.sh` and `qck` into the sysetem ENV search PATH(e.g. /usr/local/bin).

```
cd qc
chmod +x quick_cd_sosdir.sh
chmod +x qck
chmod +x set_bash_profile.sh

sh set_bash_profile.sh
source ~/.bash_profile
```

2. Or quick set with below:

```
mkdir ~/bin
curl --insecure  -L https://raw.githubusercontent.com/reidliu41/qc/main/quick_cd_sosdir.sh -o ~/bin/quick_cd_sosdir.sh
curl --insecure -L https://raw.githubusercontent.com/reidliu41/qc/main/qck -o ~/bin/qck
curl --insecure -L https://raw.githubusercontent.com/reidliu41/qc/main/set_bash_profile.sh -o ~/bin/set_bash_profile.sh
chmod +x ~/bin/qck
chmod +x ~/bin/quick_cd_sosdir.sh
chmod +x ~/bin/set_bash_profile.sh
sh  ~/bin/set_bash_profile.sh
source ~/.bash_profile
```

## Script Usage

* Help

```
$ qc h | head -16
To switch sosreport directories quickly.
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
```

* NOTE: Suggest cleaning it first if used before, especially multiple SOS reports which are using append the record, may cause the repeated entry.
Suggest cleaning it first if used before, especially multiple SOS reports which are using append the record, may cause the repeated entry.

```
# qc -r
========================================================
rm: remove regular file ‘/root/.qc_sosreport_top_path’? y
rm: remove regular file ‘/root/.qc_sosreport_top_path_multi’? y
========================================================
```

* How to name? It might not cover all the situations, please feel free to add your shortcut.

```
The keyword which named with the first letter of the directory, the first and/or the second of the last directory, but for some special, check with -h.
e.g.
  sab                               cd sos_commands/abrt
                                       ^            ^^
  snm                               cd sos_commands/networkmanager
                                       ^            ^      ^
  esn                               cd etc/sysconfig/network-scripts/
                                       ^   ^         ^

REPEAT Situation Handle:
  sau                               cd sos_commands/auditd
                                       ^            ^^
  saut                              cd sos_commands/autofs
                                       ^            ^^^

You can check the help output with qck if forget:
# qck
===============================================
To search the keyword from qc -h output quickly
  Usage: qck keyword
    e.g. qck systemd
Options:
     opt    options
    scmd    sos_commands path
     log    var log path
     etc    etc path
 keyword    qc -h|grep keyword
===============================================

# qck rhsm
  vlrh                              cd var/log/rhsm
  erh                              cd etc/rhsm
```

* Use for the current system 

```
####### --> Set the "/" for record and use it in current system
# cd /
# qc c
========================================================
The sosreport top path record created.
The sosreport top path is:
/
========================================================
# qc vlog
Switched to /var/log  <<<

# qc elv
Switched to /etc/lvm
```

* Single sosreport usage

```
Create the path record
# cd sosreport-rhel7u7-xxxxx-2022-09-20-opzlaho
# qc -c
========================================================
The sosreport top path record created.
The sosreport top path is:
/var/tmp/sosreport-rhel7u7-xxxxx-2022-09-20-opzlaho
========================================================

# qc -ck
========================================================
The sosreport top path is:
/var/tmp/sosreport-rhel7u7-xxxxx-2022-09-20-opzlaho
--------------------------------------------------------
The multiple sosreport top path are:
=======================================================

# pwd
/var/tmp/sosreport-rhel7u7-xxxxx-2022-09-20-opzlaho

# qc vlog
Switched to /var/tmp/sosreport-rhel7u7-xxxxx-2022-09-20-opzlaho/var/log

Back to top path:
# qc -s
Switched to /var/tmp/sosreport-rhel7u7-xxxxx-2022-09-20-opzlaho
```


* Multiple sosreports usage

```
Create top path record for aaaaa sosreport
# cd sosreport-rhel7u7-aaaaa-2022-09-21-anfpuus
# pwd
/var/tmp/sosreport-rhel7u7-aaaaa-2022-09-21-anfpuus
                           ^^^^^

**NOTE**: Suggest the key would be special

# qc -m a
========================================================
The multiple sosreport top path record created.
The multiple sosreport top path are:
a /var/tmp/sosreport-rhel7u7-aaaaa-2022-09-21-anfpuus         <<<
========================================================


Create top path record for bbbbb sosreport
# cd sosreport-rhel7u7-bbbbb-2022-09-21-lldygpp
# pwd
/var/tmp/sosreport-rhel7u7-bbbbb-2022-09-21-lldygpp
                           ^^^^^
# qc -m b
========================================================
The multiple sosreport top path record created.
The multiple sosreport top path are:
a /var/tmp/sosreport-rhel7u7-aaaaa-2022-09-21-anfpuus
b /var/tmp/sosreport-rhel7u7-bbbbb-2022-09-21-lldygpp        <<<
========================================================

# qc -ck
========================================================
The sosreport top path is:
--------------------------------------------------------
The multiple sosreport top path are:
a /var/tmp/sosreport-rhel7u7-aaaaa-2022-09-21-anfpuus
b /var/tmp/sosreport-rhel7u7-bbbbb-2022-09-21-lldygpp
=======================================================

Test:
# qc -k a vlog
Switched to /var/tmp/sosreport-rhel7u7-aaaaa-2022-09-21-anfpuus/var/log

# qc -k b vlog
Switched to /var/tmp/sosreport-rhel7u7-bbbbb-2022-09-21-lldygpp/var/log

Back to top path:
# qc -k a s
Switched to /var/tmp/sosreport-rhel7u7-aaaaa-2022-09-21-anfpuus
```

* Optimization operations

```
####### --> Command completion function
# qc -<tab><tab>
-c   -ck  -e   -g   -h   -k   -m   -r   -s

# qc c<tab><tab>
c   ck

# qc k sosreport1 vlto<tab><tab>
vlto   vltow


####### --> Simply use it without '-'
# qc c
========================================================
The sosreport top path record created.
The sosreport top path is:
/var/tmp/sosreport-rhel7u7-xxxxx-2022-09-20-opzlaho
========================================================

# qc m a1
========================================================
The multiple sosreport top path record created.
The multiple sosreport top path are:
a1 /var/tmp/sosreport-rhel7u7-aaaaa-2022-09-21-anfpuus
========================================================

# qc s
Switched to /var/tmp/sosreport-rhel7u7-xxxxx-2022-09-20-opzlaho

# qc k a1 s
Switched to /var/tmp/sosreport-rhel7u7-aaaaa-2022-09-21-anfpuus


####### --> Check output from multiple sosreports with '-g/g'
# qc g xx
========================================================
The sosreport top path is:
/var/tmp/sosreport-rhel7u7-xxxxx-2022-09-20-opzlaho
--------------------------------------------------------
The multiple sosreport top path are:
xx /var/tmp/sosreport-rhel7u7-xxxxx-2022-09-20-opzlaho
========================================================

####### --> Specify the path for c/m
# qc c /var/tmp/sosreport-rhel7u7-aaaaa-2022-09-21-anfpuus/
========================================================
The sosreport top path record created.
The sosreport top path is:
/var/tmp/sosreport-rhel7u7-aaaaa-2022-09-21-anfpuus/
========================================================

# qc m test /var/tmp/sosreport-rhel7u7-aaaaa-2022-09-21-anfpuus/
========================================================
The multiple sosreport top path record created.
The multiple sosreport top path are:
test /var/tmp/sosreport-rhel7u7-aaaaa-2022-09-21-anfpuus/
========================================================
```
