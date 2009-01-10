# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/cinit/cinit-0.2.1.ebuild,v 1.3 2009/01/10 17:41:42 angelos Exp $

inherit toolchain-funcs

DESCRIPTION="a fast, small and simple init with support for profiles"
HOMEPAGE="http://linux.schottelius.org/cinit/"
SRC_URI="http://linux.schottelius.org/${PN}/archives/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~x86"
IUSE="doc"

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i "/contrib+tools/d" Makefile
	sed -i "/^STRIP/s/strip.*/true/" Makefile.include
}

src_compile() {
	emake \
		CC="$(tc-getCC)" \
		LD="$(tc-getCC)" \
		OPTIMIZE="${CFLAGS}" \
		LDFLAGS="${LDFLAGS}" \
		STRIP=/bin/true \
		all || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	rm -f "${D}"/sbin/{init,shutdown,reboot}
	dodoc Changelog CHANGES CREDITS README TODO
	if use doc ; then
		dodoc -r doc
	fi
}
