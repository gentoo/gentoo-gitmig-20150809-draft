# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/ucspi-tcp/ucspi-tcp-0.88-r7.ebuild,v 1.3 2004/02/18 14:13:46 agriffis Exp $

inherit eutils gcc

DESCRIPTION="Collection of tools for managing UNIX services"
HOMEPAGE="http://cr.yp.to/ucspi-tcp.html"
SRC_URI="http://cr.yp.to/${PN}/${P}.tar.gz
	ipv6? ( http://www.fefe.de/ucspi/ucspi-tcp-0.88-ipv6.diff13.bz2 )
	ssl? ( http://www.nrg4u.com/qmail/ucspi-tcp-ssl-20020705.patch.gz )
	mirror://qmail/ucspi-rss.diff"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~sparc ~ppc ~alpha ~ia64"
IUSE="ssl ipv6"

DEPEND="virtual/glibc
	ssl? ( >=dev-libs/openssl-0.9.6g )"

src_unpack() {
	unpack ${A}
	cd ${S}
	if use ipv6; then
		epatch ${WORKDIR}/ucspi-tcp-0.88-ipv6.diff13
	elif use ssl; then
		epatch ${WORKDIR}/ucspi-tcp-ssl-20020705.patch
	fi
	epatch ${FILESDIR}/${PV}-errno.patch
	epatch ${DISTDIR}/ucspi-rss.diff
	epatch ${FILESDIR}/${PV}-head-1.patch

	echo "$(gcc-getCC) ${CFLAGS}" > conf-cc
	echo "$(gcc-getCC) ${LDFLAGS}" > conf-ld
	echo "/usr/" > conf-home

	# allow larger responses
	sed -i 's|if (text.len > 200) text.len = 200;|if (text.len > 500) text.len = 500;|g' ${S}/rblsmtpd.c
}

src_compile() {
	pmake || die
}

src_install() {
	dobin tcpserver tcprules tcprulescheck argv0 recordio tcpclient *\@ tcpcat mconnect mconnect-io addcr delcr fixcrio rblsmtpd
	doman *.[15]
	dodoc CHANGES FILES README SYSDEPS TARGETS TODO VERSION
}
