# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeedu/kdeedu-3.4.3-r10.ebuild,v 1.2 2005/11/21 17:57:16 gustavoz Exp $

inherit kde-dist

DESCRIPTION="KDE educational apps"

KEYWORDS="~alpha ~amd64 ~ia64 ~mips ~ppc sparc ~x86"
IUSE="kig-scripting"

DEPEND="kig-scripting? ( >=dev-libs/boost-1.32 )"

src_compile() {
	local myconf="$(use_enable kig-scripting kig-python-scripting)"

	kde_src_compile
}
