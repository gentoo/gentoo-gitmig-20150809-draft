# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/cinit/cinit-0.2.1.ebuild,v 1.1 2007/09/01 19:19:45 angelos Exp $

DESCRIPTION="a fast, small and simple init with support for profiles"
HOMEPAGE="http://linux.schottelius.org/cinit/"
SRC_URI="http://linux.schottelius.org/${PN}/archives/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~x86"
IUSE="doc"

src_compile() {
	emake \
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
