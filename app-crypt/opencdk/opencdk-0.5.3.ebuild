# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/opencdk/opencdk-0.5.3.ebuild,v 1.13 2004/07/29 18:30:48 geoman Exp $

DESCRIPTION="Open Crypto Development Kit for basic OpenPGP message manipulation"
HOMEPAGE="http://www.gnutls.org/"
SRC_URI="ftp://ftp.gnutls.org/pub/gnutls/opencdk/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc mips alpha amd64 ppc64"
IUSE="doc"

RDEPEND=">=dev-libs/libgcrypt-1.1.91"
DEPEND="${RDEPEND}
	>=dev-lang/perl-5.6"

src_install() {
	einstall || die "installed failed"

	dodoc AUTHORS ChangeLog NEWS README README-alpha THANKS TODO
	use doc && dohtml doc/opencdk-api.html
}
