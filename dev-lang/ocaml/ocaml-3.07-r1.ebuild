# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/ocaml/ocaml-3.07-r1.ebuild,v 1.2 2004/02/17 22:04:49 agriffis Exp $

inherit flag-o-matic eutils
filter-flags "-fstack-protector"

DESCRIPTION="fast modern type-inferring functional programming language descended from the ML (Meta Language) family"
HOMEPAGE="http://www.ocaml.org/"

SRC_URI="http://caml.inria.fr/distrib/${P}/${P}.tar.gz
	http://caml.inria.fr/distrib/${P}/${P}-patch2.diffs"

LICENSE="QPL-1.0 LGPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc ~alpha ~ia64"
IUSE="tcltk"

DEPEND="virtual/glibc
	tcltk? ( >=dev-lang/tk-3.3.3 )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${DISTDIR}/${P}-patch2.diffs
	grep -rle "head -1" . | xargs sed -i "s:head -1:head -n 1:g"
}

src_compile() {
	local myconf
	use tcltk || myconf="-no-tk"

	# Fix for bug #23767.
	if [ "${ARCH}" = "sparc" ]; then
		myconf="${myconf} -host sparc-unknown-linux-gnu"
	fi

	./configure -prefix /usr \
		-bindir /usr/bin \
		-libdir /usr/lib/ocaml \
		-mandir /usr/share/man \
		--with-pthread ${myconf} || die

	make world || die
	make opt || die
	make opt.opt || die
}

src_install() {
	make BINDIR=${D}/usr/bin \
		LIBDIR=${D}/usr/lib/ocaml \
		MANDIR=${D}/usr/share/man \
		install || die

	# silly, silly makefiles
	dosed "s:${D}::g" /usr/lib/ocaml/ld.conf

	# documentation
	dodoc Changes INSTALL LICENSE README Upgrading
}
