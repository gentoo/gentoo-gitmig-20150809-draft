# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/libopensync-plugin-syncml/libopensync-plugin-syncml-0.39.ebuild,v 1.1 2009/11/15 22:31:27 eva Exp $

EAPI="2"

inherit cmake-utils

DESCRIPTION="OpenSync SyncML Plugin"
HOMEPAGE="http://www.opensync.org/"
SRC_URI="http://www.opensync.org/download/releases/${PV}/${P}.tar.bz2"

KEYWORDS="~amd64 ~ppc ~x86"
SLOT="0"
LICENSE="LGPL-2.1"
IUSE="http +obex"

RDEPEND="=app-pda/libopensync-${PV}*
	dev-libs/glib:2
	dev-libs/libxml2
	>=app-pda/libsyncml-0.5.0[obex?,http?]"
DEPEND="${RDEPEND}"

# FIXME: % tests passed, 2 tests failed out of 2
RESTRICT="test"

pkg_setup() {
	if ! use obex && ! use http; then
		eerror "${CATEGORY}/${P} without support for obex nor http is unusable."
		eerror "Please enable \"obex\" or/and \"http\" USE flags."
		die "Please enable \"obex\" or/and \"http\" USE flags."
	fi
}

src_configure() {
	DOCS="AUTHORS"

	local mycmakeargs="
		$(cmake-utils_use_enable http HTTP)
		$(cmake-utils_use_enable obex OBEX)"

	cmake-utils_src_configure
}
