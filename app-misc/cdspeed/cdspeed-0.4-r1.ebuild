# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/cdspeed/cdspeed-0.4-r1.ebuild,v 1.3 2012/02/02 18:21:59 ago Exp $

EAPI="2"

inherit toolchain-funcs

DESCRIPTION="Change the speed of your CD drive"
HOMEPAGE="http://linuxfocus.org/~guido/"
SRC_URI="http://linuxfocus.org/~guido/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~hppa ~mips ~ppc ~sparc ~x86"
IUSE=""

DEPEND=">=sys-apps/sed-4"
RDEPEND=""

src_prepare() {
	sed -i Makefile \
		-e 's| -o | $(LDFLAGS)&|g' \
		|| die "sed Makefile failed"
}

src_compile() {
	emake CFLAGS="${CFLAGS} -Wall -Wno-unused" CC=$(tc-getCC) \
		|| die "emake failed"
}

src_install() {
	emake PREFIX="${D}/usr" install || die "emake install"
	dodoc README
}
