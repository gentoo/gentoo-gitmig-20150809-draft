# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-libs/g-wrap/g-wrap-1.1.11.ebuild,v 1.3 2001/11/10 12:05:20 hallski Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A tool for exporting C libraries into Scheme"
SRC_URI="ftp://ftp.gnucash.org/pub/g-wrap/source/${P}.tar.gz"
HOMEPAGE="http://"

DEPEND=">=sys-libs/glibc-2.1.3
	>=dev-util/guile-1.4
	>=dev-libs/slib-2.4.1"

src_compile() {
	./configure --host=${CHOST}					\
		    --prefix=/usr					\
		    --libexecdir=/usr/lib/misc 				\
		    --infodir=/usr/share/info 
	assert

	make || die
}

src_install () {
	make DESTDIR=${D} install || die
}
