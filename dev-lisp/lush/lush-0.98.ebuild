# Copyright 1999-2004 Gentoo Foundation and Matthew Kennedy <mkennedy@gentoo.org>
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/lush/lush-0.98.ebuild,v 1.4 2004/07/14 16:24:42 agriffis Exp $

DESCRIPTION="Lush is the Lisp User Shell.  Lush is designed to be used in situations where one would want to combine the flexibility of a high-level, loosely-typed interpreted language, with the efficiency of a strongly-typed, natively-compiled language, and with the easy integration of code written in C, C++, or other languages."
HOMEPAGE="http://lush.sourceforge.net/"
SRC_URI="mirror://sourceforge/lush/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="X"

DEPEND="X? ( virtual/x11 )"
#	emacs? ( virtual/emacs )"

S=${WORKDIR}/${PN}

src_compile() {
	local myconf="--without-x"
	use X && myconf="${myconf} --with-x"
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		${myconf} || die "./configure failed"
	make || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc 0-CVS-INFO COPYING COPYRIGHT README README.binutils README.cygwin README.mac
}
