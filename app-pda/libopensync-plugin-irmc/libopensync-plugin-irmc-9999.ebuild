# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/libopensync-plugin-irmc/libopensync-plugin-irmc-9999.ebuild,v 1.1 2007/11/26 20:18:45 peper Exp $

inherit eutils cmake-utils subversion

DESCRIPTION="OpenSync IrMC plugin"
HOMEPAGE="http://www.opensync.org/"
SRC_URI=""

ESVN_REPO_URI="http://svn.opensync.org/plugins/irmc-sync"

KEYWORDS="~amd64 ~x86"
SLOT="0"
LICENSE="GPL-2"
IUSE="bluetooth irda"

DEPEND="=app-pda/libopensync-${PV}*
	>=dev-libs/openobex-1.0
	bluetooth? ( net-wireless/bluez-libs )"

RDEPEND="${DEPEND}"

pkg_setup() {
	if ! use irda && ! use bluetooth; then
		eerror "${CATEGORY}/${P} without support for bluetooth nor irda is unusable."
		eerror "Please enable \"bluetooth\" or/and \"irda\" USE flags."
		die "Please enable \"bluetoot\" or/and \"irda\" USE flags."
	fi

	if use bluetooth && ! built_with_use dev-libs/openobex bluetooth; then
		eerror "You are trying to build ${CATEGORY}/${P} with the \"bluetooth\""
		eerror "USE flag, but dev-libs/openobex was built without"
		eerror "the \"bluetooth\" USE flag."
		eerror "Please rebuild dev-libs/openobex with \"bluetooth\" USE flag."
		die "Please rebuild dev-libs/openobex with \"bluetooth\" USE flag."
	fi

	if use irda && ! built_with_use dev-libs/openobex irda; then
		eerror "You are trying to build ${CATEGORY}/${P} with the \"irda\""
		eerror "USE flag, but dev-libs/openobex was built without"
		eerror "the \"irda\" USE flag."
		eerror "Please rebuild dev-libs/openobex with \"irda\" USE flag."
		die "Please rebuild dev-libs/openobex with \"irda\" USE flag."
	fi
}

src_compile() {
	local mycmakeargs="
		$(cmake-utils_use_enable bluetooth BLUETOOTH)
		$(cmake-utils_use_enable irda IRDA)"
	
	cmake-utils_src_compile
}
