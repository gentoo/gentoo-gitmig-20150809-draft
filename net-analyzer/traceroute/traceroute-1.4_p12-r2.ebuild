# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/traceroute/traceroute-1.4_p12-r2.ebuild,v 1.3 2004/02/12 04:00:25 vapier Exp $

inherit eutils gnuconfig

MY_P=${PN}-1.4a12
S=${WORKDIR}/${MY_P}
DESCRIPTION="Utility to trace the route of IP packets"
HOMEPAGE="http://ee.lbl.gov/"
SRC_URI="ftp://ee.lbl.gov/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ppc sparc mips alpha arm amd64"

RDEPEND="virtual/glibc"
DEPEND="${RDEPEND}
	sys-devel/autoconf
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}
	use sparc && epatch ${FILESDIR}/traceroute-1.4a12.patch
	epatch ${FILESDIR}/traceroute-1.4-target-resolv.patch
}

src_compile() {
	# fixes bug #21122
	# -taviso
	use alpha && gnuconfig_update
	use amd64 && gnuconfig_update

	# assume linux by default #26699
	# -taviso
	sed -i 's/t="generic"/t="linux"/g' ${S}/configure.in
	autoreconf

	econf || die
	emake || die
}

src_install () {
	dodir /usr/sbin
	make DESTDIR=${D} install || die
	fperms 4710 /usr/sbin/traceroute
	fowners root:wheel /usr/sbin/traceroute

	doman traceroute.8
	dodoc CHANGES INSTALL
}
