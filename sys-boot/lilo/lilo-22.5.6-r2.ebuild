# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/lilo/lilo-22.5.6-r2.ebuild,v 1.3 2004/01/19 18:35:20 azarah Exp $

inherit mount-boot eutils

S="${WORKDIR}/${P}"
DESCRIPTION="Standard Linux boot loader"
SRC_URI="ftp://metalab.unc.edu/pub/Linux/system/boot/lilo/${P}.tar.gz
		ftp://metalab.unc.edu/pub/Linux/system/boot/lilo/obsolete/${P}.tar.gz"
#	mirror://gentoo/${P}-gentoo.diff.bz2"
HOMEPAGE="http://brun.dyndns.org/pub/linux/lilo/"

SLOT="0"
LICENSE="BSD GPL-2"
KEYWORDS="-* ~x86"

DEPEND="dev-lang/nasm
	>=sys-devel/bin86-0.15.5"

PROVIDE="virtual/bootloader"


src_compile() {
	emake CC="${CC:=gcc}" lilo || die
}

src_install() {
	keepdir /boot
	make ROOT=${D} install || die
	into /usr
	dosbin keytab-lilo.pl

	insinto /etc
	newins ${FILESDIR}/lilo.conf lilo.conf.example

	doman manPages/*.[5-8]
	dodoc CHANGES COPYING INCOMPAT README*
	docinto samples ; dodoc sample/*
}

pkg_preinst() {
	mount-boot_mount_boot_partition
}

# Check whether LILO is installed
# This function is from /usr/sbin/mkboot from debianutils, with copyright:
#
#   Debian GNU/Linux
#   Copyright 1996-1997 Guy Maor <maor@debian.org>
#
# Modified for Gentoo for use with the lilo ebuild by:
#   Martin Schlemmer <azarah@gentoo.org> (16 Mar 2003)
#
lilocheck () {
	local bootpart=
	local rootpart="$(rdev 2> /dev/null | cut -d ' ' -f 1 2> /dev/null)"

	echo
	einfon "Checking for LILO ..."

	if [ "$(whoami)" != "root" ]
	then
		echo; echo
		eerror "Only root can check for LILO!"
		return 1
	fi

	if [ -z "${rootpart}" ]
	then
		echo; echo
		eerror "Could not determine root partition!"
		return 1
	fi

	if [ ! -f /etc/lilo.conf -o ! -x /sbin/lilo ]
	then
		echo " No"
		return 1
	fi

	bootpart="$(perl -ne 'print $1 if /^\s*boot\s*=\s*(\S*)/' /etc/lilo.conf)"

	if [ -z "${bootpart}" ]
	then
		# lilo defaults to current root when 'boot=' is not present
		bootpart="${rootpart}"
	fi

	if ! dd if=${bootpart} ibs=16 count=1 2>&- | grep -q 'LILO'
	then
		echo; echo
		ewarn "Yes, but I couldn't find a LILO signature on ${bootpart}"
		ewarn "Check your /etc/lilo.conf, or run /sbin/lilo by hand."
		return 1
	fi

	echo " Yes, on ${bootpart}"

	return 0
}


pkg_postinst() {
	if [ ! -e ${ROOT}/boot/boot.b -a ! -L ${ROOT}/boot/boot.b ]
	then
		[ -f "${ROOT}/boot/boot-menu.b" ] && \
			ln -snf boot-menu.b ${ROOT}/boot/boot.b
	fi

	if [ "${ROOT}" = "/" ]
	then
		if lilocheck
		then
			einfo "Running LILO to complete the install ..."
			# do not redirect to /dev/null because it may display some input
			# prompt
			/sbin/lilo
			if [ "$?" -ne 0 ]
			then
				echo
				ewarn "Running /sbin/lilo failed!  Please check what the problem is"
				ewarn "before your next reboot."

				echo -ne "\a" ; sleep 1 ; echo -ne "\a" ; sleep 1 ; echo -ne "\a" ; sleep 1
				echo -ne "\a" ; sleep 1 ; echo -ne "\a" ; sleep 1 ; echo -ne "\a" ; sleep 1
				sleep 5
			fi
		fi
		echo
	fi

	echo
	einfo "Please note that all the loader files (/boot/*.b) is now linked"
	einfo "into LILO, and thus no longer installed."
	echo -ne "\a" ; sleep 1 ; echo -ne "\a" ; sleep 1 ; echo -ne "\a" ; sleep 1
	sleep 3
	echo
}

