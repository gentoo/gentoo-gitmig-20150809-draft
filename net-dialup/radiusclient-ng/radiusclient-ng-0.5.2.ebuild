# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/radiusclient-ng/radiusclient-ng-0.5.2.ebuild,v 1.1 2006/03/16 20:43:17 mrness Exp $

inherit eutils

DESCRIPTION="RadiusClient NextGeneration - a library for writing RADIUS clients accompanied with several client utilities."
HOMEPAGE="http://developer.berlios.de/projects/${PN}/"
SRC_URI="http://download.berlios.de/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

src_unpack() {
	unpack ${A}

	epatch "${FILESDIR}/${P}-destdir.patch"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc README BUGS CHANGES COPYRIGHT
	dohtml doc/instop.html
}
