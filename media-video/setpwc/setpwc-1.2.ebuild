# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/setpwc/setpwc-1.2.ebuild,v 1.6 2009/09/23 14:33:16 ssuominen Exp $

inherit toolchain-funcs

DESCRIPTION="Control various aspects of Philips (and compatible) webcams"
HOMEPAGE="http://www.vanheusden.com/setpwc/"
SRC_URI="http://www.vanheusden.com/setpwc/${P}.tgz"

LICENSE="GPL-1 GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86 ~arm"
IUSE=""

RDEPEND=""
DEPEND="sys-kernel/linux-headers"

src_compile() {
	tc-export CC
	emake CPPFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" || die "emake failed"
}

src_install() {
	dobin setpwc || die
	dodoc readme.txt
	doman setpwc.1
}
