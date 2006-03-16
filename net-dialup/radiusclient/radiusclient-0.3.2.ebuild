# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/radiusclient/radiusclient-0.3.2.ebuild,v 1.9 2006/03/16 20:30:23 mrness Exp $

inherit eutils

DESCRIPTION="A library for writing RADIUS clients accompanied with several client utilities."
HOMEPAGE="http://freshmeat.net/projects/radiusclient/"
SRC_URI="ftp://ftp.cityline.net/pub/radiusclient/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 sparc x86"
IUSE=""

src_unpack() {
	unpack ${A}

	epatch "${FILESDIR}/pkgsysconfdir-install.patch"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc README BUGS CHANGES COPYRIGHT
	dohtml doc/instop.html
}
