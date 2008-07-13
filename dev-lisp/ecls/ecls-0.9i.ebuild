# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/ecls/ecls-0.9i.ebuild,v 1.2 2008/07/13 18:51:40 pchrist Exp $

inherit eutils

DESCRIPTION="ECL is an embeddable Common Lisp implementation."
SRC_URI="mirror://sourceforge/ecls/ecl-${PV}.tgz"
HOMEPAGE="http://ecls.sourceforge.net/"
SLOT="0"
LICENSE="BSD LGPL-2"
KEYWORDS="~x86 ~ppc ~amd64 ~sparc"
DEPEND="=dev-libs/gmp-4*
	app-text/texi2html"
IUSE="X"
PROVIDE="virtual/commonlisp"
S=${WORKDIR}/ecl-${PV:0:4}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PV}-headers-gentoo.patch"
}

src_compile() {
	econf --with-system-gmp \
		--enable-boehm=included \
		--with-tcp \
		--with-ffi \
		--with-clos-streams \
		--with-cmuformat \
		--with-asdf \
		$(use_with X x) \
		$(use_with X clx) \
		|| die "econf failed"
	emake -j1 || die "emake died"
}

src_install () {
	local libso="libecl.so"

	emake DESTDIR="${D}" install \
	|| die "emake install failed."

	rm -v "${D}/usr/lib/ecl/${libso}"
	rm -v "${D}/usr/share/doc/ecl"
	dolib.so "build/${libso}"

	dohtml doc/*.html
	dodoc ANNOUNCEMENT Copyright LGPL "${FILESDIR}/README.Gentoo"
}
