# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/gpgme/gpgme-0.3.14.ebuild,v 1.16 2004/07/14 20:30:26 dragonheart Exp $

DESCRIPTION="GnuPG Made Easy (GPGME) is a library designed to make access to GnuPG easier for applications."
HOMEPAGE="http://www.gnupg.org/gpgme.html"
SRC_URI="ftp://ftp.gnupg.org/gcrypt/gpgme/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha hppa amd64 ia64"
IUSE="nls doc"

DEPEND=">=sys-libs/zlib-1.1.3
	>=app-crypt/gnupg-1.0.7
	sys-apps/gawk
	sys-devel/libtool
	sys-devel/gcc"

RDEPEND="nls? ( sys-devel/gettext )"

src_compile() {
	local myconf
	use nls \
		|| myconf="--disable-nls"

	myconf="${myconf} --enable-gpgmeplug"

	use doc \
		&& myconf="${myconf} --enable-maintainer-mode"

	econf ${myconf} || die "econf failed"
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog INSTALL NEWS README README-alpha THANKS TODO VERSION
}
