# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/console-tools/console-tools-0.2.3-r4.ebuild,v 1.19 2003/08/03 04:34:12 vapier Exp $

DESCRIPTION="Console and font utilities"
HOMEPAGE="http://lct.sourceforge.net/"
SRC_URI="mirror://sourceforge/lct/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 ppc sparc ~alpha mips"
IUSE="nls debug"

DEPEND="virtual/glibc
	sys-devel/autoconf sys-devel/automake sys-devel/libtool
	nls? ( sys-devel/gettext )"
RDEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}.patch
	epatch ${FILESDIR}/${P}-po-Makefile.in.in-gentoo.diff
	aclocal || die
	libtoolize --force -c || die
	autoheader || die
	automake -c || die
	autoconf || die
}

src_compile() {
	econf \
		`use_enable nls` \
		`use_enable debug debugging` \
		|| die
	emake all || die
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
