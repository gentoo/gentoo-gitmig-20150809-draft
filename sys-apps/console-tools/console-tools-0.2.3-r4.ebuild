# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/console-tools/console-tools-0.2.3-r4.ebuild,v 1.18 2003/06/21 21:19:39 drobbins Exp $

IUSE="nls"

S=${WORKDIR}/${P}
DESCRIPTION="Console and font utilities"
SRC_URI="mirror://sourceforge/lct/${P}.tar.gz"
HOMEPAGE="http://lct.sourceforge.net/"
KEYWORDS="x86 amd64 ppc sparc ~alpha mips"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/glibc
	sys-devel/autoconf sys-devel/automake sys-devel/libtool
	nls? ( sys-devel/gettext )"
RDEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	cd ${S}
	patch -p1 < ${FILESDIR}/${P}.patch || die
	patch -p0 < ${FILESDIR}/${P}-po-Makefile.in.in-gentoo.diff || die
	aclocal || die
	libtoolize --force -c || die
	autoheader || die
	automake -c || die
	autoconf || die
}

src_compile() {
	local myconf=""
	[ "$DEBUG" ] && myconf="--enable-debugging"
	[ -z "`use nls`" ] && myconf="${myconf} --disable-nls"

	./configure --prefix=/usr \
		--mandir=/usr/share/man \
		--host=${CHOST} \
		${myconf} || die
	make $MAKEOPTS all || die
}

src_install() {
	# DESTDIR does not work correct
	make DESTDIR=${D} install || die

	dodoc BUGS COPYING* CREDITS ChangeLog NEWS README RELEASE TODO
	docinto txt
	dodoc doc/*.txt doc/README.*
	docinto sgml
	dodoc doc/*.sgml
	docinto txt/contrib
	dodoc doc/contrib/*
	docinto txt/dvorak
	dodoc doc/dvorak/*
	docinto txt/file-formats
	dodoc doc/file-formats/*
	doman doc/man/*.[1-8]
}
