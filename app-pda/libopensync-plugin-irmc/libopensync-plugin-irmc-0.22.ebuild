# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/libopensync-plugin-irmc/libopensync-plugin-irmc-0.22.ebuild,v 1.1 2007/03/28 20:19:36 peper Exp $

inherit eutils

DESCRIPTION="OpenSync IrMC plugin"
HOMEPAGE="http://www.opensync.org/"
SRC_URI="http://dev.gentooexperimental.org/~peper/distfiles/${P}.tar.bz2"

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
	econf \
		$(use_enable bluetooth) \
		$(use_enable irda) \
		|| die "econf failed"

	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog COPYING NEWS README
}
