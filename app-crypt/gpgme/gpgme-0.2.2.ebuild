# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Bruce A. Locke <blocke@shivan.org>
# $Header: /home/cvsroot/gentoo-x86/app-crypt/gnupg/gnupg-1.0.4.ebuild,v 1.0
# 2001/04/21 12:45 CST blutgens  Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="GnuPG Made Easy (GPGME) is a library designed to make access to GnuPG easier for applications."
SRC_URI="ftp://ftp.gnupg.org/gcrypt/alpha/gpgme/${A}"
HOMEPAGE="http://www.gnupg.org/gpgme.html"

DEPEND="virtual/glibc
        nls? ( >=sys-devel/gettext-0.10.35 )
		>=sys-libs/zlib-1.1.3 >=app-crypt/gnupg-1.0.6"

RDEPEND=">=app-crypt/gnupg-1.0.6"

src_compile() {

   local myconf
   if [ -z "`use nls`" ]; then
	myconf="--disable-nls"
   fi

   try ./configure --prefix=/usr --mandir=/usr/share/man \
	 --infodir=/usr/share/info --host=${CHOST} ${myconf}
   
   emake || die

}

src_install () {

   make DESTDIR=${D} install || die
   dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README README-alpha THANKS TODO

}
