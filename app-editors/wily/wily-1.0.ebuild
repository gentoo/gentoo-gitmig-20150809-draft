# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/wily/wily-1.0.ebuild,v 1.1 2003/03/11 08:45:23 absinthe Exp $

DESCRIPTION="Wily is an emulation of ACME, Plan9's hybrid window system, shell and editor for programmers."
HOMEPAGE="http://www.netlib.org/research/9libs/wily-9libs.README"
SRC_URI="ftp://www.netlib.org/research/9libs/${P/1.0/9libs}.tar.gz"
LICENSE="Artistic"
SLOT="0"
KEYWORDS="~x86"
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

