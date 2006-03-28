# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kicker/kicker-3.5.0.ebuild,v 1.7 2006/03/28 00:02:28 agriffis Exp $

KMNAME=kdebase
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

SRC_URI="${SRC_URI}
	mirror://gentoo/kdebase-${PV}-patches-1.tar.bz2"

DESCRIPTION="KDE panel housing varous applets"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
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

src_unpack() {
	unpack "kdebase-${PV}-patches-1.tar.bz2"
	kde-meta_src_unpack

	epatch "${WORKDIR}/patches/kdebase-${PV}-composite.patch"
	epatch "${WORKDIR}/patches/${P}-composite.patch"
}

src_compile() {
	myconf="$myconf $(use_with xcomposite composite)"
	kde-meta_src_compile
}
