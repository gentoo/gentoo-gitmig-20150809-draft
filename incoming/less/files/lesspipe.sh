#!/bin/sh

if [ -f /usr/bin/file ];then
TYPE=`file -L $1 | cut -d' ' -f2-`
else
TYPE=""
fi

case $TYPE in
  gzip*)	   	CMD='gzip -d -c -q';;
  compress\'d\ data*)	CMD='uncompress -c';;
  GNU\ tar*)		CMD='tar -tvf';;
  Zip*)	        	CMD='unzip -c -qq';;
  Zoo*)	        	CMD='zoo xqp';;
  ARC*) 	       	CMD='arc pn';;
  LHa*)			CMD='lha p';;  
  RAR*)	        	CMD='unrar p';;
  RPM*)			CMD='rpm -qpil';;
# ARJ*)			unset CMD;;
  ELF*)			CMD='strings';;
  Linux/i386*)		CMD='strings';;
  MS-DOS\ executable*)	CMD='strings';;
  MS-Windows*)		CMD='strings';;
  Win95\ executable*)	CMD='strings';;
  bzip2\ compressed*)	CMD='bunzip2 -d -c';;
  bzip\ compressed*)	CMD='bunzip -d -c';;
  *)            	unset CMD;;
esac


if [ -z "$CMD" ]; then
   case $1 in
	*.tar.bz2) bzip2 -dc $1|tar tvvvf - 2>/dev/null ;;
	*.bz2) bzip2 -dc $1  2>/dev/null ;;
	*.tar) tar tvvf $1 2>/dev/null ;; 
	*.tgz) tar tzvvf $1 2>/dev/null ;;
	*.tar.gz) tar tzvvf $1 2>/dev/null ;;
	*.tar.Z) tar tzvvf $1 2>/dev/null ;;
	*.tar.z) tar tzvvf $1 2>/dev/null ;;
	*.Z) gzip -dc $1  2>/dev/null ;;
	*.z) gzip -dc $1  2>/dev/null ;;
	*.gz) gzip -dc $1  2>/dev/null ;;
	*.bz) bzip -dc $1  2>/dev/null ;;
	*.zip) unzip -l $1 2>/dev/null ;;
	*.lha) lha -v $1 2>/dev/null ;;
	*.slp) cat $1 | tar tIvvf - ;;
# 	*.html) lynx -dump -nolist $1 ;;
	*.rpm) rpm -qpli $1 2> /dev/null ;;
	*.tr|*.cgz) zcat $1 |cpio -iv --list 
   esac
else
  $CMD $1 2> /dev/null
fi
