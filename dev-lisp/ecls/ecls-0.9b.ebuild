# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/ecls/ecls-0.9b.ebuild,v 1.3 2004/04/25 20:57:51 vapier Exp $

inherit eutils

DESCRIPTION="ECL (Embeddable Common-Lisp) is an interpreter of the Common-Lisp language as described in the X3J13 ANSI specification, featuring CLOS (Common-Lisp Object System), conditions, loops, etc, plus a translator to C, which can produce standalone executables.  (Also known as ECLS or ECL 'Spain')"
HOMEPAGE="http://ecls.sourceforge.net/"
SRC_URI="mirror://sourceforge/ecls/ecl-${PV}.tgz"

LICENSE="BSD LGPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="X"

DEPEND="X? ( virtual/x11 )
	=dev-libs/gmp-4*"

S=${WORKDIR}/ecl-${PV}

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/ecl-texi-gentoo.patch
}

src_compile() {
	use X && myconf="--with-x" || myconf="--without-x"
	# omit --enable-threads for now
	# use built in Boehm GC 
	econf --enable-local-gmp \
		--disable-local-boehm \
		--with-tcp \
		--with-ffi \
		--with-clos-streams \
		${myconf} || die
	make || die
}

src_install() {
	make bindir=${D}/usr/bin \
		infodir=${D}/usr/share/info \
		mandir=${D}/usr/share/man \
		libdir=${D}/usr/lib/ecl install || die
	dohtml doc/*.html
	dodoc ANNOUNCEMENT
}
