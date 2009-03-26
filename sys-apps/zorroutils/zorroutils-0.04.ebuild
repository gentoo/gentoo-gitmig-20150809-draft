# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/zorroutils/zorroutils-0.04.ebuild,v 1.1 2009/03/26 18:21:22 armin76 Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Zorro bus utility for Amigas running 2.1 and later kernels"
HOMEPAGE="http://users.telenet.be/geertu/Download/#zorro"
SRC_URI="http://users.telenet.be/geertu/Download/${P}.tar.gz"
IUSE=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="m68k ~ppc"

DEPEND=""

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}"/zorroutils-0.04-20021014.diff
	epatch "${FILESDIR}"/zorroutils-gentoo.diff
}

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" || die
}

src_install() {
#	into /
	dosbin lszorro
	doman *.8

	insinto /usr/share/misc
	doins zorro.ids
}
