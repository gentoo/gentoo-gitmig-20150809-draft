# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/cinit/cinit-0.0.8.ebuild,v 1.1 2005/06/20 03:41:45 vapier Exp $

DESCRIPTION="fast executing, small and simple init with support for profiles"
HOMEPAGE="http://linux.schottelius.org/cinit/"
SRC_URI="http://linux.schottelius.org/cinit/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""

src_compile() {
	emake config.h || die "config.h failed"
	emake \
		OPTIMIZE="${CFLAGS}" \
		LDFLAGS="${LDFLAGS}" \
		STRIP=true \
		all || die "all failed"
}

src_install() {
	echo ${D} > conf/destdir # retarded build system
	dodir /sbin
	make install || die
	rm -f "${D}"/sbin/init
	dodoc Changelog README TODO
}
