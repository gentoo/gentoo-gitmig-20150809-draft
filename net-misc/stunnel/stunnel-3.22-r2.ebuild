# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/stunnel/stunnel-3.22-r2.ebuild,v 1.7 2005/02/11 20:58:27 kaiowas Exp $

inherit eutils

DESCRIPTION="TLS/SSL - Port Wrapper"
SRC_URI="http://www.stunnel.org/download/stunnel/src/${P}.tar.gz"
HOMEPAGE="http://www.stunnel.org/"
DEPEND="virtual/libc >=dev-libs/openssl-0.9.6c"
RDEPEND=">=dev-libs/openssl-0.9.6c
	selinux? ( sec-policy/selinux-stunnel )"
KEYWORDS="x86 sparc "
IUSE="selinux"
LICENSE="GPL-2"
SLOT="0"

src_unpack() {
	unpack ${A}; cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.diff
	epatch ${FILESDIR}/${P}-blinding.patch
}

src_compile() {
	./configure --prefix=/usr --infodir=/usr/share/info --mandir=/usr/share/man || die
	emake || die
}

src_install() {
	into /usr
	dosbin stunnel
	dodoc FAQ README HISTORY COPYING BUGS PORTS TODO transproxy.txt
	doman stunnel.8
	dolib.so stunnel.so
}
