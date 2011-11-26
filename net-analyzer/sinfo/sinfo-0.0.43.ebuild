# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/sinfo/sinfo-0.0.43.ebuild,v 1.1 2011/11/26 11:18:39 radhermit Exp $

EAPI=4

inherit eutils autotools-utils

DESCRIPTION="A monitoring tool for networked computers"
HOMEPAGE="http://www.ant.uni-bremen.de/whomes/rinas/sinfo/"
SRC_URI="http://www.ant.uni-bremen.de/whomes/rinas/${PN}/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="static-libs"

RDEPEND="dev-libs/boost
	sys-libs/ncurses"
DEPEND="${RDEPEND}
	dev-cpp/asio"

AUTOTOOLS_IN_SOURCE_BUILD=1

src_prepare() {
	epatch "${FILESDIR}"/${P}-librpc-linking.patch
	epatch "${FILESDIR}"/${P}-ncurses-m4.patch
	eautoreconf
}

src_configure() {
	econf \
		--with-ncurses \
		$(use_enable static-libs static)
}

src_install() {
	default
	remove_libtool_files

	newconfd "${FILESDIR}"/${PN}.confd ${PN}
	newinitd "${FILESDIR}"/${PN}.initd ${PN}
}
