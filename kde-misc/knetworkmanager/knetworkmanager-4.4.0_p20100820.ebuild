# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/knetworkmanager/knetworkmanager-4.4.0_p20100820.ebuild,v 1.1 2010/08/20 23:49:34 tampakrap Exp $

EAPI="2"

QT_MINIMAL="4.6.0_beta"

inherit kde4-base

DESCRIPTION="KDE frontend for NetworkManager"
HOMEPAGE="http://kde.org/"
SRC_URI="http://dev.gentoo.org/~tampakrap/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE="consolekit debug +networkmanager wicd"

DEPEND="
	!kde-misc/networkmanager-applet
	>=kde-base/solid-${KDE_MINIMAL}[networkmanager?,wicd?]
	!wicd? ( >=kde-base/solid-${KDE_MINIMAL}[networkmanager] )
	>=net-misc/networkmanager-0.7
	consolekit? ( sys-auth/consolekit )
"
RDEPEND="${DEPEND}"

src_prepare() {
	kde4-base_src_prepare

	if ! use consolekit; then
		# Fix dbus policy
		sed -i \
			-e 's/at_console=".*"/group="plugdev"/' \
			"${S}/NetworkManager-kde4.conf" \
			|| die "Fixing dbus policy failed"
	fi

	sed -i -e 's/KCMUTILS/KUTILS/' "${S}/applet/CMakeLists.txt" || die "sed died"
}

src_configure() {
	mycmakeargs=(
		-DDBUS_SYSTEM_POLICY_DIR=/etc/dbus-1/system.d
	)

	kde4-base_src_configure
}
