# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Mikael Hallendal <hallski@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-util/intltool/intltool-0.11.ebuild,v 1.1 2001/10/22 09:55:34 hallski Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Scripts for extracting translatable strings from various sourcefiles"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.gnome.org/"

DEPEND="virtual/glibc
	>=sys-devel/perl-5.6.0"

src_compile() {                           

	./configure --host=${CHOST}					\
		    --prefix=/usr					\
		    --sysconfdir=/etc					\
		    --localstatedir=/var/lib				\
		    --mandir=/usr/share/man				
	assert

	emake || die
}

src_install() {
	make prefix=${D}/usr						\
	     sysconfdir=${D}/etc					\
	     localstatedir=${D}/var/lib					\
	     mandir=${D}/usr/share/man					\
	     install || die

	dodoc AUTHORS ChangeLog NEWS README
}






