# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-libs/librep/librep-0.15.2-r1.ebuild,v 1.2 2002/07/11 06:30:21 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Shared library implementing a Lisp dialect"
SRC_URI="http://download.sourceforge.net/librep/${P}.tar.gz"
HOMEPAGE="http://librep.sourceforge.net/"

DEPEND="virtual/glibc
	>=sys-libs/gdbm-1.8.0
	>=dev-libs/gmp-3.1.1
	readline? ( >=sys-libs/readline-4.1
	            >=sys-libs/ncurses-5.2 )
	sys-apps/texinfo"

src_unpack() {
	unpack ${A}

	cd ${S}
	#patch buggy makefile for newer libtool
	patch -p1 <${FILESDIR}/librep-${PV}-exec.patch || die

	#update libtool to fix "relink" bug
	libtoolize --copy --force
	aclocal
}

src_compile() {
	local myconf

	if [ "`use readline`" ]
	then
		myconf="--with-readline"
	else
		myconf="--without-readline"
	fi

	./configure --host=${CHOST} \
		    --prefix=/usr \
		    --libexecdir=/usr/lib \
		    --infodir=/usr/share/info || die

	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	insinto /usr/include
	doins src/rep_config.h
	dodoc AUTHORS BUGS COPYING ChangeLog NEWS README THANKS TODO DOC
	docinto doc
	dodoc doc/*
}

