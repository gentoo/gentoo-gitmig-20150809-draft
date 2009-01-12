# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/krusader/krusader-2.0.0_beta2-r1.ebuild,v 1.1 2009/01/12 18:33:27 scarabeus Exp $

EAPI="2"

KDE_LINGUAS="bg bs ca cs da de el es fr hu it ja ko lt nl pl pt pt_BR ru sk sl
sr sv tr uk zh_CN"
inherit kde4-base

MY_P="${P/_/-}"

DESCRIPTION="An advanced twin-panel (commander-style) file-manager for KDE with many extras."
HOMEPAGE="http://krusader.sourceforge.net/"
SRC_URI="mirror://sourceforge/krusader/${MY_P}.tar.gz"
LICENSE="GPL-2"

SLOT="2"
KEYWORDS="~amd64 ~x86"
IUSE="debug htmlhandbook"

DEPEND="!kdeprefix? ( !kde-misc/krusader:0 )
	!kde-misc/krusader:4.1
	sys-devel/gettext"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	if ! use htmlhandbook; then
		sed -i \
			-e "s:^add_subdirectory([[:space:]]doc[[:space:]]):#nodoc:g" \
			CMakeLists.txt || die "removing docs failed"
	fi
	sed -i \
		-e "s:set(CMAKE_VERBOSE_MAKEFILE[[:space:]]ON):#NADA:g" \
		CMakeLists.txt # non fatal sed :]
	kde4-base_src_prepare
}
