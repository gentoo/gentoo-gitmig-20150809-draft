# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/traceroute/traceroute-1.4_p12-r1.ebuild,v 1.5 2003/11/14 15:53:53 aliz Exp $

inherit eutils gnuconfig

MY_P=${PN}-1.4a12
S=${WORKDIR}/${MY_P}
DESCRIPTION="Utility to trace the route of IP packets"
SRC_URI="ftp://ee.lbl.gov/${MY_P}.tar.gz"
HOMEPAGE="http://ee.lbl.gov/"

SLOT="0"
LICENSE="BSD"
KEYWORDS="x86 alpha sparc ~mips ~amd64"

RDEPEND="virtual/glibc"
DEPEND="${RDEPEND}
	sys-devel/autoconf
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A} ; cd ${S}

	if use  > /dev/null || use sparc > /dev/null
	then
		epatch ${FILESDIR}/traceroute-1.4a12.patch
	fi

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

	econf --sbindir=/usr/bin || die
	emake || die
}

src_install () {
	dodir /usr/bin
	make DESTDIR=${D} install || die

	doman traceroute.8
	dodoc CHANGES INSTALL
}
