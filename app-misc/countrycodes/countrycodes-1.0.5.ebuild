# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/countrycodes/countrycodes-1.0.5.ebuild,v 1.2 2004/04/10 09:43:54 mr_bones_ Exp $

DESCRIPTION="An ISO 3166 country code finder."
HOMEPAGE="http://www.grigna.com/diego/linux/countrycodes/"
SRC_URI="http://www.grigna.com/diego/linux/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="virtual/glibc"
DEPEND="${RDEPEND}
	sys-apps/sed"

src_compile() {
	emake -C src $MAKEOPTS CCOPTS="$CFLAGS" || die "emake failed"
}

src_install () {
	dodir /usr/bin /usr/share/man/man1
	make \
		-C src \
		prefix="${D}/usr" \
		mandir="${D}/usr/share/man/man1" install || die "make install failed"
	dosym iso3166 /usr/bin/countrycodes
	dosym iso3166.1 /usr/share/man/man1/countrycodes
	dodoc doc/{Changelog,README}
	prepman
}
