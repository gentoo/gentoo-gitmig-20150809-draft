# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-crypt/gpgme/gpgme-0.3.6-r1.ebuild,v 1.1 2002/07/16 22:37:49 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="GnuPG Made Easy (GPGME) is a library designed to make access to GnuPG easier for applications."
SRC_URI="ftp://ftp.gnupg.org/gcrypt/alpha/gpgme/${P}.tar.gz"
HOMEPAGE="http://www.gnupg.org/gpgme.html"

DEPEND="virtual/glibc
	nls? ( >=sys-devel/gettext-0.10.35 )
	>=sys-libs/zlib-1.1.3 >=app-crypt/gnupg-1.0.6"

RDEPEND=">=app-crypt/gnupg-1.0.6"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

src_compile() {

	local myconf
	use nls || myconf="--disable-nls"

	econf \
		--enable-gpgmeplug \
		${myconf} || die
	
	emake || die

}

src_install () {

	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README README-alpha THANKS TODO

}
