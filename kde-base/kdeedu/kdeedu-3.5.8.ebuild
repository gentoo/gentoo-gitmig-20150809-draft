# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeedu/kdeedu-3.5.8.ebuild,v 1.2 2007/10/23 21:19:10 jer Exp $

inherit kde-dist

DESCRIPTION="KDE educational apps"

KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="kig-scripting solver"

DEPEND="kig-scripting? ( >=dev-libs/boost-1.32 )
		solver? ( >=dev-ml/facile-1.1 )"

src_unpack() {
	kde_src_unpack

	# Fix ktouch's desktop file
	sed -i -e "s:\(Categories=.*\)Miscellaneous;:\1:" "${S}/ktouch/ktouch.desktop"
}

src_compile() {
	local myconf="$(use_enable kig-scripting kig-python-scripting)
				$(use_enable solver ocamlsolver)"

	kde_src_compile
}
