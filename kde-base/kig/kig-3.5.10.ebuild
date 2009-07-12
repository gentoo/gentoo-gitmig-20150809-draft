# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kig/kig-3.5.10.ebuild,v 1.7 2009/07/12 10:30:21 armin76 Exp $
KMNAME=kdeedu
EAPI="1"
inherit kde-meta

DESCRIPTION="KDE Interactive Geometry tool"
KEYWORDS="alpha amd64 hppa ia64 ~mips ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="kig-scripting"
DEPEND="kig-scripting? ( >=dev-libs/boost-1.32 )"

src_compile() {
	myconf="${myconf} $(use_enable kig-scripting kig-python-scripting)"

	kde_src_compile
}
