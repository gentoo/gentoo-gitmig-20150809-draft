# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/ddd/ddd-3.3.8.ebuild,v 1.1 2004/02/19 01:59:16 mholzer Exp $

inherit eutils

DESCRIPTION="graphical front-end for command-line debuggers"
HOMEPAGE="http://www.gnu.org/software/ddd"
SRC_URI="mirror://sourceforge/ddd/${P}.tar.gz"
RESTRICT="nomirror"

SLOT="0"
LICENSE="GPL-2 LGPL-2.1 FDL-1.1"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~amd64"

DEPEND="virtual/x11
	>=sys-devel/gcc-3
	>=sys-devel/gdb-4.16
	x11-libs/openmotif"

src_unpack() {
	unpack ${A}
}

src_compile() {
	CXXFLAGS="${CXXFLAGS}"
	econf || die
	emake || die
}

src_install() {
	dodir /usr/lib
	# If using internal libiberty.a, need to pass
	# $tooldir to 'make install', else we get
	# sandbox errors ... bug #4614.
	# <azarah@gentoo.org> 05 Dec 2002
	einstall tooldir=${D}/usr || die

	# This one is from binutils
	[ -f ${D}/usr/lib/libiberty.a ] && rm -f ${D}/usr/lib/libiberty.a
	# Remove empty dir ...
	rmdir ${D}/usr/lib || :

	mv ${S}/doc/README ${S}/doc/README-DOC
	dodoc ANNOUNCE AUTHORS BUGS COPYING* CREDITS INSTALL NEWS* NICKNAMES \
		OPENBUGS PROBLEMS README* TIPS TODO

	mv ${S}/doc/* ${D}/usr/share/doc/${PF}
}
