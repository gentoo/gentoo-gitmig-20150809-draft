# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/gturing/gturing-0.1.1.ebuild,v 1.6 2004/04/25 22:47:14 agriffis Exp $

DESCRIPTION="GNOME turing machine simulator for"
HOMEPAGE="http://www.nuclecu.unam.mx/~arturo/gTuring/"
SRC_URI="mirror://gnome/sources/gturing/0.1/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64"
IUSE=""

DEPEND=">=gnome-base/libgnomeui-2.0.0"

src_compile() {
	econf || die "econf failed"
	emake || die
}

src_install() {
	einstall
	dodoc README AUTHORS NEWS TODO
}
