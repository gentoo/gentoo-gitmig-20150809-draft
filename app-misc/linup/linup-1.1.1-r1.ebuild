# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/linup/linup-1.1.1-r1.ebuild,v 1.10 2004/10/05 13:34:51 pvdabeel Exp $

inherit eutils

DESCRIPTION="Linux Uptime Client"
HOMEPAGE="ftp://ftp.smux.net/people/sena/linup/"
SRC_URI="ftp://ftp.smux.net/people/sena/linup/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 s390 ~sparc ~amd64 ppc"
IUSE=""

RDEPEND="virtual/libc"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/fix-uptimes-host.gz
}

src_compile() {
	emake || die "compile problem"
}

src_install() {
	dobin linup || die
	dodoc README
}

pkg_postinst() {
	einfo "Please read /usr/share/doc/${PF}/README.gz"
	einfo "on how to run linup."
}
