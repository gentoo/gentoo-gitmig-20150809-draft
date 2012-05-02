# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/macbook-backlight/macbook-backlight-0.2.ebuild,v 1.3 2012/05/02 20:22:38 jdhore Exp $

inherit toolchain-funcs eutils flag-o-matic

DESCRIPTION="a tool to control the backlight intensity of macbook"
HOMEPAGE="http://dev.gentoo.org/~cedk/macbook-backlight/"
SRC_URI="http://dev.gentoo.org/~cedk/macbook-backlight/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

COMMON_DEPEND="sys-apps/pciutils"
DEPEND="virtual/pkgconfig
	$COMMON_DEPEND"
RDEPEND=$COMMON_DEPEND

src_compile() {
	emake CC=$(tc-getCC) || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" install || die "emake install failed"
	dodoc README
}
