# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# /space/gentoo/cvsroot/gentoo-x86/gnome-extra/users-guide/users-guide-1.2.ebuild,v 1.8 2001/11/10 13:54:53 hallski Exp

S=${WORKDIR}/${P}
DESCRIPTION="gnome-users-guide"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.gnome.org/"

DEPEND="gnome-base/gnome-core"

src_compile() {
	sed 's%\help/users-guide%help/gnome-users-guide%' Makefile.am > tmp~
	mv tmp~ Makefile.am
	sed 's%\help/users-guide%help/gnome-users-guide%' Makefile.in > tmp~
	mv tmp~ Makefile.in

	./configure --host=${CHOST}					\
		    --prefix=/usr
	assert

	emake || die
}

src_install() {
	make prefix=${D}/usr install || die

	dodoc AUTHORS COPYING* ChangeLog NEWS README* TODO
}
