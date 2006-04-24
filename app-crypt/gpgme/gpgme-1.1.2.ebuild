# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/gpgme/gpgme-1.1.2.ebuild,v 1.2 2006/04/24 11:36:37 genstef Exp $

DESCRIPTION="GnuPG Made Easy is a library for making GnuPG easier to use"
HOMEPAGE="http://www.gnupg.org/(en)/related_software/gpgme/index.html"
SRC_URI="mirror://gnupg/gpgme/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="1"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="smime"

DEPEND=">=dev-libs/libgpg-error-0.5
	dev-libs/pth
	!smime? ( >=app-crypt/gnupg-1.2.2 )
	smime? ( >=app-crypt/gnupg-1.9.20-r1 )"

RDEPEND="${DEPEND}
	dev-libs/libgcrypt"

src_compile() {
	if use selinux; then
		sed -i -e "s:tests = tests:tests = :" Makefile.in || die "sed failed"
	fi

	econf \
		--includedir=/usr/include/gpgme \
		--with-gpg=/usr/bin/gpg \
		--with-pth=yes \
		$(use_with smime gpgsm /usr/bin/gpgsm) \
		|| die "econf failed"
	emake CFLAGS="${CFLAGS} -I../assuan/"  || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO VERSION
}
