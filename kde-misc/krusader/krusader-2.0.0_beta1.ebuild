# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/krusader/krusader-2.0.0_beta1.ebuild,v 1.2 2008/11/24 17:38:39 scarabeus Exp $

EAPI="2"

NEED_KDE=":4.1"
KDE_LINGUAS="bg bs ca cs da de el es fr hu it ja lt nl pl pt pt_BR ru sk sl sr
sv tr uk zh_CN"
inherit kde4-base

MY_P="${P/_/-}"

DESCRIPTION="An advanced twin-panel (commander-style) file-manager for KDE with many extras."
HOMEPAGE="http://krusader.sourceforge.net/"
SRC_URI="mirror://sourceforge/krusader/${MY_P}.tar.gz"
LICENSE="GPL-2"

SLOT="2"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="!kdeprefix? ( !kde-misc/krusader:0 )
	sys-devel/gettext"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	sed -i \
		-e "s:set(CMAKE_VERBOSE_MAKEFILE ON):#NADA:g" \
		CMakeLists.txt
}
