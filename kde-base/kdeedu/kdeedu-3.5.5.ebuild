# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeedu/kdeedu-3.5.5.ebuild,v 1.9 2006/12/11 11:20:14 kloeri Exp $

inherit kde-dist

DESCRIPTION="KDE educational apps"

KEYWORDS="alpha amd64 hppa ia64 ~mips ppc ppc64 sparc x86"
IUSE="kig-scripting"

DEPEND="kig-scripting? ( >=dev-libs/boost-1.32 )"

src_compile() {
	local myconf="$(use_enable kig-scripting kig-python-scripting)
	              --disable-ocamlsolver"

	kde_src_compile
}
