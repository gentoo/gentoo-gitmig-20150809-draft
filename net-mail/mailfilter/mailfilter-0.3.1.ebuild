# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: mike polniak <mikpolniak@adelphia.net>
# $Header: /var/cvsroot/gentoo-x86/net-mail/mailfilter/mailfilter-0.3.1.ebuild,v 1.3 2002/05/27 17:27:39 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Mailfilter is a utility to get rid of unwanted spam mails"
SRC_URI="mirror://sourceforge/mailfilter/${P}.tar.gz"
HOMEPAGE="http://mailfilter.sourceforge.net/index.html"

DEPEND="virtual/glibc 
	nls? ( sys-devel/gettext )"

src_compile() {

	local myconf
	if [ -z "`use nls`" ]
	then
          myconf="${myconf} --disable-nls"
	fi

	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man ${myconf} || die "./configure failed"
	make || die
}

src_install () {

	make DESTDIR=${D} install || die
	dodoc INSTALL doc/FAQ doc/rcfile.example1 doc/rcfile.example2


}
