# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/opencdk/opencdk-0.5.5.ebuild,v 1.12 2004/09/26 05:19:18 tgall Exp $

inherit gnuconfig

DESCRIPTION="Open Crypto Development Kit for basic OpenPGP message manipulation"
HOMEPAGE="http://www.gnutls.org/"
SRC_URI="ftp://ftp.gnutls.org/pub/gnutls/opencdk/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc mips alpha amd64 ppc64 ia64 hppa"
IUSE="doc"

RDEPEND=">=dev-libs/libgcrypt-1.1.94"
DEPEND="${RDEPEND}
	>=dev-lang/perl-5.6"

src_compile() {
	# Needed for mips and probably others
	gnuconfig_update

	econf || die "Failed to run econf!"
	emake || die "Failed to run emake!"
}

src_install() {
	einstall || die "installed failed"

	dodoc AUTHORS ChangeLog NEWS README README-alpha THANKS TODO
	use doc && dohtml doc/opencdk-api.html
}
