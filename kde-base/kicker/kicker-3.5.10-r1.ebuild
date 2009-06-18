# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kicker/kicker-3.5.10-r1.ebuild,v 1.6 2009/06/18 04:09:10 jer Exp $

KMNAME=kdebase
EAPI="1"
inherit kde-meta eutils

SRC_URI="${SRC_URI}
	mirror://gentoo/kdebase-3.5-patchset-13.tar.bz2"

DESCRIPTION="Kicker is the KDE application starter panel, also capable of some useful applets and extensions."
KEYWORDS="~alpha amd64 hppa ~ia64 ppc ppc64 ~sparc x86 ~x86-fbsd"
IUSE="kdehiddenvisibility xcomposite"

DEPEND=">=kde-base/libkonq-${PV}:${SLOT}
	>=kde-base/kdebase-data-${PV}:${SLOT}
	x11-libs/libXfixes
	x11-libs/libXrender
	x11-libs/libXtst
	xcomposite? ( x11-libs/libXcomposite )"
RDEPEND="${DEPEND}
	>=kde-base/kmenuedit-${PV}:${SLOT}"

KMCOPYLIB="libkonq libkonq"
KMEXTRACTONLY="libkonq
	kdm/kfrontend/themer/"
KMCOMPILEONLY="kdmlib/"

PATCHES=( "${FILESDIR}/${P}-graphics-glitch.patch" )

src_compile() {
	myconf="$myconf $(use_with xcomposite composite)"
	kde-meta_src_compile
}
