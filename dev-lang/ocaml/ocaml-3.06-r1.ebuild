# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/ocaml/ocaml-3.06-r1.ebuild,v 1.1 2003/05/02 08:34:40 george Exp $

IUSE="tcltk"

inherit flag-o-matic
filter-flags "-fstack-protector"


S=${WORKDIR}/${P}
DESCRIPTION="Objective Caml is a fast modern type-inferring functional programming language descended from the ML (Meta Language) family."
SRC_URI="http://caml.inria.fr/distrib/${P}/${P}.tar.gz"
HOMEPAGE="http://www.ocaml.org/"

DEPEND="virtual/glibc
	tcltk? ( >=dev-lang/tk-3.3.3 )"

SLOT="0"
LICENSE="QPL-1.0 LGPL-2"
KEYWORDS="~x86 ~sparc ~ppc"

src_compile()
{
	local myconf
	use tcltk || myconf="-no-tk"

	epatch ${FILESDIR}/ocaml-3.06-tcltk-8.4compat-patch.bz2

	./configure -prefix /usr \
		-bindir /usr/bin \
		-libdir /usr/lib/ocaml \
		-mandir /usr/share/man \
		--with-pthread ${myconf} || die

	make world || die
	make opt || die
	make opt.opt || die
}

src_install ()
{
	make BINDIR=${D}/usr/bin \
		LIBDIR=${D}/usr/lib/ocaml \
		MANDIR=${D}/usr/share/man \
		install || die

	# silly, silly makefiles
	dosed "s:${D}::g" /usr/lib/ocaml/ld.conf

	# documentation
	dodoc Changes INSTALL LICENSE README Upgrading
}
