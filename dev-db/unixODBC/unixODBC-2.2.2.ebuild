# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/unixODBC/unixODBC-2.2.2.ebuild,v 1.9 2003/06/19 17:28:12 wwoods Exp $

IUSE="qt"

S=${WORKDIR}/${P}
DESCRIPTION="ODBC Interface for Linux"
SRC_URI="http://www.unixodbc.org/${P}.tar.gz"
HOMEPAGE="http://www.unixodbc.org"
DEPEND="virtual/glibc
		>=sys-libs/readline-4.1
		>=sys-libs/ncurses-5.2
		qt? ( >=x11-libs/qt-3.0* )"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~hppa ~alpha"
SLOT="0"

src_unpack() {
	unpack ${A}
	cd ${S}
	# Original Makefile.in is trying to create and install files directly in /etc so we
	# need to edit the file to make it DESTDIR sensitive.
	cp Makefile.in Makefile.orig
	sed -e "s:touch :touch \${DESTDIR}/:" -e "s:mkdir -p :mkdir -p \${DESTDIR}/:" Makefile.orig > Makefile.in
}

src_compile() {
	local myconf

	if [ "`use qt`" ]
	then
		myconf="--enable-gui=yes"
	else
		myconf="--enable-gui=no"
	fi

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
