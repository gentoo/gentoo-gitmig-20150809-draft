# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/ecls/ecls-0.9g.ebuild,v 1.1 2005/08/13 23:10:51 mkennedy Exp $

inherit eutils

DESCRIPTION="ECL is an embeddable Common Lisp implementation."
SRC_URI="mirror://sourceforge/ecls/ecl-${PV}.tar.gz"
HOMEPAGE="http://ecls.sourceforge.net/"
SLOT="0"
LICENSE="BSD LGPL-2"
KEYWORDS="x86 ~ppc ~amd64 ~sparc"

DEPEND="X? ( virtual/x11 )
	=dev-libs/gmp-4*
	app-text/texi2html"

# ECL fails to build with a system-installed Boehm GC (which apparently is a
# rare configuration since most distributions neglect to install the useful
# private headers). Until this is properly isolated, we use the Boehm GC
# included with ECL.

#	dev-libs/boehm-gc

IUSE="X"

PROVIDE="virtual/commonlisp"

S=${WORKDIR}/ecl-${PV:0:4}

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PV}-headers-gentoo.patch || die
}

src_compile() {
	local myconf="--with-system-gmp
		--enable-boehm=included
		--with-tcp
		--with-ffi
		--with-clos-streams
		--with-cmuformat
		--with-asdf
		`use_with X x`
		`use_with X clx`"
	einfo "Configuring with: $myconf"
	econf ${myconf} || die
	make || die
}

src_install () {
	make bindir=${D}/usr/bin \
		infodir=${D}/usr/share/info \
		mandir=${D}/usr/share/man \
		libdir=${D}/usr/lib/ecl \
		docdir=${D}/usr/share/doc/${PF} install || true
	dohtml doc/*.html
	dodoc ANNOUNCEMENT Copyright LGPL

	insinto /usr/share/doc/${PF}/
	doins ${FILESDIR}/{clc-lite.lisp,README.Gentoo}
}
