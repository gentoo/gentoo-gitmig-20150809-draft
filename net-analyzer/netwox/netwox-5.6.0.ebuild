# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/netwox/netwox-5.6.0.ebuild,v 1.1 2003/12/26 02:04:06 vapier Exp $

DESCRIPTION="Toolbox of over 400 utilities for testing Ethernet/IP networks"
HOMEPAGE="http://www.laurentconstantin.com/en/netw/netwox/"
SRC_URI="http://www.laurentconstantin.com/common/netw/${PN}/download/v${PV/.*}/${P}-src.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc"

DEPEND="=net-libs/netwib-${PV}*"

S=${WORKDIR}/${P}-src

src_unpack() {
	unpack ${A}
	cd ${S}/src

	sed -i \
		-e 's:/usr/local:/usr:g' \
		-e "s:-O2:${CFLAGS}:" \
		genemake config.dat
	./genemake || die "problem creating Makefile"
}

src_compile() {
	cd src
	emake -j1 || die "compile problem"
}

src_install() {
	dodoc README.TXT doc/*.txt
	cd src
	make install DESTDIR=${D} || die
}
