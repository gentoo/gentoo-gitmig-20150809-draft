# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/arpwatch/arpwatch-2.1.11.ebuild,v 1.4 2003/07/13 11:30:10 aliz Exp $

P=arpwatch-2.1a11
S=${WORKDIR}/$P
DESCRIPTION="An ethernet monitor program that keeps track of ethernet/ip address pairings"
SRC_URI="ftp://ftp.ee.lbl.gov/${P}.tar.gz"
HOMEPAGE="http://www-nrg.ee.lbl.gov/"
LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ~ppc"

DEPEND="net-libs/libpcap
	sys-libs/ncurses"


src_unpack() {
	unpack $A
	cd ${S}
	patch -p0 < ${FILESDIR}/${PF}-gentoo.diff
}

src_compile() {

	./configure \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		|| die "./configure failed"
	emake || die
}

src_install () {
	dodir /usr/sbin /etc /var /var/arpwatch /etc /etc/init.d
	keepdir /var/arpwatch
	make DESTDIR=${D} install || die
    exeinto /etc/init.d ; newexe ${FILESDIR}/arpwatch.init arpwatch
	
}
pkg_postinst() {
	ewarn "NOTE: if you want to run arpwatch on boot then execute"
	ewarn "      rc-update add arpwatch default                  "
}


