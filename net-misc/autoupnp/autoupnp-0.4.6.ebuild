# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/autoupnp/autoupnp-0.4.6.ebuild,v 1.2 2012/04/23 17:32:43 mgorny Exp $

EAPI=4
inherit autotools-utils

DESCRIPTION="Automatic open port forwarder using UPnP"
HOMEPAGE="https://github.com/mgorny/autoupnp/"
SRC_URI="mirror://github/mgorny/${PN}/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="libnotify"

RDEPEND="net-libs/miniupnpc
	libnotify? ( x11-libs/libtinynotify )"
DEPEND="${RDEPEND}"

DOCS=( NEWS README )

src_configure() {
	myeconfargs=(
		$(use_with libnotify)
	)

	autotools-utils_src_configure
}

src_install() {
	autotools-utils_src_install
	remove_libtool_files all
}
