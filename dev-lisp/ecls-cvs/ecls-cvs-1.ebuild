# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/ecls-cvs/ecls-cvs-1.ebuild,v 1.3 2004/10/27 20:03:33 mkennedy Exp $

ECVS_SERVER="cvs.sourceforge.net:/cvsroot/ecls"
ECVS_MODULE="ecls"
ECVS_USER="anonymous"
ECVS_CVS_OPTIONS="-dP"

inherit cvs

IUSE="X"
S=${WORKDIR}/${ECVS_MODULE}
DESCRIPTION="ECL is an embeddable Common Lisp implementation."
SRC_URI=""
HOMEPAGE="http://ecls.sourceforge.net/"
RESTRICT="$RESTRICT nostrip"
SLOT="0"
LICENSE="BSD LGPL-2"
KEYWORDS="~x86"

DEPEND="X? ( virtual/x11 )
	=dev-libs/gmp-4*
	dev-libs/boehm-gc
	app-text/texi2html"

src_compile() {
	use X && myconf="--with-x" || myconf="--without-x"
	econf --enable-local-gmp \
		--enable-local-boehm \
		--with-tcp \
		--with-ffi \
		--with-clos-streams \
		--with-cmu-format \
		${myconf} || die
	make -k || true
}

src_install () {
	make -k bindir=${D}/usr/bin \
		infodir=${D}/usr/share/info \
		mandir=${D}/usr/share/man \
		libdir=${D}/usr/lib/ecl install || true
	dohtml doc/*.html
	dodoc ANNOUNCEMENT Copyright LGPL
}
