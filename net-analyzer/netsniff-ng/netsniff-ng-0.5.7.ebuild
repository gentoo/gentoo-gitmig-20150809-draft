# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/netsniff-ng/netsniff-ng-0.5.7.ebuild,v 1.1 2012/07/02 13:28:18 xmw Exp $

EAPI=4

inherit cmake-utils eutils vcs-snapshot

DESCRIPTION="high performance network sniffer for packet inspection"
HOMEPAGE="http://netsniff-ng.org/"
SRC_URI="https://github.com/gnumaniacs/${PN}/tarball/${PV} -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

S=${WORKDIR}/${P}/src

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.5.6-man-no-compress.patch
}

src_install() {
	cmake-utils_src_install
	dodoc ../{AUTHORS,README,REPORTING-BUGS}
}
