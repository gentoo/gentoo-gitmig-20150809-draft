# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-text/pinfo/pinfo-0.6.5_p2.ebuild,v 1.2 2002/07/11 06:30:19 drobbins Exp $

MY_P=${PN}-0.6.5p2
S=${WORKDIR}/${MY_P}
DESCRIPTION="Hypertext info and man viewer based on (n)curses"
SRC_URI="http://zeus.polsl.gliwice.pl/~pborys/stable-version/${MY_P}.tar.gz"
HOMEPAGE="http://zeus.polsl.gliwice.pl/~pborys/"
DEPEND="virtual/glibc
	>=sys-libs/ncurses-5.2
	nls? ( >=sys-devel/gettext-0.10.39 )
	>=sys-devel/bison-1.28"

src_compile() {
	local myconf
	if [ "`use readline`" ] ; then
		myconf="${myconf} --with-readline"
	fi

	if [ -z "`use nls`" ] ; then
		myconf="${myconf} --disable-nls"
	else
		myconf="${myconf} --enable-nls"
	fi
	
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		$myconf || die "./configure failed"

	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
}
