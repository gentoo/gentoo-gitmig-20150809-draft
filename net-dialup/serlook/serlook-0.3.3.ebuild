# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/serlook/serlook-0.3.3.ebuild,v 1.4 2009/11/11 12:47:16 ssuominen Exp $

ARTS_REQUIRED=never
inherit kde

DESCRIPTION="tool to inspect and debug serial line data traffic"
HOMEPAGE="http://serlook.sunsite.dk/"
SRC_URI="http://serlook.sunsite.dk/${P}.tar.gz
	mirror://gentoo/kde-admindir-3.5.5.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

S="${WORKDIR}"/${PN}

DEPEND=""
RDEPEND=""

need-kde 3

src_unpack() {
	unpack ${A}
	rm -rf "${S}/admin" "${S}/configure"
	ln -s "${WORKDIR}/admin" "${S}/admin"
}

src_install() {
	kde_src_install

	# Put some icon on serlook menu, even if is ugly as hell
	dosym /usr/share/apps/serlook/pics/lo16-app-serlook.png \
		/usr/share/icons/hicolor/16x16/apps/serlook.png
	dosym /usr/share/apps/serlook/pics/lo32-app-serlook.png \
		/usr/share/icons/hicolor/32x32/apps/serlook.png
}
