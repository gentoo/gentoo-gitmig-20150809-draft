# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-text/a2ps/a2ps-4.13b-r3.ebuild,v 1.3 2002/04/12 16:56:03 seemant Exp $

P=a2ps-4.13b
S=${WORKDIR}/a2ps-4.13
DESCRIPTION="a2ps is an Any to PostScript filter"
SRC_URI="ftp://ftp.enst.fr/pub/unix/a2ps/${P}.tar.gz"
HOMEPAGE="http://www-inf.enst.fr/~demaille/a2ps"

DEPEND=">=app-text/ghostscript-6.23
	>=app-text/psutils-1.17
	tetex? ( >=app-text/tetex-1.0.7 )"

RDEPEND="${DEPEND}
	nls? ( sys-devel/gettext )"

	

src_compile() {

	local myconf

	use nls || myconf="--disable-nls"

	./configure	\
		--host=${CHOST}	\
		--prefix=/usr	\
		--sysconfdir=/etc/a2ps \
		--mandir=/usr/share/man 	\
		--infodir=/usr/share/info	\
		--enable-shared	\
		--enable-static \
		${myconf} || die

	emake || die
}

src_install() {                               

	dodir /usr/share/emacs/site-lisp

	make 	\
		prefix=${D}/usr	\
		sysconfdir=${D}/etc/a2ps \
		mandir=${D}/usr/share/man 	\
		infodir=${D}/usr/share/info \
		lispdir=${D}/usr/share/emacs/site-lisp	\
		install || die

	dodoc ANNOUNCE AUTHORS ChangeLog COPYING FAQ NEWS README THANKS TODO

}
