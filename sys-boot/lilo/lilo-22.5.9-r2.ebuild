# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/lilo/lilo-22.5.9-r2.ebuild,v 1.5 2004/10/17 01:56:05 solar Exp $

inherit eutils flag-o-matic

DOLILO_V="0.2"
IUSE="devmap static"

DESCRIPTION="Standard Linux boot loader"
HOMEPAGE="http://lilo.go.dyndns.org/pub/linux/lilo/"
DOLILO_TAR="dolilo-${DOLILO_V}.tar.bz2"
SRC_URI="http://home.san.rr.com/johninsd/pub/linux/lilo/${P}.tar.gz
	ftp://metalab.unc.edu/pub/Linux/system/boot/lilo/${P}.tar.gz
	ftp://metalab.unc.edu/pub/Linux/system/boot/lilo/obsolete/${P}.tar.gz
	mirror://gentoo/${DOLILO_TAR}"

SLOT="0"
LICENSE="BSD GPL-2"
KEYWORDS="-* x86"

RDEPEND="devmap? ( >=sys-libs/device-mapper-1.00.08 )"
DEPEND="${RDEPEND}
	dev-lang/nasm
	>=sys-apps/sed-4
	>=sys-devel/bin86-0.15.5"

PROVIDE="virtual/bootloader"

src_unpack() {
	einfo
	einfo "If you want to use lilo with device mapper, please enable the"
	einfo "\"devmap\" USE flag."
	einfo

	unpack ${P}.tar.gz

	# Do not try and build the dos crap.
	sed -i -e 's|^all:.*$|all: lilo|' ${S}/Makefile

	# The bootlogo patch from SuSE linux, which was originally in
	# here, has been dropped because it's no longer compatible
	# with lilo since the 22.5.x series.
	# Quequero has done a good attempt to port the patch in bug
	# #19397, but unfortunately that breaks the timeout at boot.
	# If you can overcome these problems, a patch is very welcome.

	if use devmap; then
		# devmapper-patch (boot on evms/lvm2)
		cd ${S}; epatch ${FILESDIR}/${P}-devmapper_gentoo.patch
	fi

	cd ${S}
	unpack ${DOLILO_TAR}

	# Fixup things for glibc-2.3.3 (and later CVS versions of 2.3.2)
	epatch ${FILESDIR}/${P}-glibc233.patch
	# Fix building against 2.6 headers
	epatch ${FILESDIR}/${P}-lvm.2-6headers.patch
	# Fix creating install dirs, bug #39405
	epatch ${FILESDIR}/${P}-create-install-dirs.patch
	# Correctly document commandline options -v and -V, bug #43554
	epatch ${FILESDIR}/${P}-correct-usage-info.patch
	# Get the manpage path right
	sed -i -e s,usr/man,usr/share/man,g ${S}/Makefile
}

src_compile() {
	# hardened automatic PIC plus PIE building should be suppressed
	# because of assembler instructions that cannot be compiled PIC
	HARDENED_CFLAGS="`test_flag -fno-pic` `test_flag -nopie`"

	# we explicitly prevent the custom CFLAGS for stability reasons
	if use static; then
		emake CC="${CC:=gcc} ${HARDENED_CFLAGS}" lilo-static || die
		mv lilo-static lilo || die
	else
		emake CC="${CC:=gcc} ${HARDENED_CFLAGS}" lilo || die
	fi
}

src_install() {
	keepdir /boot
	make ROOT=${D} install || die

	into /
	dosbin ${S}/dolilo/dolilo

	into /usr
	dosbin keytab-lilo.pl

	insinto /etc
	newins ${FILESDIR}/lilo.conf lilo.conf.example

	insinto /etc/conf.d
	newins ${S}/dolilo/dolilo.conf.d dolilo.example

	doman manPages/*.[5-8]
	dodoc CHANGES COPYING INCOMPAT README*
	docinto samples ; dodoc sample/*
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

	bootpart="$(sed -n "s:^boot[ ]*=[ ]*\(.*\)[ ]*:\1:p" /etc/lilo.conf)"

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
			einfo "Running DOLILO to complete the install ..."
			# do not redirect to /dev/null because it may display some input
			# prompt
			/sbin/dolilo
			if [ "$?" -ne 0 ]
			then
				echo
				ewarn "Running /sbin/dolilo failed!  Please check what the problem is"
				ewarn "before your next reboot."

				ebeep 5
				epause 5
			fi
		fi
		echo
	fi

	echo
	einfo "Please note that all the loader files (/boot/*.b) are now linked"
	einfo "into LILO, and thus no longer installed."
	einfo "Issue 'dolilo' instead of 'lilo' to have a friendly wrapper that"
	einfo "handles mounting and unmounting /boot for you. It can do more then"
	einfo "that when asked, edit /etc/conf.d/dolilo to harness it's full potential."
	ebeep 5
	epause 3
	echo
}
