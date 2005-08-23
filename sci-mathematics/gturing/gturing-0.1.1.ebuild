# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/gturing/gturing-0.1.1.ebuild,v 1.2 2005/08/23 02:47:35 ribosome Exp $

inherit eutils

DESCRIPTION="GNOME turing machine simulator"
HOMEPAGE="http://www.nuclecu.unam.mx/~arturo/gTuring/"
SRC_URI="mirror://gnome/sources/${PN}/${PV}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

DEPEND=">=gnome-base/libgnomeui-2.0.0"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gettext.patch
}

src_compile() {
	econf || die
	emake || die
}

src_install() {
	einstall || die
	dodoc README AUTHORS NEWS TODO
	insinto /usr/share/doc/${PF}/examples
	doins tapes/*.tur
}
