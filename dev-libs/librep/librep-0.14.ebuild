# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-libs/librep/librep-0.14.ebuild,v 1.3 2001/11/10 12:05:20 hallski Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Shared library implementing a Lisp dialect"
SRC_URI="http://prdownloads.sourceforge.net/librep/${P}.tar.gz"
HOMEPAGE="http://librep.sourceforge.net/"

DEPEND="virtual/glibc
	>=sys-libs/gdbm-1.8.0
	>=dev-libs/gmp-3.1.1
        readline? ( >=sys-libs/readline-4.1
		    >=sys-libs/ncurses-5.2 )
        sys-apps/texinfo"

src_compile() {
	local myconf

	if [ "`use readline`" ]
	then
		myconf="--with-readline"
	else
		myconf="--without-readline"
	fi

	./configure --host=${CHOST}					\
		    --prefix=/usr					\
		    --libexecdir=/usr/lib 				\
		    --infodir=/usr/share/info
	assert

	make || die
}

src_install() {
	make DESTDIR=${D} install || die

	insinto /usr/include
	doins src/rep_config.h
	dodoc AUTHORS BUGS COPYING ChangeLog NEWS README THANKS TODO DOC
	docinto doc
	dodoc doc/*
}
