# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Mikael Hallendal <micke@hallendal.net>
# $Header: /var/cvsroot/gentoo-x86/app-crypt/gpa/gpa-0.4.3.ebuild,v 1.2 2002/05/23 06:50:08 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Standard GUI for GnuPG"
SRC_URI="ftp://ftp.gnupg.org/gcrypt/alpha/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.gnupg.org/gpa.html"

DEPEND="=x11-libs/gtk+-1.2*
	app-crypt/gnupg
	nls? ( sys-devel/gettext )"


src_compile() {
	local myconf

	if [ -z "`use nls`" ] ; then
		myconf="--disable-nls"
	fi

	./configure 	--host=${CHOST} \
			--prefix=/usr \
			--mandir=/usr/share/man \
			--infodir=/usr/share/info \
			--sysconfdir=/etc \
			$myconf || die

	emake || die
}

src_install () {
	make	prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		sysconfdir=${D}/etc \
		install || die

	dodoc AUTHORS COPYING ChangeLog README NEWS TODO
}





