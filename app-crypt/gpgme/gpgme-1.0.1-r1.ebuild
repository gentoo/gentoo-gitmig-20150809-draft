# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/gpgme/gpgme-1.0.1-r1.ebuild,v 1.1 2004/10/25 13:59:54 dragonheart Exp $

inherit eutils

DESCRIPTION="GnuPG Made Easy is a library for making GnuPG easier to use"
HOMEPAGE="http://www.gnupg.org/(en)/related_software/gpgme/index.html"
SRC_URI="ftp://ftp.gnupg.org/gcrypt/gpgme/${P}.tar.gz"
#SRC_URI="mirror://gnu/gcrypt/gpgme/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="1"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~amd64 ~ia64 ~ppc64"
#IUSE=""
IUSE="smime"

DEPEND="sys-apps/gawk
	sys-devel/libtool
	sys-devel/gcc
	>=dev-libs/libgpg-error-0.5
	!<=app-crypt/gpgme-0.3.14
	!=app-crypt/gpgme-0.3.16
	!ia64? ( !ppc64? ( dev-libs/pth ) )
	!smime? ( >=app-crypt/gnupg-1.2.2 )
	smime? ( >=app-crypt/gnupg-1.9.6 )"

# For when gnupg-1.9+ gets unmasked
#	!smime? ( >=app-crypt/gnupg-1.2.2 )
#	smime? ( >=app-crypt/gnupg-1.9.6 )

RDEPEND="virtual/libc
	>=dev-libs/libgpg-error-0.5
	dev-libs/libgcrypt
	>=app-crypt/gnupg-1.2.2
	!ia64? ( !ppc64? ( dev-libs/pth ) )
	!<=app-crypt/gpgme-0.3.14
	!=app-crypt/gpgme-0.3.16
	!smime? ( >=app-crypt/gnupg-1.2.2 )
	smime? ( >=app-crypt/gnupg-1.9.6 )"


src_compile() {

	WANT_AUTOCONF=2.57
	autoconf || die "failed to autoconfigure"

	if [ -x /usr/bin/gpg2 ]; then
		GPGBIN=/usr/bin/gpg2
	else
		GPGBIN=/usr/bin/gpg
	fi

	# For when gnupg-1.9+ gets unmasked
	#	$(use_with smime gpgsm /usr/bin/gpgsm) \

	econf \
		$(use_with smime gpgsm /usr/bin/gpgsm) \
		--includedir=/usr/include/gpgme \
		--with-gpg=$GPGBIN \
		--with-pth=yes \
		`use_enable smime test` \
		|| die "econf failed"
	emake CFLAGS="${CFLAGS} -I../assuan/"  || die
}

src_test() {
	einfo "testing currently broken"
}

src_install() {
	emake DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO VERSION
}
