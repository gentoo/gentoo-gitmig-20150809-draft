# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/ecls/ecls-0.9d.ebuild,v 1.3 2004/11/30 16:32:40 mkennedy Exp $

inherit eutils

DESCRIPTION="ECL is an embeddable Common Lisp implementation."
SRC_URI="mirror://sourceforge/ecls/ecl-${PV}.tgz"
HOMEPAGE="http://ecls.sourceforge.net/"
SLOT="0"
LICENSE="BSD LGPL-2"
KEYWORDS="~x86"

DEPEND="X? ( virtual/x11 )
	=dev-libs/gmp-4*
	dev-libs/boehm-gc
	app-text/texi2html"

IUSE="X"

S=${WORKDIR}/ecl-${PV}

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PV}-texinfo-gentoo.patch || die
	epatch ${FILESDIR}/${PV}-headers-gentoo.patch || die
}

src_compile() {
	myconf="--enable-local-gmp --enable-local-boehm --with-tcp"
	myconf="$myconf --with-ffi --with-clos-streams --with-cmuformat `use_with X x`"
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
}
