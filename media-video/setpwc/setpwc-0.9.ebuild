# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/setpwc/setpwc-0.9.ebuild,v 1.3 2005/07/28 11:09:45 dholm Exp $

DESCRIPTION="Control various aspects of Philips (and compatible) webcams"
HOMEPAGE="http://www.vanheusden.com/setpwc/"
SRC_URI="http://www.vanheusden.com/setpwc/${P}.tgz"
LICENSE="GPL-1 GPL-2"
SLOT="0"

KEYWORDS="~amd64 ~ppc x86"

IUSE=""

RDEPEND="virtual/libc"

DEPEND="${RDEPEND}
	sys-kernel/linux-headers"

src_compile() {
	emake CPPFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" || die "emake failed"
}

src_install() {
	exeinto /usr/bin
	doexe setpwc || die "install failed"
	dodoc readme.txt
}
