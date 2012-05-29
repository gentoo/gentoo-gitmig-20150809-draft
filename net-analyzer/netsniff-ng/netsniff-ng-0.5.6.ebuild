# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/netsniff-ng/netsniff-ng-0.5.6.ebuild,v 1.2 2012/05/29 20:46:01 xmw Exp $

EAPI=4

inherit cmake-utils eutils

DESCRIPTION="high performance network sniffer for packet inspection"
HOMEPAGE="http://netsniff-ng.org/"
SRC_URI="http://www.${PN}.org/pub/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

S=${WORKDIR}/${P}/src

src_prepare() {
	epatch "${FILESDIR}"/${P}-man-no-compress.patch
}

src_install() {
	cmake-utils_src_install
	dodoc ../{AUTHORS,MAINTAINER,PROJECTS,README,REPORTING-BUGS,THANKS}
}
