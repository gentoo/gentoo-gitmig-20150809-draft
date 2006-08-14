# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/gpgme/gpgme-1.0.3.ebuild,v 1.5 2006/08/14 09:35:49 dragonheart Exp $

inherit eutils libtool

DESCRIPTION="GnuPG Made Easy is a library for making GnuPG easier to use"
HOMEPAGE="http://www.gnupg.org/(en)/related_software/gpgme/index.html"
SRC_URI="mirror://gnupg/gpgme/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="1"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE=""
#IUSE="smime"

DEPEND=">=app-crypt/gnupg-1.2.2
	sys-apps/gawk
	sys-devel/libtool
	sys-devel/gcc
	>=dev-libs/libgpg-error-0.5
	dev-libs/pth"

# For when gnupg-1.9+ gets unmasked TODO soon
#	!smime? ( >=app-crypt/gnupg-1.2.2 )
#	smime? ( >=app-crypt/gnupg-1.9.6 )

RDEPEND="virtual/libc
	>=dev-libs/libgpg-error-0.5
	dev-libs/libgcrypt
	>=app-crypt/gnupg-1.2.2
	dev-libs/pth"

src_compile() {

	if [ -x /usr/bin/gpg2 ]; then
		GPGBIN=/usr/bin/gpg2
	else
		GPGBIN=/usr/bin/gpg
	fi

	# For when gnupg-1.9+ gets unmasked
	#	$(use_with smime gpgsm /usr/bin/gpgsm) \

	if use selinux; then
		sed  -i -e "s:tests = tests:tests = :" Makefile.in || die
	fi

	econf \
		--includedir=/usr/include/gpgme \
		--with-gpg=$GPGBIN \
		--with-pth=yes \
		|| die "econf failed"
	emake CFLAGS="${CFLAGS} -I../assuan/"  || die

#		--disable-test \

}

#src_test() {
#	einfo "testing currently broken - bypassing"
#}

src_install() {
	emake DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO VERSION
}
