# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/netselect/netselect-0.3-r1.ebuild,v 1.7 2004/10/19 10:40:35 absinthe Exp $

DESCRIPTION="Ultrafast implementation of ping."
HOMEPAGE="http://www.worldvisions.ca/~apenwarr/netselect/"
SRC_URI="http://www.worldvisions.ca/~apenwarr/netselect/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ~ppc sparc ~mips alpha ~arm hppa amd64 ~ia64 ~ppc64 ~s390"
IUSE=""

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e "s:PREFIX =.*:PREFIX = ${D}usr:" \
		-e "s:CFLAGS =.*:CFLAGS = -Wall -I. -g ${CFLAGS}:" \
		-e '23,27d' \
		-e '34d' \
		Makefile \
		|| die "sed Makefile failed"
}

src_compile() {
	emake || die "emake failed"
}

src_install () {
	make install || die "make install failed"
	fowners root:wheel /usr/bin/netselect
	fperms 4710 /usr/bin/netselect
	dodoc ChangeLog HISTORY README*
}
