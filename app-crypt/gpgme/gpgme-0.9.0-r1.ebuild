# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/gpgme/gpgme-0.9.0-r1.ebuild,v 1.1 2004/08/07 08:18:25 dragonheart Exp $

DESCRIPTION="GnuPG Made Easy is a library for making GnuPG easier to use"
HOMEPAGE="http://www.gnupg.org/(en)/related_software/gpgme/index.html"
SRC_URI="ftp://ftp.gnupg.org/gcrypt/alpha/gpgme/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="1"
KEYWORDS="-*"
IUSE="nls smime"

DEPEND=">=sys-libs/zlib-1.1.3
	>=app-crypt/gnupg-1.2.2
	sys-apps/gawk
	sys-devel/libtool
	sys-devel/gcc
	dev-libs/libgpg-error
	dev-libs/libgpg-error
	nls? ( sys-devel/gettext )
	dev-libs/libgcrypt
	>=app-crypt/gnupg-1.2.2
	smime? ( >=app-crypt/newpg-1.9.6 )
	!<=app-crypt/gpgme-0.3.14"

RDEPEND="virtual/libc
	dev-libs/libgpg-error"

src_compile() {
	if [ -x /usr/bin/gpg2 ]; then
		GPGBIN=/usr/bin/gpg2
	else
		GPGBIN=/usr/bin/gpg
	fi

	econf \
		--includedir=/usr/include/gpgme \
		$(use_with smime gpgsm /usr/bin/gpgsm) \
		`use_enable nls` \
		--with-gpg=$GPGBIN \
		|| die "econf failed"
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog NEWS README README-alpha THANKS TODO VERSION
}
