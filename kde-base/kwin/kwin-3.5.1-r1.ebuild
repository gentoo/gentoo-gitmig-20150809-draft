# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kwin/kwin-3.5.1-r1.ebuild,v 1.2 2006/03/28 01:04:06 agriffis Exp $

KMNAME=kdebase
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE window manager"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="xcomposite"
RDEPEND="xcomposite? ( || ( (
			x11-libs/libXcomposite
			x11-libs/libXdamage
			) <=x11-base/xorg-x11-6.9 )
		)"
DEPEND="${RDEPEND}
	xcomposite? ( || ( (
			x11-proto/compositeproto
			x11-proto/damageproto
			) <=x11-base/xorg-x11-6.9 )
		)"

PATCHES="${FILESDIR}/${P}-systray.patch"

src_compile() {
	myconf="$myconf $(use_with xcomposite composite)"
	kde-meta_src_compile
}
