# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/gpgme/gpgme-1.1.6.ebuild,v 1.1 2008/01/15 18:26:02 alonbl Exp $

inherit autotools eutils

DESCRIPTION="GnuPG Made Easy is a library for making GnuPG easier to use"
HOMEPAGE="http://www.gnupg.org/related_software/gpgme"
SRC_URI="mirror://gnupg/gpgme/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="1"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND=">=dev-libs/libgpg-error-1.4
	>=dev-libs/pth-1.2
	>=app-crypt/gnupg-1.9.20-r1"

RDEPEND="${DEPEND}
	dev-libs/libgcrypt"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-cvs.patch"
	chmod a+x "tests/gpg/pinentry"
	eautoreconf

	# We need to call elibtoolize so that we get sane .so versioning on fbsd.
	#elibtoolize
}

src_compile() {
	econf \
		--with-pth=yes \
		--includedir=/usr/include/gpgme \
		--with-gpg=/usr/bin/gpg \
		--with-gpgsm=/usr/bin/gpgsm \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO VERSION
}
