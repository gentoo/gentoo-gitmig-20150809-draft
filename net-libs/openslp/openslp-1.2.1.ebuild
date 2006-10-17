# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/openslp/openslp-1.2.1.ebuild,v 1.17 2006/10/17 21:33:34 flameeyes Exp $

WANT_AUTOMAKE="1.8"
WANT_AUTOCONF="latest"

inherit libtool eutils autotools

DESCRIPTION="An open-source implementation of Service Location Protocol"
HOMEPAGE="http://www.openslp.org/"
SRC_URI="mirror://sourceforge/openslp/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""
RESTRICT="test"

DEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-fbsd.patch
	eautomake

	elibtoolize
}

src_compile() {
	econf || die
	emake -j1 || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS FAQ ChangeLog NEWS README* THANKS
	rm -rf "${D}"/usr/doc
	dohtml -r .
	newinitd "${FILESDIR}"/slpd-init slpd
}
