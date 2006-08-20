# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xcompmgr/xcompmgr-1.1.3.ebuild,v 1.3 2006/08/20 21:55:13 dberkholz Exp $

inherit eutils

IUSE=""

DESCRIPTION="X Compositing manager"
HOMEPAGE="http://freedesktop.org/Software/xapps"
SRC_URI="http://xapps.freedesktop.org/release/${P}.tar.gz"

SLOT="0"
LICENSE="BSD"
KEYWORDS="~amd64 ppc ~sparc x86"

RDEPEND="|| ( (
			x11-libs/libXrender
			x11-libs/libXfixes
			x11-libs/libXdamage
			x11-libs/libXcomposite
			)
			virtual/x11
		)"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	!<x11-base/xorg-x11-6.8.0"

src_install() {
	make DESTDIR=${D} install || die
	dodoc ChangeLog
}
