# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/konq-plugins/konq-plugins-4.2.0.ebuild,v 1.4 2009/02/05 02:03:04 scarabeus Exp $

EAPI="2"

KMNAME="extragear/base"
KMNOMODULE="true"
KDE_MIMIMAL="4.2"
inherit kde4-base

DESCRIPTION="Various plugins for konqueror"
HOMEPAGE="http://kde.org/"
SRC_URI="mirror://kde/stable/4.2.0/src/extragear/${P}.tar.bz2"
SLOT="4.2"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="debug htmlhandbook"

RDEPEND="!kde-misc/konq-plugins
	!kdeprefix? ( !kde-base/konq-plugins:4.1[-kdeprefix] )
	>=kde-base/konqueror-${KDE_MINIMAL}
"
DEPEND="${RDEPEND}"

src_prepare() {
	if ! use htmlhandbook; then
		sed -i \
			-e "s:macro_optional_add_subdirectory(doc):#nada:g" \
			CMakeLists.txt || die "sed doc failed"
	fi
	kde4-base_src_prepare
}
