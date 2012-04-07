# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/netsniff-ng/netsniff-ng-0.5.6.ebuild,v 1.1 2012/04/07 09:42:58 xmw Exp $

EAPI=4

inherit cmake-utils

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

src_install() {
	cmake-utils_src_install
	dodoc ../{AUTHORS,MAINTAINER,PROJECTS,README,REPORTING-BUGS,THANKS}
}
