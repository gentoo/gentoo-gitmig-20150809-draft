# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/setpwc/setpwc-0.8.ebuild,v 1.2 2005/02/06 00:46:04 blubb Exp $

DESCRIPTION="Control various aspects of Philips (and compatible) webcams"
HOMEPAGE="http://www.vanheusden.com/setpwc/"
SRC_URI="http://www.vanheusden.com/setpwc/${P}.tgz"
LICENSE="GPL-1 GPL-2"
SLOT="0"

KEYWORDS="~x86 ~amd64"

IUSE=""

DEPEND="virtual/libc
	virtual/linux-sources"

src_compile() {
	emake CPPFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" || die "emake failed"
}

src_install() {
	exeinto /usr/bin
	doexe setpwc || die "install failed"
	dodoc readme.txt
}
