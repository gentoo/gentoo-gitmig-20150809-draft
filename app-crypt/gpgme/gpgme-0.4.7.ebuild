# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/gpgme/gpgme-0.4.7.ebuild,v 1.6 2004/07/24 06:23:12 vapier Exp $

DESCRIPTION="GnuPG Made Easy is a library for making GnuPG easier to use"
HOMEPAGE="http://www.gnupg.org/(en)/related_software/gpgme/index.html"
SRC_URI="ftp://ftp.gnupg.org/gcrypt/alpha/gpgme/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0.4"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~amd64 ~ia64"
IUSE="nls smime"

DEPEND=">=sys-libs/zlib-1.1.3
	>=app-crypt/gnupg-1.2*
	sys-apps/gawk
	sys-devel/libtool
	sys-devel/gcc
	dev-libs/libgpg-error"
RDEPEND="nls? ( sys-devel/gettext )
	dev-libs/libgcrypt"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e 's:libgpgme:libgpgme4:g' \
		`find . -name Makefile.in` doc/gpgme.info
	sed -i -e 's:gpgme-config:gpgme4-config:g' \
		configure gpgme/Makefile.in doc/gpgme.info gpgme/gpgme-config.in
	sed -i -e 's:-lgpgme:-lgpgme4:g' \
		gpgme/gpgme-config.in doc/gpgme.info configure
	sed -i -e 's:gpgme\.info:gpgme4.info:g' \
		doc/Makefile.in doc/gpgme.info
	sed -i -e 's:gpgme\.m4:gpgme4.m4:g' gpgme/Makefile.in
	mv gpgme/gpgme{,4}-config.in
	mv doc/gpgme{,4}.info
	mv gpgme/libgpgme{,4}.vers
	mv gpgme/gpgme{,4}.m4
}

src_compile() {
	econf \
		--includedir=/usr/include/gpgme4 \
		$(use_with smime gpgsm $(which gpgsm)) \
		`use_enable nls` \
		|| die "econf failed"
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog NEWS README README-alpha THANKS TODO VERSION
}
