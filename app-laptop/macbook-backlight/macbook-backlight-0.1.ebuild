# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/macbook-backlight/macbook-backlight-0.1.ebuild,v 1.7 2009/08/15 13:20:54 ssuominen Exp $

inherit toolchain-funcs

DESCRIPTION="a tool to control the backlight intensity of macbook"
HOMEPAGE="http://dev.gentoo.org/~cedk/macbook-backlight/"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="sys-apps/pciutils"
DEPEND=${DEPEND}

src_compile() {
	emake CC=$(tc-getCC) || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" install || die "emake install failed"
	dodoc README
}
