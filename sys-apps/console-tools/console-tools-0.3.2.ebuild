# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/console-tools/console-tools-0.3.2.ebuild,v 1.3 2003/05/18 19:56:09 dragon Exp $

inherit libtool eutils

IUSE="nls"

S=${WORKDIR}/${P}
DESCRIPTION="Console and font utilities"
HOMEPAGE="http://lct.sourceforge.net/"
SRC_URI="mirror://sourceforge/lct/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~mips"

DEPEND="sys-devel/autoconf
	sys-devel/automake
	sys-devel/libtool
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd ${S}
	find ./ -name 'Makefile.*' | xargs sed -i "s:doc ::"

	# GCC-3.3 Compile Fix
	epatch ${FILESDIR}/${P}-multi-line-string-fix.diff
}

src_compile() {
	elibtoolize

	local myconf=""
	[ "$DEBUG" ] && myconf="--enable-debugging"
	[ -z "`use nls`" ] && myconf="${myconf} --disable-nls"

	econf \
		${myconf} || die
	make ${MAKEOPTS} all || die
}

src_install() {
	# DESTDIR does not work correct
	einstall || die

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
