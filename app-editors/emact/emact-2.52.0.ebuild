# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/emact/emact-2.52.0.ebuild,v 1.3 2008/05/01 08:49:04 opfer Exp $

DESCRIPTION="EmACT, a fork of Conroy's MicroEmacs"
HOMEPAGE="http://www.eligis.com/emacs/"
SRC_URI="http://www.eligis.com/emacs/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="X"

DEPEND="sys-libs/ncurses
	X? (
		x11-libs/libX11
		x11-libs/libICE
		x11-libs/libSM
	)"

RDEPEND="${DEPEND}"

src_compile() {
	econf $(use_with X x) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake INSTALL="${D}"/usr install || die "emake install failed"
	dodoc README || die "dodoc failed"
}
