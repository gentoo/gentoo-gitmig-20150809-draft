# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/ocaml/ocaml-3.04-r1.ebuild,v 1.11 2003/04/11 18:32:16 method Exp $

IUSE="tcltk"

inherit flag-o-matic
filter-flags "-fstack-protector"

S=${WORKDIR}/${P}
DESCRIPTION="Objective Caml is a fast modern type-inferring functional programming language descended from the ML (Meta Language) family."
SRC_URI="ftp://ftp.inria.fr/lang/caml-light/${P}.tar.gz"
HOMEPAGE="http://www.ocaml.org/"

DEPEND="virtual/glibc
	tcltk? ( >=dev-lang/tk-3.3.3 )"

SLOT="0"
LICENSE="QPL-1.0 LGPL-2"
KEYWORDS="x86 sparc "

# The unpack function is needed only so that we can apply a ppc patch from cvs.
# This should be fixed in v.>3.04, so the function can be removed then.

src_unpack()
{
	unpack ${A}
	cd ${S}
	if [ ${ARCH} == "ppc" ]
	then
		tar -zxf ${FILESDIR}/${P}-ppc.diff.tgz
		patch -l -p1 < ${P}-ppc.diff
	fi
}

src_compile()
{
	./configure -prefix /usr \
		-bindir /usr/bin \
		-libdir /usr/lib/ocaml \
		-mandir /usr/man/man1 \
		-with-pthread \

	make world || die
	make opt || die
	make opt.opt || die
}

src_install ()
{
	make BINDIR=${D}/usr/bin \
		LIBDIR=${D}/usr/lib/ocaml \
		MANDIR=${D}/usr/man/man1 \
		install || die

	dodir /etc/env.d
	echo LDPATH=/usr/lib/ocaml:/usr/lib/ocaml/labltk \
		> ${D}/etc/env.d/30ocaml
	dodoc Changes INSTALL LICENSE README Upgrading

}




