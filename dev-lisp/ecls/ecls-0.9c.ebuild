# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/ecls/ecls-0.9c.ebuild,v 1.3 2004/10/28 15:00:12 mkennedy Exp $

inherit eutils

DESCRIPTION="ECL (Embeddable Common-Lisp) is an interpreter of the Common-Lisp language as described in the X3J13 ANSI specification, featuring CLOS (Common-Lisp Object System), conditions, loops, etc, plus a translator to C, which can produce standalone executables.	 (Also known as ECLS or ECL 'Spain')"
HOMEPAGE="http://ecls.sourceforge.net/"
SRC_URI="mirror://sourceforge/ecls/ecl-${PV}.tgz"

LICENSE="BSD LGPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="X"

DEPEND="X? ( virtual/x11 )
	=dev-libs/gmp-4*
	dev-libs/boehm-gc
	app-text/texi2html"

S=${WORKDIR}/ecl-${PV}

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PV}-gcc-3.4-gentoo.patch
	epatch ${FILESDIR}/${PV}-texinfo-gentoo.patch
}

src_compile() {
	# omit --enable-threads for now
	LDFLAGS="-lgmp -lgc -ldl" CFLAGS="-I /usr/include/gc ${CFLAGS}" econf \
		`use_with X x` \
		--enable-shared \
		--enable-local-gmp \
		--enable-local-boehm \
		--with-tcp \
		--with-ffi \
		--with-clos-streams \
		${myconf} || die
	sed -i 's,-L./,-L./ -lgc -lgmp -ldl,g' build/compile.lsp
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
