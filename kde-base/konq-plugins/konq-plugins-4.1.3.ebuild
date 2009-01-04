# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/konq-plugins/konq-plugins-4.1.3.ebuild,v 1.4 2009/01/04 15:11:54 scarabeus Exp $

EAPI="2"

KDE_LINGUAS="af ar be bg bn br ca cs cy da de el en_GB eo es et eu fa fi fr fy
ga gl he hi hr hu is it ja kk km ko ku lt lv mk ml ms nds ne nl nn oc pa pl
pt pt_BR ro ru se sk sl sv ta tg th tr uk uz vi xh zh_CN zh_TW"
NEED_KDE="4.1"
inherit kde4-base

DESCRIPTION="Various plugins for konqueror"
HOMEPAGE="htts://kde.org/"
SRC_URI="mirror://kde/stable/${PV}/${KDE_PV}src/extragear/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug htmlhandbook"

RDEPEND="kde-base/konqueror:${SLOT}"
DEPEND="${RDEPEND}"

src_prepare() {
	# dont bother with translations since there is trans only for few of them.
	sed -i \
		-e "s:add_subdirectory( doc-translations ):#nada:g" \
		CMakeLists.txt || die "sed doc-trans failed"
	if ! use htmlhandbook; then
		sed -i \
			-e "s:macro_optional_add_subdirectory(doc):#nada:g" \
			-e "s:add_subdirectory( doc ):#nada:g" \
			CMakeLists.txt || die "sed doc failed"
	fi
	kde4-meta_src_prepare
}
