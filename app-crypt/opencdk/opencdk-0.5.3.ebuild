# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/opencdk/opencdk-0.5.3.ebuild,v 1.3 2004/02/29 19:24:09 weeve Exp $

DESCRIPTION="Open Crypto Development Kit for basic OpenPGP message manipulation"
HOMEPAGE="http://www.gnutls.org/"
SRC_URI="ftp://ftp.gnutls.org/pub/gnutls/opencdk/${P}.tar.gz"

IUSE="doc"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 amd64 ~sparc"

RDEPEND=">=dev-libs/libgcrypt-1.1.91"

DEPEND="${RDEPEND}
		>=dev-lang/perl-5.6"

src_compile() {
	econf
	emake || die "make failed"
}

src_install() {
	einstall || die "installed failed"

	dodoc AUTHORS COPYING ChangeLog NEWS README \
		README-alpha THANKS TODO
	[ "`use doc`" ] && dohtml doc/opencdk-api.html
}
