# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/ucspi-tcp/ucspi-tcp-0.88-r4.ebuild,v 1.8 2003/01/01 20:23:33 raker Exp $

IUSE="ssl ipv6"

S=${WORKDIR}/${P}

DESCRIPTION="Collection of tools for managing UNIX services"
SRC_URI="http://cr.yp.to/${PN}/${P}.tar.gz
	ipv6? ( http://www.fefe.de/ucspi/ucspi-tcp-0.88-ipv6.diff13.bz2 )
 	ssl? ( http://www.nrg4u.com/qmail/ucspi-tcp-ssl-20020705.patch.gz )"
HOMEPAGE="http://cr.yp.to/${PN}/"

DEPEND="virtual/glibc
	ssl? ( >=dev-libs/openssl-0.9.6g )"

SLOT="0"
KEYWORDS="x86 sparc "
LICENSE="as-is"

inherit eutils

src_unpack() {
	unpack ${A}
	cd ${S}

	if use ipv6; then 
		epatch ${WORKDIR}/ucspi-tcp-0.88-ipv6.diff13
	elif use ssl; then
		epatch ${WORKDIR}/ucspi-tcp-ssl-20020705.patch
	fi

	echo "gcc ${CFLAGS}" > conf-cc
	echo "gcc" > conf-ld
	echo "/usr/" > conf-home
}

src_compile() {
	pmake || die
}

src_install() {
	for i in tcpserver tcprules tcprulescheck argv0 recordio tcpclient *\@ tcpcat mconnect mconnect-io addcr delcr fixcrio rblsmtpd
	do
		dobin $i
	done

	dodoc CHANGES FILES README SYSDEPS TARGETS TODO VERSION
}
