# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kig/kig-3.4.0_rc1.ebuild,v 1.2 2005/02/28 14:13:34 greg_g Exp $
KMNAME=kdeedu
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="KDE Interactive Geometry tool"
KEYWORDS="~x86"
IUSE="python"
DEPEND="python? ( >=dev-libs/boost-1.31 )"

src_compile() {
	myconf="${myconf} $(use_enable python kig-python-scripting)"

	kde_src_compile
}
