# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/fluxconf/fluxconf-0.6.ebuild,v 1.12 2004/07/15 00:52:23 agriffis Exp $

DESCRIPTION="Configuration editor for fluxbox"
SRC_URI="http://devaux.fabien.free.fr/flux/${P}.tar.bz2"
HOMEPAGE="http://devaux.fabien.free.fr/flux/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc "
IUSE=""

DEPEND="=x11-libs/gtk+-1.2*"



src_compile() {

	emake || die
}

src_install () {

	dobin fluxconf fluxkeys || die

}
