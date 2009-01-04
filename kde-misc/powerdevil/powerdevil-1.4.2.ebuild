# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/powerdevil/powerdevil-1.4.2.ebuild,v 1.3 2009/01/04 14:51:32 scarabeus Exp $

EAPI="2"

NEED_KDE="4.1"
inherit kde4-base
MY_P="${P}-kde4.1.3"

DESCRIPTION="PowerDevil is an utility for KDE4 for Laptop Powermanagement"
HOMEPAGE="http://www.kde-apps.org/content/show.php/PowerDevil?content=85078"
SRC_URI="mirror://kde/stable/apps/KDE4.x/utils/${MY_P}.tar.bz2"

LICENSE="GPL-3"
SLOT="4.1"
KEYWORDS="~amd64 ~x86"
IUSE="htmlhandbook"

DEPEND="kde-base/systemsettings:${SLOT}
	kde-base/kscreensaver:${SLOT}
	>=kde-base/libkworkspace-4.1.2-r1"
RDEPEND="${DEPEND}"

S="${WORKDIR}"/${MY_P}

src_prepare() {
	if ! use htmlhandbook; then
		sed -i \
			-e "s:add_subdirectory(doc):#nada:g" \
			CMakeLists.txt || die "removing docs failed"
	fi
	kde4-base_src_prepare
}

src_configure() {
	local mycmakeargs
	mycmakeargs="${mycmakeargs}
		-DDBUS_INTERFACES_INSTALL_DIR=${KDEDIR}/share/dbus-1/interfaces/"

	kde4-base_src_configure
}
