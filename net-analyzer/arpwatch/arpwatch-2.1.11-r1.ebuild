# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/arpwatch/arpwatch-2.1.11-r1.ebuild,v 1.7 2004/03/21 18:09:08 weeve Exp $

MY_P=arpwatch-2.1a11
S=${WORKDIR}/$MY_P
DESCRIPTION="An ethernet monitor program that keeps track of ethernet/ip address pairings"
SRC_URI="ftp://ftp.ee.lbl.gov/${MY_P}.tar.gz"
HOMEPAGE="http://www-nrg.ee.lbl.gov/"
LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ~ppc amd64 ~sparc"

DEPEND="net-libs/libpcap
	sys-libs/ncurses"


src_unpack() {
	unpack $A
	cd ${S}

	einfo "Patching arpwatch with debian and redhat patches"
	gzip -dc ${FILESDIR}/${P}-r1.diff.gz | patch -s
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
	dodir /var/arpwatch /usr/sbin
	keepdir /var/arpwatch

	make DESTDIR=${D} install || die

	doman *.8

	exeinto /var/arpwatch
	doexe arp2ethers arpfetch bihourly massagevendor massagevendor-old

	insinto /var/arpwatch
	doins d.awk duplicates.awk e.awk euppertolower.awk p.awk

	insinto /usr/share/arpwatch
	doins ethercodes.dat

	dodoc README CHANGES
	exeinto /etc/init.d ; newexe ${FILESDIR}/arpwatch.init arpwatch

	insinto /etc/conf.d
	newins ${FILESDIR}/arpwatch.confd arpwatch

}
pkg_postinst() {
	ewarn "NOTE: if you want to run arpwatch on boot then execute"
	ewarn "      rc-update add arpwatch default                  "
}
