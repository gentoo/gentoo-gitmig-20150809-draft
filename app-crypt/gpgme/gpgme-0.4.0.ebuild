# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/gpgme/gpgme-0.4.0.ebuild,v 1.10 2004/01/24 14:33:38 weeve Exp $

DESCRIPTION="GnuPG Made Easy (GPGME) is a library designed to make access to GnuPG easier for applications."
SRC_URI="ftp://ftp.gnupg.org/gcrypt/alpha/gpgme/${P}.tar.gz"
HOMEPAGE="http://www.gnupg.org/(en)/related_software/gpgme/index.html"

LICENSE="GPL-2"
KEYWORDS="x86 ~ppc hppa alpha sparc ~amd64"

DEPEND=">=sys-libs/zlib-1.1.3
	>=app-crypt/gnupg-1.2*"
RDEPEND="nls? ( sys-devel/gettext )"
SLOT="0.4"
IUSE="nls crypt doc"

src_unpack() {
	unpack ${A}
	cd ${S}
	mv configure configure.orig
	sed	-e 's:^\(GPGME_CONFIG_LIBS\)=.*:\1="-lgpgme4":' \
		-e 's:^\(GPGME_CONFIG_CFLAGS\)=.*:\1="-I/usr/include/gpgme4":' \
		configure.orig > configure
	chmod +x configure

	cd ${S}
	for x in $(find . -name Makefile.in)
	do
		mv ${x} ${x}.orig
		sed	-e 's:libgpgme.la:libgpgme4.la:g' \
			${x}.orig > ${x}
	done
}

src_compile() {
	econf	$(use_enable nls) \
		$(use_enable crypt gpgmeplug) \
		$(use_enable doc maintainer-mode)
	emake || die
}

src_install() {
	make includedir="/usr/include/gpgme4" DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog COPYING INSTALL NEWS README README-alpha THANKS TODO VERSION

	mv ${D}/usr/bin/gpgme-config ${D}/usr/bin/gpgme4-config
	for x in $(find ${D}/usr/share/info -name gpgme.\*)
	do
		mv ${x} ${x/gpgme.info/gpgme4.info}
	done
}
