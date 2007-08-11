# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/macbook-backlight/macbook-backlight-0.1.ebuild,v 1.4 2007/08/11 14:37:58 beandog Exp $

inherit toolchain-funcs

DESCRIPTION="a tool to control the backlight intensity of macbook"
HOMEPAGE="http://akira.ced.homedns.org/macbook-backlight/"
SRC_URI="http://akira.ced.homedns.org/macbook-backlight/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="sys-apps/pciutils"
RDEPEND=$DEPEND

src_compile() {
	emake CC=$(tc-getCC) || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" install || die "emake install failed"
	dodoc README
}
