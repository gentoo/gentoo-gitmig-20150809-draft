# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-crypt/gpgme/gpgme-0.3.6-r1.ebuild,v 1.4 2002/08/16 02:36:53 murphy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="GnuPG Made Easy (GPGME) is a library designed to make access to GnuPG easier for applications."
SRC_URI="ftp://ftp.gnupg.org/gcrypt/alpha/gpgme/${P}.tar.gz"
HOMEPAGE="http://www.gnupg.org/gpgme.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc sparc64"

DEPEND=">=sys-libs/zlib-1.1.3
	>=app-crypt/gnupg-1.0.6"
RDEPEND="nls? ( sys-devel/gettext )"

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
