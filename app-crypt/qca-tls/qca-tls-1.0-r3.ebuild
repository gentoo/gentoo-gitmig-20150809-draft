# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/qca-tls/qca-tls-1.0-r3.ebuild,v 1.3 2006/04/09 13:45:24 flameeyes Exp $

inherit eutils

DESCRIPTION="plugin to provide SSL/TLS capability to programs that utilize the Qt Cryptographic Architecture (QCA)"
HOMEPAGE="http://delta.affinix.com/qca/"
SRC_URI="http://delta.affinix.com/qca/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
#alpha amd64 and ppc64 need testing
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND=">=app-crypt/qca-1.0
	>=dev-libs/openssl-0.9.6i"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/qca-pathfix.patch
	epatch ${FILESDIR}/qca-openssl-0.9.8.patch
}

src_compile() {
	./configure || die "configure failed"
	sed -i \
		-e "/^CFLAGS/s:$: ${CFLAGS}:" \
		-e "/^CXXFLAGS/s:$: ${CXXFLAGS}:" \
		-e "/-strip/d" \
		Makefile
	emake || die "emake failed"
}

src_install() {
	make INSTALL_ROOT="${D}" install || die "make install failed"
	insinto /usr/include

	dodoc README
}
