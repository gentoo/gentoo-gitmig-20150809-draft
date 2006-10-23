# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/gtk2mp/gtk2mp-0.8.0.ebuild,v 1.7 2006/10/23 04:54:18 omp Exp $

DESCRIPTION="A GTK2 frontend to Music Player Daemon (MPD)"
HOMEPAGE="http://www.moviegalaxy.com.ar/gtk2mp/"
SRC_URI="http://www.moviegalaxy.com.ar/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.0"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	einstall || die "einstall failed"
	dodoc TODO
}
