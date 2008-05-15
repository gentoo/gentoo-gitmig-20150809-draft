# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/dolphin/dolphin-4.0.4.ebuild,v 1.1 2008/05/15 22:38:39 ingmar Exp $

EAPI="1"

KMNAME=kdebase
KMMODULE=apps/${PN}
inherit kde4-meta

DESCRIPTION="A KDE filemanager focusing on usability"
KEYWORDS="~amd64 ~x86"
IUSE="debug htmlhandbook +semantic-desktop"

DEPEND="
	>=kde-base/libkonq-${PV}:${SLOT}
	semantic-desktop? ( >=kde-base/nepomuk-${PV}:${SLOT} )"
RDEPEND="${DEPEND}"

KMEXTRA="apps/doc/${PN}"
KMLOADLIBS="libkonq"

PATCHES="${FILESDIR}/${PN}-4.0.2-make-semantic-desktop-optional.patch"

pkg_setup() {
	if use semantic-desktop; then
		KDE4_BUILT_WITH_USE_CHECK="--missing false kde-base/kdelibs:${SLOT} semantic-desktop"
	fi
	kde4-meta_pkg_setup
}

src_compile() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with semantic-desktop Nepomuk)
		$(cmake-utils_use_with semantic-desktop Soprano)"
	kde4-meta_src_compile
}
