# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/stunnel/stunnel-3.26.ebuild,v 1.2 2003/09/12 02:59:38 vapier Exp $

inherit eutils

DESCRIPTION="TLS/SSL - Port Wrapper"
HOMEPAGE="http://www.stunnel.org/"
SRC_URI="http://www.stunnel.org/download/stunnel/src/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc alpha ppc"

RDEPEND=">=dev-libs/openssl-0.9.6c"
DEPEND="${RDEPEND}
	virtual/glibc"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.diff
}

src_compile() {
	econf || die
	emake || die
}

src_install() {
	dosbin stunnel
	dodoc FAQ README HISTORY COPYING BUGS PORTS TODO transproxy.txt
	doman stunnel.8
	dolib.so stunnel.so
}
