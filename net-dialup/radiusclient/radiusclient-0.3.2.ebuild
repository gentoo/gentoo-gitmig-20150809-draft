# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/radiusclient/radiusclient-0.3.2.ebuild,v 1.6 2005/10/02 02:27:19 weeve Exp $

inherit eutils

DESCRIPTION="A library for writing RADIUS clients accompanied with several client utilities."
HOMEPAGE="http://freshmeat.net/projects/radiusclient/"
SRC_URI="ftp://ftp.cityline.net/pub/radiusclient/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE=""

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/pkgsysconfdir-install.patch
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc README BUGS CHANGES COPYRIGHT
	dohtml doc/instop.html
}
