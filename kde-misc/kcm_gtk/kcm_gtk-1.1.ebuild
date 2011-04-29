# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kcm_gtk/kcm_gtk-1.1.ebuild,v 1.6 2011/04/29 14:05:35 scarabeus Exp $

EAPI=3
CMAKE_IN_SOURCE_BUILD="1"
KDE_LINGUAS="bg cs de es fr it nn ru sv tr"

inherit kde4-base

MY_PN=gtk-qt-engine

DESCRIPTION="KControl GTK+ Theme Selector"
HOMEPAGE="http://gtk-qt.ecs.soton.ac.uk"
SRC_URI="http://gtk-qt.ecs.soton.ac.uk/files/${PV}/${MY_PN}-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="amd64 ~ppc ~ppc64 x86"
IUSE=""

RDEPEND="!x11-themes/gtk-engines-qt
	x11-libs/gtk+:2"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${MY_PN}

src_prepare() {
	sed -i \
		-e "s:\${XDG_APPS_INSTALL_DIR}:${KDEDIR}/share/kde4/services/:g" \
		kcm_gtk/CMakeLists.txt || die

	sed -i \
		-e '/ADD_SUBDIRECTORY(src)/d' \
		CMakeLists.txt || die

	kde4-base_src_prepare
}
