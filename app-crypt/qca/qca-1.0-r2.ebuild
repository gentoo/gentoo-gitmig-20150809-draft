# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/qca/qca-1.0-r2.ebuild,v 1.5 2005/03/26 20:01:55 kloeri Exp $

inherit eutils

DESCRIPTION="Qt Cryptographic Architecture (QCA)"
HOMEPAGE="http://delta.affinix.com/qca/"
SRC_URI="http://delta.affinix.com/qca/qca-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc sparc x86 ~mips"
IUSE=""

DEPEND=">=x11-libs/qt-3.3.0-r1"
RDEPEND=" ssl? ( app-crypt/qca-tls ) "

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/qca-pathfix.patch || die "bad patch"
}

src_compile() {
	./configure --prefix=/usr || die "configure failed"
	sed -i \
		-e "/^CFLAGS/s:$: ${CFLAGS}:" \
		-e "/^CXXFLAGS/s:$: ${CXXFLAGS}:" \
		Makefile
	emake || die "emake failed"
}

src_install() {
	make INSTALL_ROOT="${D}" install || die "make install failed"
	if [ "$(get_libdir)" != "lib" ]; then
		mv ${D}/usr/lib ${D}/usr/$(get_libdir)
	fi
}
