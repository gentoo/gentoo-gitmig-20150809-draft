# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kig/kig-3.4.0_rc1.ebuild,v 1.4 2005/03/13 01:59:40 cryos Exp $
KMNAME=kdeedu
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="KDE Interactive Geometry tool"
KEYWORDS="~x86 ~amd64"
IUSE="python"
DEPEND="python? ( >=dev-libs/boost-1.32 )"

src_compile() {
	myconf="${myconf} $(use_enable python kig-python-scripting)"

	kde_src_compile
}
