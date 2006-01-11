# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kicker/kicker-3.5.0.ebuild,v 1.5 2006/01/11 20:21:38 flameeyes Exp $

KMNAME=kdebase
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE panel housing varous applets"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="xcomposite"
PATCHES="$FILESDIR/applets-configure.in.in.diff"

RDEPEND="
$(deprange $PV $MAXKDEVER kde-base/libkonq)
$(deprange $PV $MAXKDEVER kde-base/kdebase-data)
	xcomposite? ( || ( (
			x11-libs/libXcomposite
			) <=x11-base/xorg-x11-6.9 )
		)"

DEPEND="${RDEPEND}
	xcomposite? ( || ( (
			x11-proto/compositeproto
			) <=x11-base/xorg-x11-6.9 )
		)"

KMCOPYLIB="libkonq libkonq"
KMEXTRACTONLY="libkonq
	kdm/kfrontend/themer/"
KMCOMPILEONLY="kdmlib/"

PATCHES="${FILESDIR}/${P}-composite.patch"

src_compile() {
	myconf="$myconf $(use_with xcomposite composite)"
	kde-meta_src_compile
}
