# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Ben Lutgens <lamer@gentoo.org>, Ferry Meyndert <m0rpheus@poseidon.mine.nu>, Bruce A. Locke <blocke@shivan.org>
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/sniffit/sniffit-0.3.7.ebuild,v 1.1 2002/01/29 05:04:30 blocke Exp $

P=sniffit.0.3.7.beta
S=${WORKDIR}/${P}
DESCRIPTION="Interactive Packet Sniffer"
SRC_URI="http://reptile.rug.ac.be/~coder/sniffit/files/${P}.tar.gz
	 http://www.clan-tva.com/m0rpheus/sniffit_0.3.7.beta-10.diff"
HOMEPAGE="http://reptile.rug.ac.be/~coder/sniffit/sniffit.html"

DEPEND=">=net-libs/libpcap-0.6.2 >=sys-libs/ncurses-5.2"

src_unpack() {
	unpack ${P}.tar.gz
	cd ${S}
	patch < ${DISTDIR}/sniffit_0.3.7.beta-10.diff || die
}

src_compile() {
	./configure --infodir=/usr/share/info --mandir=/usr/share/man --prefix=/usr --host=${CHOST} || die

	emake OBJ_FLAG="-w -c ${CFLAGS}" EXE_FLAG="-w ${CFLAGS} -o sniffit" || die
}

src_install () {
	 dobin sniffit
	 doman sniffit.5 sniffit.8
	 dodoc README.FIRST PLUGIN-HOWTO
}

