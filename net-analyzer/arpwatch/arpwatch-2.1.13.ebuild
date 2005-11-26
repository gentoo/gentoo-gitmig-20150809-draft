# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/arpwatch/arpwatch-2.1.13.ebuild,v 1.1 2005/11/26 18:41:07 strerror Exp $

inherit eutils

MY_P=arpwatch-2.1a13
DESCRIPTION="An ethernet monitor program that keeps track of ethernet/ip address pairings"
HOMEPAGE="http://www-nrg.ee.lbl.gov/"
SRC_URI="ftp://ftp.ee.lbl.gov/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~sparc ~x86"
IUSE="selinux"

DEPEND="virtual/libpcap
	sys-libs/ncurses"

RDEPEND="selinux? ( sec-policy/selinux-arpwatch )"

pkg_setup() {
	enewgroup arpwatch
	enewuser arpwatch -1 -1 /var/lib/arpwatch arpwatch
}

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd ${S}

	einfo "Patching arpwatch with debian and redhat patches"
	gzip -dc ${FILESDIR}/${P}.diff.gz | patch -s
}

src_compile() {
	local myconf
	myconf="${myconf} --prefix=/usr --infodir=/usr/share/info --mandir=/usr/share/man"

	#./configure \
	#	--prefix=/usr \
	#	--infodir=/usr/share/info \
	#	--mandir=/usr/share/man \
	#	|| die "./configure failed"
	econf \
	${myconf} || die "econf failed"
	emake || die "emake failed"
}

src_install () {

	dodir /var/lib/arpwatch /usr/sbin
	diropts -g arpwatch -o arpwatch
	keepdir /var/lib/arpwatch

	make DESTDIR="${D}" install || die "install failed"
	#einstall || die "einstall failed"

	doman *.8
	dodoc README CHANGES


	exeinto /var/lib/arpwatch
	exeopts -m0755 -o arpwatch -g arpwatch
	doexe arp2ethers arpfetch bihourly massagevendor massagevendor-old

	insinto /var/lib/arpwatch
	insopts -m0644 -o arpwatch -g arpwatch
	doins d.awk duplicates.awk e.awk euppertolower.awk p.awk

	insinto /usr/share/arpwatch
	insopts -m0644 -o arpwatch -g arpwatch
	doins ethercodes.dat

	newinitd "${FILESDIR}/arpwatch.init" arpwatch

	newconfd "${FILESDIR}/arpwatch.confd" arpwatch

}
pkg_postinst() {
	einfo "If you want arpwatch to at boot then type:"
	ewarn "      rc-update add arpwatch default"
}
