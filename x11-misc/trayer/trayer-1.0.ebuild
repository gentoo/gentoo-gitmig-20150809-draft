# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/trayer/trayer-1.0.ebuild,v 1.9 2006/05/19 17:56:06 corsair Exp $

DESCRIPTION="Lightweight GTK2-based systray for UNIX desktop"
HOMEPAGE="http://fvwm-crystal.berlios.de/"
SRC_URI="http://fvwm-crystal.berlios.de/files/versions/20050306/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc ~ppc64 sparc x86"
IUSE=""
DEPEND=">=x11-libs/gtk+-2"

src_compile() {
	emake -j1 CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	einstall PREFIX=${D}/usr || die "einstall failed"
	dodoc CHANGELOG COPYING CREDITS INSTALL README
}

