# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/autoupnp/autoupnp-0.4.5.ebuild,v 1.1 2011/07/27 20:08:52 mgorny Exp $

EAPI=4
inherit autotools-utils

DESCRIPTION="Automatic open port forwarder using UPnP"
HOMEPAGE="https://github.com/mgorny/autoupnp/"
SRC_URI="http://cloud.github.com/downloads/mgorny/${PN}/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

# libnotify RDEP forced due to missing pthreads in this version,
# and libnotify pulls it in indirectly.

RDEPEND="net-libs/miniupnpc
	x11-libs/libnotify"
DEPEND="${RDEPEND}"

DOCS=( README )

src_prepare() {
	autotools-utils_src_prepare
}

src_install() {
	autotools-utils_src_install
	remove_libtool_files all
}
