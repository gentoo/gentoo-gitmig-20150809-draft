# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/libopensync-plugin-irmc/libopensync-plugin-irmc-0.36.ebuild,v 1.5 2010/06/11 12:15:30 ssuominen Exp $

EAPI="2"

inherit eutils cmake-utils

DESCRIPTION="OpenSync IrMC plugin"
HOMEPAGE="http://www.opensync.org/"
SRC_URI="http://www.opensync.org/download/releases/${PV}/${P}.tar.bz2"

KEYWORDS="~amd64 ~x86"
SLOT="0"
LICENSE="GPL-2"
IUSE="+bluetooth irda"

DEPEND="=app-pda/libopensync-${PV}*
	>=dev-libs/openobex-1.0[bluetooth?,irda?]
	bluetooth? ( net-wireless/bluez )"

RDEPEND="${DEPEND}"

pkg_setup() {
	if ! use irda && ! use bluetooth; then
		eerror "${CATEGORY}/${P} without support for bluetooth nor irda is unusable."
		eerror "Please enable \"bluetooth\" or/and \"irda\" USE flags."
		die "Please enable \"bluetooth\" or/and \"irda\" USE flags."
	fi
}

src_configure() {
	local mycmakeargs="
		$(cmake-utils_use_enable bluetooth BLUETOOTH)
		$(cmake-utils_use_enable irda IRDA)"

	cmake-utils_src_configure
}
