# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nsat/nsat-1.5.ebuild,v 1.3 2003/07/13 11:30:13 aliz Exp $

IUSE="pcap X"

S=${WORKDIR}/${PN}
DESCRIPTION="Network Security Analysis Tool, an application-level network security scanner"
SRC_URI="mirror://sourceforge/nsat/${P}.tgz"
HOMEPAGE="http://nsat.sourceforge.net/"

DEPEND="pcap? ( >=net-libs/libpcap-0.7.1-r1 )
	X? ( virtual/x11 )"
RDEPEND=${DEPEND}

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

src_unpack() {
	unpack ${A}
	cd ${S}
	mv nsat.conf nsat.conf.orig
	sed "s:^#CGIFile /usr/local/share/nsat/nsat.cgi$:#CGIFile /usr/share/nsat/nsat.cgi:" \
		nsat.conf.orig > nsat.conf
}

src_compile() {
	econf || die

	# Parallel make doesn't work.
	make || die "compile problem"
}

src_install () {
	dobin nsat smb-ns
	use X && dobin tools/xnsat

	insinto /usr/share/nsat
	doins nsat.cgi

	insinto /etc/nsat
	doins nsat.conf

	dodoc README doc/LICENSE doc/CHANGES
	doman doc/nsat.8
}
