# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/fixdos/fixdos-1.3.1.ebuild,v 1.1 2002/05/27 01:02:11 rphillips Exp $

DESCRIPTION="Set of utilities such as crlf which converts files between UNIX and DOS newlines."
HOMEPAGE="http://e.co.za/marius/"
LICENSE="GPL-2"
DEPEND="virtual/glibc"
SRC_URI="http://e.co.za/marius/downloads/misc/fixDos-${PV}.tar.gz"
S=${WORKDIR}/fixDos-${PV}

src_unpack() {
	unpack ${A}

	cd ${S}
	# Apply this patch to the makefile so that it builds with our
	#  desired CFLAGS.
	patch < ${FILESDIR}/${P}-gentoo-makefile.diff
}

src_compile() {
	emake || die
}

src_install () {
	make INSTALLDIR=${D}/usr/bin install || die
}
