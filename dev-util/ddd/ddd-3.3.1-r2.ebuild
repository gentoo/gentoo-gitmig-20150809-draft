# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/ddd/ddd-3.3.1-r2.ebuild,v 1.10 2003/04/23 16:13:27 vapier Exp $

DESCRIPTION="graphical front-end for command-line debuggers"
HOMEPAGE="http://www.gnu.org/software/ddd"
SRC_URI="ftp://ftp.easynet.be/gnu/ddd/${P}.tar.gz
	ftp://ftp.easynet.be/gnu/ddd/${P}-html-manual.tar.gz"

SLOT="0"
LICENSE="GPL-2 LGPL-2.1 FDL-1.1"
KEYWORDS="x86 ppc sparc "

DEPEND="virtual/x11
	>=sys-devel/gdb-4.16
	virtual/motif"

src_unpack() {
	unpack ${A}
	cd ${S}/ddd
	patch -p0 <${FILESDIR}/ddd-3.3.1-gcc3-gentoo.patch || die
}
	
src_compile() {
	CXXFLAGS="${CXXFLAGS} -Wno-deprecated"
	econf || die
	emake || die
}

src_install() {
	dodir /usr/lib
	einstall || die
	
	mv ${S}/doc/README ${S}/doc/README-DOC
	dodoc ANNOUNCE AUTHORS BUGS COPYING* CREDITS INSTALL NEWS* NICKNAMES \
		OPENBUGS PROBLEMS README* TIPS TODO
	
	mv ${S}/doc/* ${D}/usr/share/doc/${PF}
}
