# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nsat/nsat-1.5.ebuild,v 1.5 2003/10/28 13:39:43 aliz Exp $

IUSE="X"

S=${WORKDIR}/${PN}
DESCRIPTION="Network Security Analysis Tool, an application-level network security scanner"
SRC_URI="mirror://sourceforge/nsat/${P}.tgz"
HOMEPAGE="http://nsat.sourceforge.net/"

DEPEND="X? ( virtual/x11 dev-lang/tk )
	>=net-libs/libpcap-0.7.1-r1 "
RDEPEND=${DEPEND}

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~sparc"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${P}-configure.patch

	sed -i "s:^#CGIFile /usr/local/share/nsat/nsat.cgi$:#CGIFile /usr/share/nsat/nsat.cgi:g" \
		nsat.conf
	sed -i "s:/usr/local:/usr:g" Makefile.in
	sed -i "s:/usr/local:/usr:g" tools/xnsat
	sed -i -e "s:/usr/local/share/nsat/nsat.conf:/etc/nsat/nsat.conf:g" \
		-e "s:/usr/local/share/nsat/nsat.cgi:/usr/share/nsat/nsat.cgi:g" \
		src/lang.h
}

src_compile() {
	WANT_AUTOCONF_2_5=1
	autoconf

	econf $( use_with X x ) || die

	make|| die "compile problem"
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
