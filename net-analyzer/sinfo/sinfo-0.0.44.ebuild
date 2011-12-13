# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/sinfo/sinfo-0.0.44.ebuild,v 1.1 2011/12/13 21:05:46 radhermit Exp $

EAPI="4"

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

src_configure() {
	local myeconfargs=(
		--with-ncurses
	)
	autotools-utils_src_configure
}

src_install() {
	autotools-utils_src_install

	newconfd "${FILESDIR}"/sinfod.confd sinfod
	newinitd "${FILESDIR}"/sinfod.initd sinfod
}
