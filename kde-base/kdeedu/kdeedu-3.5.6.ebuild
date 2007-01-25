# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeedu/kdeedu-3.5.6.ebuild,v 1.3 2007/01/25 18:54:33 flameeyes Exp $

inherit kde-dist

DESCRIPTION="KDE educational apps"

KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="kig-scripting"

DEPEND="kig-scripting? ( >=dev-libs/boost-1.32 )"

src_compile() {
	local myconf="$(use_enable kig-scripting kig-python-scripting)
	              --disable-ocamlsolver"

	kde_src_compile
}
