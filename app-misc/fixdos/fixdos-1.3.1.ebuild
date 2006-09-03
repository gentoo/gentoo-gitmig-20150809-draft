# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/fixdos/fixdos-1.3.1.ebuild,v 1.17 2006/09/03 19:55:31 blubb Exp $

inherit eutils

DESCRIPTION="Set of utilities such as crlf which converts files between UNIX and DOS newlines"
HOMEPAGE="http://e.co.za/marius/"
SRC_URI="http://e.co.za/marius/downloads/misc/fixDos-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE=""

DEPEND="virtual/libc"

S=${WORKDIR}/fixDos-${PV}

src_unpack() {
	unpack ${A}

	cd ${S}
	# Apply this patch to the makefile so that it builds with our
	#  desired CFLAGS.
	epatch ${FILESDIR}/${P}-gentoo-makefile.diff
}

src_compile() {
	emake || die
}

src_install() {
	make INSTALLDIR=${D}/usr/bin install || die
}
