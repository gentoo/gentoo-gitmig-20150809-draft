# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/lilo/lilo-22.5.1.ebuild,v 1.3 2004/01/19 18:35:20 azarah Exp $

inherit mount-boot eutils

S="${WORKDIR}/${P}"
DESCRIPTION="Standard Linux boot loader"
SRC_URI="http://home.san.rr.com/johninsd/pub/linux/lilo/obsolete/${P}.tar.gz"
HOMEPAGE="http://brun.dyndns.org/pub/linux/lilo/"

SLOT="0"
LICENSE="BSD GPL-2"
KEYWORDS="-* x86"

DEPEND=">=sys-apps/sed-4
	dev-lang/nasm
	>=sys-devel/bin86-0.15.5"

PROVIDE="virtual/bootloader"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Get all the loaders to install
	sed -i 's:# $(BOOTS): $(BOOTS):' Makefile
}

src_compile() {
	[ -z "${CC}" ] && CC="gcc"

	# http://www.gentoo.org/proj/en/hardened/etdyn-ssp.xml
	if has_version 'sys-devel/hardened-gcc' && [ "${CC}" = "gcc" ]
	then
		CC="${CC} -yet_exec"
	fi

	emake CC="${CC}" OPT="-O1" || die
}

src_install() {
	into /
	dosbin lilo activate mkrescue
	into /usr
	dosbin keytab-lilo.pl

	dodir /boot
	insinto /boot
	doins boot-text.b boot-menu.b boot-bmp.b chain.b mbr.b os2_d.b

	insinto /etc
	newins ${FILESDIR}/lilo.conf lilo.conf.example

	doman manPages/*.[5-8]
	dodoc CHANGES COPYING INCOMPAT README*
	docinto samples ; dodoc sample/*
}

pkg_preinst() {
	mount-boot_mount_boot_partition

	if [ ! -L ${ROOT}/boot/boot.b -a -f ${ROOT}/boot/boot.b ]
	then
		einfo "Saving old boot.b..."
		mv -f ${ROOT}/boot/boot.b ${ROOT}/boot/boot.old
	fi

	if [ ! -L ${ROOT}/boot/boot-text.b -a -f ${ROOT}/boot/boot-text.b ]
	then
		einfo "Saving old boot-text.b..."
		mv -f ${ROOT}/boot/boot-text.b ${ROOT}/boot/boot-text.old
	fi

	if [ ! -L ${ROOT}/boot/boot-menu.b -a -f ${ROOT}/boot/boot-menu.b ]
	then
		einfo "Saving old boot-menu.b..."
		mv -f ${ROOT}/boot/boot-menu.b ${ROOT}/boot/boot-menu.old
	fi

	if [ ! -L ${ROOT}/boot/boot-bmp.b -a -f ${ROOT}/boot/boot-bmp.b ]
	then
		einfo "Saving old boot-bmp.b..."
		mv -f ${ROOT}/boot/boot-bmp.b ${ROOT}/boot/boot-bmp.old
	fi

	if [ ! -L ${ROOT}/boot/chain.b -a -f ${ROOT}/boot/chain.b ]
	then
		einfo "Saving old chain.b..."
		mv -f ${ROOT}/boot/chain.b ${ROOT}/boot/chain.old
	fi

	if [ ! -L ${ROOT}/boot/mbr.b -a -f ${ROOT}/boot/mbr.b ]
	then
		einfo "Saving old mbr.b..."
		mv -f ${ROOT}/boot/mbr.b ${ROOT}/boot/mbr.old
	fi

	if [ ! -L ${ROOT}/boot/os2_d.b -a -f ${ROOT}/boot/os2_d.b ]
	then
		einfo "Saving old os2_d.b..."
		mv -f ${ROOT}/boot/os2_d.b ${ROOT}/boot/os2_d.old
	fi
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
		ln -snf boot-menu.b ${ROOT}/boot/boot.b
	fi

	if [ "${ROOT}" = "/" ]
	then
		if lilocheck
		then
			einfo "Running LILO to complete the install ..."
			/sbin/lilo &> /dev/null
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
}

