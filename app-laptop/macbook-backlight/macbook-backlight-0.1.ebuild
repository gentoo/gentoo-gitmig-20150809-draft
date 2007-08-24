# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/macbook-backlight/macbook-backlight-0.1.ebuild,v 1.5 2007/08/24 21:39:08 cedk Exp $

inherit toolchain-funcs eutils flag-o-matic

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
	if built_with_use sys-apps/pciutils zlib ; then
		append-ldflags -lz
	fi
	emake CC=$(tc-getCC) || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" install || die "emake install failed"
	dodoc README
}
