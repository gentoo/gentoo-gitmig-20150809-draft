# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/wily/wily-1.0.ebuild,v 1.5 2004/06/01 20:33:17 mr_bones_ Exp $

DESCRIPTION="An emulation of ACME, Plan9's hybrid window system, shell and editor for programmers."
HOMEPAGE="http://www.netlib.org/research/9libs/wily-9libs.README"
SRC_URI="ftp://www.netlib.org/research/9libs/${P/1.0/9libs}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc"
IUSE=""

DEPEND="virtual/x11
	dev-libs/9libs"

S="${WORKDIR}/${P/1.0/9libs}"

src_install() {
	einstall docdir="${D}/usr/share/doc/${P}"
	dodoc INSTALL README
	insinto /usr/share/${P}
	doins ${S}/misc/*
}

