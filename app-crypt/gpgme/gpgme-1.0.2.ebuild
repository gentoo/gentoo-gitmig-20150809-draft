# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/gpgme/gpgme-1.0.2.ebuild,v 1.6 2005/03/27 11:24:27 hansmi Exp $

inherit eutils libtool

DESCRIPTION="GnuPG Made Easy is a library for making GnuPG easier to use"
HOMEPAGE="http://www.gnupg.org/(en)/related_software/gpgme/index.html"
SRC_URI="ftp://ftp.gnupg.org/gcrypt/gpgme/${P}.tar.gz"

#SRC_URI="mirror://gnu/gcrypt/gpgme/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="1"
KEYWORDS="x86 ppc sparc alpha ~hppa ~amd64 ~ia64 ~ppc64 ~ppc-macos"
IUSE=""
#IUSE="smime"

DEPEND=">=app-crypt/gnupg-1.2.2
	sys-apps/gawk
	sys-devel/libtool
	sys-devel/gcc
	>=dev-libs/libgpg-error-0.5
	!ia64? ( dev-libs/pth )"

# For when gnupg-1.9+ gets unmasked
#	!smime? ( >=app-crypt/gnupg-1.2.2 )
#	smime? ( >=app-crypt/gnupg-1.9.6 )

RDEPEND="virtual/libc
	>=dev-libs/libgpg-error-0.5
	dev-libs/libgcrypt
	>=app-crypt/gnupg-1.2.2
	!ia64? ( dev-libs/pth )"

src_compile() {

	if use ppc-macos; then
		sed -i \
			-e "s:AC_PREREQ(2.59):#AC_PREREQ(2.59):" \
			-e "s:min_automake_version="1.9.3":#min_automake_version="1.9.3":" \
			configure.ac || die
		libtoolize --force --copy
		aclocal
	fi

	WANT_AUTOCONF=2.57
	autoconf || die "failed to autoconfigure"
	if use ppc-macos; then
		automake || die "failed to automake"
	fi

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
		--with-pth=yes \
		--disable-test \
		|| die "econf failed"
	emake CFLAGS="${CFLAGS} -I../assuan/"  || die
}

#src_test() {
#	einfo "testing currently broken - bypassing"
#}

src_install() {
	emake DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO VERSION
}
