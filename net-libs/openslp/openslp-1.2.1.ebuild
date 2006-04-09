# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/openslp/openslp-1.2.1.ebuild,v 1.14 2006/04/09 13:44:26 flameeyes Exp $

inherit gnuconfig libtool eutils autotools

DESCRIPTION="An open-source implementation of Service Location Protocol"
HOMEPAGE="http://www.openslp.org/"
SRC_URI="mirror://sourceforge/openslp/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sh sparc x86"
IUSE=""

DEPEND="virtual/libc"
MAKEOPTS="${MAKEOPTS} -j1"

src_unpack() {
	unpack ${A}
	# needed at least by alpha and amd64
	cd ${S}
	gnuconfig_update

	epatch "${FILESDIR}/${P}-fbsd.patch"
	eautomake

	elibtoolize
}

src_compile() {
	econf
	emake || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS FAQ ChangeLog NEWS README* THANKS
	rm -rf ${D}/usr/doc
	dohtml -r .
	exeinto /etc/init.d
	newexe ${FILESDIR}/slpd-init slpd
}

src_test() {
	return
}
