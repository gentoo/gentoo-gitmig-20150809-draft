# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/webcpp/webcpp-0.8.0.ebuild,v 1.1 2003/02/17 02:10:27 vapier Exp $

DESCRIPTION="converts source code into HTML file using a customizable syntax highlighting engine and colour schemes"
HOMEPAGE="http://webcpp.sourceforge.net/"
SRC_URI="mirror://sourceforge/webcpp/${P}-src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="pic"

DEPEND=""
RDEPEND="virtual/gcc
	virtual/glibc"

S=${WORKDIR}/${P}-src

src_compile() {
	econf --with-gnu-ld `use_with pic` || die
	emake || die
}

src_install() {
	einstall || die
	dodoc AUTHORS CREDITS ChangeLog README TODO
}
