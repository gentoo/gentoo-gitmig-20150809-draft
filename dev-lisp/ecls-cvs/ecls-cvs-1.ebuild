# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/ecls-cvs/ecls-cvs-1.ebuild,v 1.2 2004/06/24 23:58:42 agriffis Exp $

ECVS_SERVER="cvs.sourceforge.net:/cvsroot/ecls"
ECVS_MODULE="ecls"
ECVS_USER="anonymous"
ECVS_CVS_OPTIONS="-dP"

inherit cvs

IUSE="X"
S=${WORKDIR}/${ECVS_MODULE}
DESCRIPTION="ECL stands for Embeddable Common-Lisp. The ECL project is an effort to modernize Giusseppe Attardi's ECL environment to produce an implementation of the Common-Lisp language which complies to the ANSI X3J13 definition of the language."
SRC_URI=""
HOMEPAGE="http://ecls.sourceforge.net/"
RESTRICT="$RESTRICT nostrip"
SLOT="0"
LICENSE="BSD LGPL-2"
KEYWORDS="~x86"

DEPEND="X? ( virtual/x11 )
	=dev-libs/gmp-4*"

src_compile() {
	use X && myconf="--with-x" || myconf="--without-x"
	econf --enable-local-gmp \
		--disable-local-boehm \
		--with-tcp \
		--with-ffi \
		--with-clos-streams \
		${myconf} || die
	make || die
}

src_install () {
	make bindir=${D}/usr/bin \
		infodir=${D}/usr/share/info \
		mandir=${D}/usr/share/man \
		libdir=${D}/usr/lib/ecl install || die
	dohtml doc/*.html
	dodoc ANNOUNCEMENT Copyright LGPL
}
