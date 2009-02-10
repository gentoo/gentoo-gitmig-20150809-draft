# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/serlook/serlook-0.3.3-r1.ebuild,v 1.1 2009/02/10 23:33:40 carlo Exp $

ARTS_REQUIRED="never"

inherit kde

DESCRIPTION="Serlook is a tool to inspect and debug serial line data traffic."
HOMEPAGE="http://serlook.sunsite.dk/"
SRC_URI="http://serlook.sunsite.dk/${P}.tar.gz
	mirror://gentoo/kde-admindir-3.5.5.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

S="${WORKDIR}/serlook"

DEPEND=""
RDEPEND=""

need-kde 3.5

PATCHES=(
	"${FILESDIR}/serlook-0.3.3-gcc43.diff"
	"${FILESDIR}/serlook-0.3.3-desktop-file.diff"
	)

src_install() {
	kde_src_install

	# Put some icon on serlook menu, even if is ugly as hell
	dosym /usr/share/apps/serlook/pics/lo16-app-serlook.png \
		/usr/share/icons/hicolor/16x16/apps/serlook.png
	dosym /usr/share/apps/serlook/pics/lo32-app-serlook.png \
		/usr/share/icons/hicolor/32x32/apps/serlook.png
}
