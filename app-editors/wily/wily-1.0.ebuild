# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/wily/wily-1.0.ebuild,v 1.3 2003/09/05 23:09:10 msterret Exp $

DESCRIPTION="Wily is an emulation of ACME, Plan9's hybrid window system, shell and editor for programmers."
HOMEPAGE="http://www.netlib.org/research/9libs/wily-9libs.README"
SRC_URI="ftp://www.netlib.org/research/9libs/${P/1.0/9libs}.tar.gz"
LICENSE="Artistic"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc"
IUSE="X"
DEPEND="virtual/x11 dev-libs/9libs"
RDEPEND="${DEPEND}"
S="${WORKDIR}/${P/1.0/9libs}"

src_compile() {
	econf || die
	#./configure --prefix=/usr --host=${CHOST} --with-9libs=/usr/lib/9libs || die
	emake || die
}

src_install() {
	einstall docdir=${D}/usr/share/doc/${P}
	dodoc INSTALL README
	dodir /usr/share/${P}
	insinto /usr/share/${P}
	doins ${S}/misc/*
}

