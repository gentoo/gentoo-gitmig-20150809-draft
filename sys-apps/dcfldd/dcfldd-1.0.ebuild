# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/dcfldd/dcfldd-1.0.ebuild,v 1.1 2004/02/21 05:23:25 vapier Exp $

DESCRIPTION="Enhanced dd with md5 checksums"
HOMEPAGE="http://biatchux.dmzs.com/"
SRC_URI="mirror://sourceforge/biatchux/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	cd ${S}
	# fix multiline strings in src/dcfldd.c
	sed -i \
		-e '326s:"::' \
		-e '370s:"::' \
		-e '326,369s:\\$::' \
		-e '345s:.*:&\\n:' \
		-e '327,369s:.*$:"&":' \
		src/dcfldd.c
}

src_install() {
	make install DESTDIR=${D} || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO
}
