# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/qca-tls/qca-tls-1.0.ebuild,v 1.1 2004/01/03 17:29:11 vapier Exp $


DESCRIPTION="plugin to provide SSL/TLS capability to programs that utilize the Qt Cryptographic Architecture (QCA)"
HOMEPAGE="http://psi.affinix.com/"
SRC_URI="http://psi.affinix.com/beta/qca-tls-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND=">=x11-libs/qt-3.1.2-r4
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
