# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/qca-tls/qca-tls-1.0.ebuild,v 1.22 2005/07/29 22:45:05 dragonheart Exp $

inherit eutils qt3

DESCRIPTION="plugin to provide SSL/TLS capability to programs that utilize the Qt Cryptographic Architecture (QCA)"
HOMEPAGE="http://psi.affinix.com/"
SRC_URI="http://psi.affinix.com/beta/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86"
IUSE=""

DEPEND="$(qt_min_version 3.3)
	>=dev-libs/openssl-0.9.6i"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/qca-pathfix.patch
}

src_compile() {
	./configure || die "configure failed"
	sed -i \
		-e "/^CFLAGS/s:$: ${CFLAGS}:" \
		-e "/^CXXFLAGS/s:$: ${CXXFLAGS}:" \
		Makefile
	emake || die "emake failed"
}

src_install() {
	make INSTALL_ROOT="${D}" install || die "make install failed"
	insinto /usr/include
	doins qcaprovider.h qca.h qca-tls.h

	dodoc README
}
