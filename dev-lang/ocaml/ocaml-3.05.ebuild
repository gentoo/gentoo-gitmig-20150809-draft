# Copyright 20022 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-lang/ocaml/ocaml-3.05.ebuild,v 1.2 2002/08/14 11:58:50 murphy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Objective Caml is a fast modern type-inferring functional programming language descended from the ML (Meta Language) family."
SRC_URI="ftp://ftp.inria.fr/lang/caml-light/${P}.tar.gz"
HOMEPAGE="http://www.ocaml.org/"

DEPEND="virtual/glibc
	tcltk? ( >=dev-lang/tk-3.3.3 )"
RDEPEND="${DEPEND}"

SLOT="0"
LICENSE="QPL-1.0 LGPL-2"
KEYWORDS="x86 sparc sparc64"

src_compile()
{
	local myconf
	use tcltk || myconf="-no-tk"

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
	
	dodir /etc/env.d
	echo LDPATH=/usr/lib/ocaml:/usr/lib/ocaml/labltk \
		> ${D}/etc/env.d/30ocaml
	dodoc Changes INSTALL LICENSE README Upgrading

}




