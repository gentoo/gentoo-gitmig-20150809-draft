# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/libiodbc/libiodbc-3.51.2.ebuild,v 1.2 2004/04/08 23:07:47 vapier Exp $

inherit eutils

DESCRIPTION="ODBC Interface for Linux"
HOMEPAGE="http://www.iodbc.org/"
SRC_URI="http://www.iodbc.org/downloads/iODBC/${P}.tar.gz"

LICENSE="LGPL-2 BSD"
SLOT="0"
KEYWORDS="~x86 ~ppc ~hppa ~alpha ~amd64"
IUSE="gtk"

DEPEND="virtual/glibc
	>=sys-libs/readline-4.1
	>=sys-libs/ncurses-5.2
	gtk? ( >=x11-libs/gtk+-1.2.10* )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/libiodbc-3.51.2_install_symlink.diff
}

src_compile() {
	local myconf
	myconf="--with-layout=gentoo"

	if use gtk
	then
		myconf="$myconf --enable-gui=yes"
	else
		myconf="$myconf --disable-gui"
	fi

	./configure --host=${CHOST} ${myconf} || die
	make || die
}

src_install() {
	make DESTDIR=${D} install || die

	#dodoc AUTHORS ChangeLog NEWS README*
	#find doc/ -name "Makefile*" -exec rm '{}' \;
	#dohtml doc/*
	#prepalldocs
}
