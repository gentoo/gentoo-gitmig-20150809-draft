# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/gturing/gturing-0.1.1.ebuild,v 1.2 2002/12/18 14:28:46 vapier Exp $

DESCRIPTION="GNOME turing machine simulator for"
HOMEPAGE="http://www.nuclecu.unam.mx/~arturo/gTuring/"
SRC_URI="mirror://gnome/sources/gturing/0.1/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
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
