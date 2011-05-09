# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/knetworkmanager/knetworkmanager-4.4.0_p20110415.ebuild,v 1.3 2011/05/09 23:10:18 hwoarang Exp $

EAPI=4

KDE_MINIMAL="4.6"

KDE_SCM="git"
EGIT_REPONAME="networkmanagement"
[[ ${PV} = 9999* ]] || SRC_URI="mirror://gentoo/${P}.tar.xz"
[[ ${PV} = 9999* ]] || SRC_URI+=" http://dev.gentoo.org/~scarabeus/${P}.tar.xz"

inherit kde4-base

DESCRIPTION="KDE frontend for NetworkManager"
HOMEPAGE="http://kde.org/"

LICENSE="GPL-2 LGPL-2"
KEYWORDS="amd64 x86"
SLOT="4"
IUSE="consolekit debug"

DEPEND="
	net-misc/mobile-broadband-provider-info
	$(add_kdebase_dep solid 'networkmanager')
"
RDEPEND="${DEPEND}"

RESTRICT="test"

src_prepare() {
	kde4-base_src_prepare

	if ! use consolekit; then
		# Fix dbus policy
		sed -i \
			-e 's/at_console=".*"/group="plugdev"/' \
			"${S}/NetworkManager-kde4.conf" \
			|| die "Fixing dbus policy failed"
	fi
}

src_configure() {
	local mycmakeargs=(
		-DDBUS_SYSTEM_POLICY_DIR=/etc/dbus-1/system.d
	)

	kde4-base_src_configure
}
