# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/gpgme/gpgme-0.9.0-r1.ebuild,v 1.14 2005/02/22 09:36:57 hardave Exp $

DESCRIPTION="GnuPG Made Easy is a library for making GnuPG easier to use"
HOMEPAGE="http://www.gnupg.org/(en)/related_software/gpgme/index.html"
SRC_URI="ftp://ftp.gnupg.org/gcrypt/alpha/gpgme/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="1"
KEYWORDS="x86 ppc sparc alpha hppa amd64 ia64 ppc64 ~mips"
IUSE=""
#IUSE="smime"

DEPEND=">=app-crypt/gnupg-1.2.4
	sys-apps/gawk
	sys-devel/libtool
	sys-devel/gcc
	dev-libs/libgpg-error"

# For when gnupg-1.9+ gets unmasked
#	!smime? ( >=app-crypt/gnupg-1.2.5 )
#	smime? ( >=app-crypt/gnupg-1.9.10 )

RDEPEND="virtual/libc
	dev-libs/libgpg-error
	dev-libs/libgcrypt"

src_compile() {
	if [ -x /usr/bin/gpg2 ]; then
		GPGBIN=/usr/bin/gpg2
	else
		GPGBIN=/usr/bin/gpg
	fi

	# For when gnupg-1.9+ gets unmasked
	#	$(use_with smime gpgsm /usr/bin/gpgsm) \

	econf \
		--includedir=/usr/include/gpgme \
		--with-gpg=$GPGBIN \
		|| die "econf failed"
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog NEWS README README-alpha THANKS TODO VERSION
}
