# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-text/pinfo/pinfo-0.6.3.ebuild,v 1.3 2002/08/01 11:40:14 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Hypertext info and man viewer based on (n)curses"
SRC_URI="http://zeus.polsl.gliwice.pl/~pborys/stable-version/pinfo-0.6.3.tar.gz"
HOMEPAGE="http://zeus.polsl.gliwice.pl/~pborys/"
DEPEND="virtual/glibc
	>=sys-libs/ncurses-5.2
	>=sys-devel/gettext-0.10.39
	>=sys-devel/bison-1.28"

src_compile() {
	local myconf
	if [ "`use readline`" ] ; then
		myconf="$myconf --with-readline"
	fi
	
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		$myconf || die "./configure failed"

	emake || die
	#make || die
}

src_install () {
	make DESTDIR=${D} install || die
}
