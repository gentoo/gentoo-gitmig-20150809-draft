# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kig/kig-3.4.3.ebuild,v 1.3 2005/10/23 22:33:54 carlo Exp $
KMNAME=kdeedu
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="KDE Interactive Geometry tool"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
#IUSE="kig-scripting"
IUSE=""

# Waiting for stabilization.
#DEPEND="kig-scripting? ( >=dev-libs/boost-1.32 )"

src_compile() {
	#myconf="${myconf} $(use_enable kig-scripting kig-python-scripting)"
	myconf="${myconf} --disable-kig-python-scripting"

	kde_src_compile
}
