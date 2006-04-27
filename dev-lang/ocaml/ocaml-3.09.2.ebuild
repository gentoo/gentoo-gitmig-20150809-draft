# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/ocaml/ocaml-3.09.2.ebuild,v 1.1 2006/04/27 19:26:41 mattam Exp $

inherit flag-o-matic eutils multilib

DESCRIPTION="fast modern type-inferring functional programming language descended from the ML (Meta Language) family"
HOMEPAGE="http://www.ocaml.org/"

SRC_URI="http://caml.inria.fr/distrib/ocaml-3.09/${P}.tar.bz2"

LICENSE="QPL-1.0 LGPL-2"
SLOT="0"
KEYWORDS="~ppc ~ppc64 ~x86"
IUSE="tcltk latex"

DEPEND="virtual/libc
	tcltk? ( >=dev-lang/tk-3.3.3 )"

pkg_setup() {
	ewarn
	ewarn "Building ocaml with unsafe CFLAGS can have unexpected results"
	ewarn "Please retry building with safer CFLAGS before reporting bugs"
	ewarn "Likewise, building with a hardened gcc is not possible."
	ewarn
}

src_compile() {
	filter-flags "-fstack-protector"
	replace-flags "-O?" -O2

	local myconf
	use tcltk || myconf="-no-tk"

	# Fix for bug #46703
	export LC_ALL=C

	./configure -prefix /usr \
		-bindir /usr/bin \
		-libdir /usr/$(get_libdir)/ocaml \
		-mandir /usr/share/man \
		--with-pthread ${myconf} || die

	sed -i -e "s/\(BYTECCCOMPOPTS=.*\)/\1 ${CFLAGS}/" config/Makefile
	sed -i -e "s/\(NATIVECCCOMPOPTS=.*\)/\1 ${CFLAGS}/" config/Makefile

	make world || die
	make opt || die
	make opt.opt || die
}

src_install() {
	make BINDIR=${D}/usr/bin \
		LIBDIR=${D}/usr/$(get_libdir)/ocaml \
		MANDIR=${D}/usr/share/man \
		install || die

	# compiler libs
	dodir /usr/lib/ocaml/compiler-libs
	insinto /usr/lib/ocaml/compiler-libs
	doins {utils,typing,parsing}/*.{mli,cmi,cmo,cmx,o}

	# headers
	dodir /usr/include
	dosym /usr/lib/ocaml/caml /usr/include/

	# silly, silly makefiles
	dosed "s:${D}::g" /usr/$(get_libdir)/ocaml/ld.conf

	# documentation
	dodoc Changes INSTALL LICENSE README Upgrading
}

pkg_postinst() {
	if use latex; then
		echo "TEXINPUTS=/usr/$(get_libdir)/ocaml/ocamldoc:" > /etc/env.d/99ocamldoc
	fi

	echo
	einfo "OCaml is not binary compatible from version to version,"
	einfo "so you (may) need to rebuild all packages depending on it that"
	einfo "are actually installed on your system."
	einfo "To do so, you can run: "
	einfo "sh ${FILESDIR}/ocaml-rebuild.sh [-h | emerge options]"
	einfo "Which will call emerge on all old packages with the given options"
	echo
}
