# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/radiusclient-ng/radiusclient-ng-0.5.6.ebuild,v 1.4 2007/11/23 17:26:33 drac Exp $

DESCRIPTION="RadiusClient NextGeneration - a library for writing RADIUS clients accompanied with several client utilities."
HOMEPAGE="http://developer.berlios.de/projects/radiusclient-ng/"
SRC_URI="http://download.berlios.de/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~ppc ~sparc x86"
IUSE=""

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc README BUGS CHANGES COPYRIGHT
	dohtml doc/instop.html
}
