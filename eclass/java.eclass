# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/java.eclass,v 1.11 2003/05/19 23:29:41 tberman Exp $
#
# Author: Karl Trygve Kalleberg <karltk@gentoo.org>

ECLASS=java
INHERITED="$INHERITED $ECLASS"
DESCRIPTION="Based on the $ECLASS eclass"

VMHANDLE=${PN}-${PV}

function sed2() {
	unset filename 
	unset arglist
	local filename=""
	local arglist
	declare -a arglist
	while test $# -gt 0 ; do
		case $1 in
			-e)
				shift
				arglist[${#arglist[@]}]="-e"
				arglist[${#arglist[@]}]="$1"
			;;
			*)
				if [ -e "$1" ] ; then 
					filename=$1
				fi
			;;
		esac
		shift
	done

	if [ ! -z $filename ] ; then 
		mv "${filename}" "${filename}.orig"
		sed "${arglist[@]}" < ${filename}.orig > ${filename}
		return 0
	else
		return 1
	fi
}

java_pkg_postinst() {
	if [ -z `java-config --java 2> /dev/null` ] ; then 
		einfo "No default VM found, setting ${VMHANDLE} as default"
		java-config --set-system-vm=${VMHANDLE}
	fi
}

pkg_postinst() {
	java_pkg_postinst
}

system_arch() {
	local sarch
	sarch=`echo $ARCH | sed -e s/[i]*.86/i386/ -e s/sun4u/sparc64/ -e s/arm.*/arm/ -e s/sa110/arm/`
	if [ -z "$sarch" ] ; then
		sarch=`uname -m | sed -e s/[i]*.86/i386/ -e s/sun4u/sparc64/ -e s/arm.*/arm/ -e s/sa110/arm/`
	fi
	echo $sarch
}

set_java_env() {
	dodir /etc/env.d/java
	sed \
		-e "s/@P@/${P}/g" \
		-e "s/@PN@/${PN}/g" \
		-e "s/@PV@/${PV}/g" \
		-e "s/@PF@/${PF}/g" \
                -e "/^ADDLDPATH=.*lib\\/\\"/s|\"\\(.*\\)\"|\"\\1${platform}/:\\1${platform}/server/\"|" \
		< $1 \
		> ${D}/etc/env.d/java/20`basename $1` || die
}

install_mozilla_plugin() {
	local bn
	bn=`basename $1`

	if [ "`use mozilla`" ] ; then
		dodir /usr/lib/mozilla/plugins
		dosym $1 /usr/lib/mozilla/plugins/${bn}
	fi
}

