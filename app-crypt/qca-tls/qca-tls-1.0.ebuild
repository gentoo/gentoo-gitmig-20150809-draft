# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/qca-tls/qca-tls-1.0.ebuild,v 1.4 2004/02/08 15:06:24 pauldv Exp $


DESCRIPTION="plugin to provide SSL/TLS capability to programs that utilize the Qt Cryptographic Architecture (QCA)"
HOMEPAGE="http://psi.affinix.com/"
SRC_URI="http://psi.affinix.com/beta/qca-tls-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ppc"

DEPEND="!ppc? ( >=x11-libs/qt-3.2.1-r3 )
	ppc? ( >=x11-libs/qt-3.0.5 )
	>=dev-libs/openssl-0.9.6i"

src_compile() {
	./configure || die "configure failed"
	sed -i \
		-e "/^CFLAGS/s:$:${CFLAGS}:" \
		-e "/^CXXFLAGS/s:$:${CXXFLAGS}:" \
		Makefile
	emake || die "emake failed"
}

src_install() {
	emake INSTALL_ROOT="${D}" install || die "make install failed"
	dodoc README
}
