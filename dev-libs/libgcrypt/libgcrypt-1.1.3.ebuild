# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libgcrypt/libgcrypt-1.1.3.ebuild,v 1.11 2003/02/13 10:42:33 vapier Exp $

IUSE="nls"

S=${WORKDIR}/${P}
DESCRIPTION="libgcrypt is a general purpose crypto library based on the code used in GnuPG."
SRC_URI="ftp://ftp.gnupg.org/gcrypt/alpha/libgcrypt/${P}.tar.gz"
HOMEPAGE="http://www.gnupg.org"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc "

DEPEND="app-text/jadetex
	app-text/docbook-sgml-utils"

RDEPEND="nls? ( sys-devel/gettext )"

src_compile() {
	
	local myconf
	use nls || myconf="${myconf} --disable-nls"

	econf \
		--enable-m-guard \
		--enable-static \
		${myconf} || die
	
	emake  || die
}

src_install () {
	
	make DESTDIR=${D} install || die
	dodoc AUTHORS BUGS COPYING INSTALL NEWS README* THANKS VERSION 
}
