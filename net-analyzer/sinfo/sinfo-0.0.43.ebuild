# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/sinfo/sinfo-0.0.43.ebuild,v 1.4 2011/11/27 15:58:44 radhermit Exp $

EAPI=4

inherit autotools-utils

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

DOCS=( AUTHORS ChangeLog README )

PATCHES=(
	"${FILESDIR}"/${P}-librpc-linking.patch
	"${FILESDIR}"/${P}-ncurses-m4.patch
)

src_prepare() {
	autotools-utils_src_prepare
	eautoreconf
}

src_configure() {
	local myeconfargs=(
		--with-ncurses
	)
	autotools-utils_src_configure
}

src_install() {
	autotools-utils_src_install

	newconfd "${FILESDIR}"/${PN}.confd ${PN}
	newinitd "${FILESDIR}"/${PN}.initd ${PN}
}
