# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/gpgme/gpgme-0.3.12.ebuild,v 1.8 2004/02/17 23:22:53 agriffis Exp $

DESCRIPTION="GnuPG Made Easy (GPGME) is a library designed to make access to GnuPG easier for applications."
SRC_URI="ftp://ftp.gnupg.org/gcrypt/alpha/gpgme/${P}.tar.gz"
HOMEPAGE="http://www.gnupg.org/gpgme.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~sparc alpha ia64"

DEPEND=">=sys-libs/zlib-1.1.3
	>=app-crypt/gnupg-1.0.7"
#	crypt? ( app-crypt/gpgsm )"
RDEPEND="nls? ( sys-devel/gettext )"
IUSE="nls crypt doc"

src_compile() {
	local myconf
	use nls \
		|| myconf="--disable-nls"
	use crypt \
		&& myconf="${myconf} --enable-gpgmeplug"
	use doc \
		&& myconf="${myconf} --enable-maintainer-mode"

	econf ${myconf}
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog COPYING INSTALL NEWS README README-alpha THANKS TODO VERSION
}
