# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/ucspi-tcp/ucspi-tcp-0.88-r5.ebuild,v 1.10 2004/04/06 11:03:21 method Exp $

inherit eutils

DESCRIPTION="Collection of tools for managing UNIX services"
HOMEPAGE="http://cr.yp.to/ucspi-tcp.html"
SRC_URI="http://cr.yp.to/${PN}/${P}.tar.gz
	ipv6? ( http://www.fefe.de/ucspi/ucspi-tcp-0.88-ipv6.diff13.bz2 )
	ssl? ( http://www.nrg4u.com/qmail/ucspi-tcp-ssl-20020705.patch.gz )"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha hppa amd64 ia64"
IUSE="ssl ipv6 selinux"

DEPEND="virtual/glibc
	ssl? ( >=dev-libs/openssl-0.9.6g )"
RDEPEND="selinux? ( sec-policy/selinux-ucspi-tcp )"

src_unpack() {
	unpack ${A}
	cd ${S}

	if use ipv6; then
		epatch ${WORKDIR}/ucspi-tcp-0.88-ipv6.diff13
	elif use ssl; then
		epatch ${WORKDIR}/ucspi-tcp-ssl-20020705.patch
	fi
	epatch ${FILESDIR}/${PV}-errno.patch
	epatch ${FILESDIR}/${PV}-head-1.patch

	echo "gcc ${CFLAGS}" > conf-cc
	echo "gcc" > conf-ld
	echo "/usr/" > conf-home
}

src_compile() {
	pmake || die
}

src_install() {
	dobin tcpserver tcprules tcprulescheck argv0 recordio tcpclient *\@ tcpcat mconnect mconnect-io addcr delcr fixcrio rblsmtpd
	dodoc CHANGES FILES README SYSDEPS TARGETS TODO VERSION
}
