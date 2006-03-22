# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kwin/kwin-3.5.2.ebuild,v 1.1 2006/03/22 20:15:41 danarmak Exp $

KMNAME=kdebase
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE window manager"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
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

src_compile() {
	myconf="$myconf $(use_with xcomposite composite)"
	kde-meta_src_compile
}
