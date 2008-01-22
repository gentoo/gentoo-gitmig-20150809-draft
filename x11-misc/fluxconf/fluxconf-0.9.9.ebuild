# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/fluxconf/fluxconf-0.9.9.ebuild,v 1.3 2008/01/22 17:14:50 lack Exp $

WANT_AUTOMAKE="1.7"

inherit autotools eutils

DESCRIPTION="Configuration editor for fluxbox"
SRC_URI="http://devaux.fabien.free.fr/flux/${P}.tar.gz"
HOMEPAGE="http://devaux.fabien.free.fr/flux/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="nls"

RDEPEND=">=x11-libs/gtk+-2"
DEPEND="${RDEPEND}
	!>=x11-wm/fluxbox-1.0"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-asneeded.patch
	eautomake
}

src_compile() {
	econf $(use_enable nls)
	emake || die "emake failed."
}

src_install () {
	einstall || die "einstall failed."
	dodoc AUTHORS ChangeLog NEWS README TODO
}
