# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/gturing/gturing-0.1.1.ebuild,v 1.5 2004/03/08 17:40:33 augustus Exp $

DESCRIPTION="GNOME turing machine simulator for"
HOMEPAGE="http://www.nuclecu.unam.mx/~arturo/gTuring/"
SRC_URI="mirror://gnome/sources/gturing/0.1/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64"
IUSE=""

DEPEND=">=gnome-base/libgnomeui-2.0.0"

src_compile() {
	econf
	emake || die
}

src_install() {
	einstall
	dodoc README AUTHORS NEWS TODO
}
