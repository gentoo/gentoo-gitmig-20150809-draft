# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/arpwatch/arpwatch-2.1.11-r1.ebuild,v 1.10 2004/10/20 18:51:01 vapier Exp $

MY_P=arpwatch-2.1a11
S=${WORKDIR}/$MY_P
DESCRIPTION="An ethernet monitor program that keeps track of ethernet/ip address pairings"
HOMEPAGE="http://www-nrg.ee.lbl.gov/"
SRC_URI="ftp://ftp.ee.lbl.gov/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 hppa ~ppc ~sparc x86"
IUSE=""

DEPEND="net-libs/libpcap
	sys-libs/ncurses"

src_unpack() {
	unpack ${A}
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
