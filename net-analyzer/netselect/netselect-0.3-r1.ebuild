# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/netselect/netselect-0.3-r1.ebuild,v 1.9 2005/02/10 01:45:48 j4rg0n Exp $

inherit flag-o-matic

DESCRIPTION="Ultrafast implementation of ping."
HOMEPAGE="http://www.worldvisions.ca/~apenwarr/netselect/"
SRC_URI="http://www.worldvisions.ca/~apenwarr/netselect/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ~ppc sparc ~mips alpha ~arm hppa amd64 ~ia64 ~ppc64 ~s390 ~ppc-macos"
IUSE=""

S="${WORKDIR}/${PN}"

src_compile() {
	use ppc-macos || append-ldflags "-Wl,-z,now"

	sed -i \
		-e "s:PREFIX =.*:PREFIX = ${D}usr:" \
		-e "s:CFLAGS =.*:CFLAGS = -Wall -I. -g ${CFLAGS}:" \
		-e "s:LDFLAGS =.*:LDFLAGS = -g ${LDFLAGS}:" \
		-e '23,27d' \
		-e '34d' \
		Makefile \
		|| die "sed Makefile failed"
	if use ppc-macos; then
		sed -i -e "s:<endian.h>:<machine/endian.h>:" netselect.c || die "sed Makefile failed"
	fi

	emake || die "emake failed"
}

src_install () {
	dobin netselect || die "dobin failed"
	fowners root:wheel /usr/bin/netselect
	fperms 4710 /usr/bin/netselect
	dodoc ChangeLog HISTORY README*
}
