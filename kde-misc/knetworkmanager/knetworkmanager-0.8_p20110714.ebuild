# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/knetworkmanager/knetworkmanager-0.8_p20110714.ebuild,v 1.1 2011/10/14 10:08:31 scarabeus Exp $

EAPI=4

KDE_MINIMAL="4.6"
MY_PV="4.4.0_p20110714"

KDE_SCM="git"
EGIT_REPONAME="networkmanagement"
[[ ${PV} = 9999* ]] ||
SRC_URI="http://dev.gentoo.org/~dilfridge/distfiles/${PN}-${MY_PV}.tar.xz"

inherit kde4-base

DESCRIPTION="KDE frontend for NetworkManager"
HOMEPAGE="http://kde.org/"

LICENSE="GPL-2 LGPL-2"
KEYWORDS="amd64 x86"
SLOT="4"
IUSE="consolekit debug"

DEPEND="
	net-misc/mobile-broadband-provider-info
	>=net-misc/networkmanager-0.8.2-r10
	$(add_kdebase_dep solid 'networkmanager')
"
RDEPEND="${DEPEND}"

RESTRICT="test"

S="${WORKDIR}/${PN}-${MY_PV}"

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
