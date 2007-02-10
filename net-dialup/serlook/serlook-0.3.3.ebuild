# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/serlook/serlook-0.3.3.ebuild,v 1.1 2007/02/10 11:34:33 mrness Exp $

inherit kde

DESCRIPTION="tool to inspect and debug serial line data traffic"
HOMEPAGE="http://serlook.sunsite.dk/"
SRC_URI="http://serlook.sunsite.dk/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

S="${WORKDIR}"/${PN}

DEPEND="kde-base/unsermake"
RDEPEND=""

UNSERMAKE="/usr/kde/unsermake/unsermake"
need-kde 3

src_install() {
	kde_src_install

	# Put some icon on serlook menu, even if is ugly as hell
	dosym /usr/share/apps/serlook/pics/lo16-app-serlook.png \
		/usr/share/icons/hicolor/16x16/apps/serlook.png
	dosym /usr/share/apps/serlook/pics/lo32-app-serlook.png \
		/usr/share/icons/hicolor/32x32/apps/serlook.png
}
