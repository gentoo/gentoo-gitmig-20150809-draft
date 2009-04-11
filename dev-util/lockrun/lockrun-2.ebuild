# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/lockrun/lockrun-2.ebuild,v 1.5 2009/04/11 09:41:12 hollow Exp $

inherit toolchain-funcs

DESCRIPTION="Lockrun - runs cronjobs with overrun protection"
HOMEPAGE="http://www.unixwiz.net/tools/lockrun.html"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="amd64 hppa x86"
IUSE=""

RESTRICT="test"

DEPEND="virtual/libc"
RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_unpack() {
	cp "${FILESDIR}"/lockrun.c "${S}"/lockrun.c
}

src_compile() {
	$(tc-getCC) ${CFLAGS} lockrun.c -o lockrun
}

src_install () {
	dodir /usr/bin
	cp lockrun "${D}"/usr/bin
}
