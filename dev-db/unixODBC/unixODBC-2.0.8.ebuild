# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/unixODBC/unixODBC-2.0.8.ebuild,v 1.15 2003/06/19 17:28:12 wwoods Exp $

IUSE="qt"

S=${WORKDIR}/${P}
DESCRIPTION="ODBC Interface for Linux"
SRC_URI="http://www.unixodbc.org/${P}.tar.gz"
HOMEPAGE="http://www.unixodbc.org"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~hppa ~alpha"
DEPEND="virtual/glibc
        >=sys-libs/readline-4.1
        >=sys-libs/ncurses-5.2
        qt? ( =x11-libs/qt-2.3* )"
SLOT="0"

src_unpack() {
	unpack ${A}
	cd ${S}
	cp Makefile.in Makefile.orig
	sed -e "s:touch :touch \${DESTDIR}/:" Makefile.orig > Makefile.in
}

src_compile() {
	local myconf

	if [ "`use qt`" ]
	then
		myconf="--enable-gui=yes"
	else
		myconf="--enable-gui=no"
	fi

	export QTDIR=/usr/qt/2
	./configure --host=${CHOST}					\
		    --prefix=/usr					\
		    --sysconfdir=/etc/unixODBC				\
		    ${myconf} || die

	make || die
}

src_install () {
	make DESTDIR=${D} install || die

	dodoc AUTHORS COPYING ChangeLog NEWS README*
	cp -a doc ${D}/usr/share/doc/${PF}/html
	find ${D}/usr/share/doc/${PF}/html -name "Makefile*" -exec rm {} \;
	prepalldocs
}
