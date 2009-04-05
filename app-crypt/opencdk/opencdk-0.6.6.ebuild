# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/opencdk/opencdk-0.6.6.ebuild,v 1.10 2009/04/05 19:04:04 arfrever Exp $

inherit autotools

DESCRIPTION="Open Crypto Development Kit for basic OpenPGP message manipulation"
HOMEPAGE="http://www.gnutls.org/"
SRC_URI="ftp://ftp.gnutls.org/pub/gnutls/opencdk/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc ~sparc-fbsd x86 ~x86-fbsd"
IUSE="doc test"

RDEPEND=">=dev-libs/libgcrypt-1.2.0"
DEPEND="${RDEPEND}
	>=dev-lang/perl-5.6"

src_unpack() {
	unpack ${A}
	cd "${S}"

	if ! use test; then
		sed -e "/SUBDIRS/s/ tests//" -i Makefile.am
	fi

	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO
	use doc && dohtml doc/opencdk-api.html
}
