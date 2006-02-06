# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/arpwatch/arpwatch-2.1.13-r3.ebuild,v 1.1 2006/02/06 00:36:58 jokey Exp $

inherit eutils versionator

#MY_P=${PN}-${PV%.*}a${PV##*.}
MY_P="${PN}-$(replace_version_separator 2 'a')"
DESCRIPTION="An ethernet monitor program that keeps track of ethernet/ip address pairings"
HOMEPAGE="http://www-nrg.ee.lbl.gov/"
SRC_URI="ftp://ftp.ee.lbl.gov/${MY_P}.tar.gz
	mirror://gentoo/${P}.diff.gz"

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

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	einfo "Patching arpwatch with debian and redhat patches"
	gzip -dc "${DISTDIR}"/${P}.diff.gz | patch -s

	epatch ${FILESDIR}/${P}-lostparams.patch
}

src_compile() {
	local myconf
	myconf="${myconf} --prefix=/usr --infodir=/usr/share/info --mandir=/usr/share/man"

	econf \
	${myconf} || die "econf failed"
	emake || die "emake failed"
}

src_install () {

	dodir /var/lib/arpwatch /usr/sbin
	diropts -g arpwatch -o arpwatch
	keepdir /var/lib/arpwatch

	make DESTDIR="${D}" install || die "install failed"
	doman *.8
	dodoc README CHANGES

	exeinto /usr/share/doc/${PF}/
	exeopts -m0755 -o arpwatch -g arpwatch
	doexe arp2ethers arpfetch bihourly massagevendor massagevendor-old

	insinto /usr/share/doc/${PF}/
	insopts -m0644 -o arpwatch -g arpwatch
	doins d.awk duplicates.awk e.awk euppertolower.awk p.awk

	insinto /usr/share/arpwatch
	insopts -m0644 -o arpwatch -g arpwatch
	doins ethercodes.dat

	newinitd "${FILESDIR}/arpwatch.init" arpwatch

	newconfd "${FILESDIR}/arpwatch.confd" arpwatch
}

pkg_postinst() {
	einfo "If you want arpwatch to start at boot then type:"
	einfo "      rc-update add arpwatch default"
	einfo "To enable arpwatch to run as a user please uncomment"
	einfo "the appropriate line in /etc/conf.d/arpwatch"
	einfo "Some scripts that come with the package are in:"
	einfo "/usr/share/doc/${PF}/"
}
