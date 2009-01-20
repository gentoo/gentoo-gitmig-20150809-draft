# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/ocaml/ocaml-3.08.4.ebuild,v 1.20 2009/01/20 08:43:57 aballier Exp $

inherit flag-o-matic eutils multilib

DESCRIPTION="Fast modern type-inferring functional programming language descended from the ML family"
HOMEPAGE="http://www.ocaml.org/"

SRC_URI="http://caml.inria.fr/distrib/ocaml-3.08/${P}.tar.bz2"

LICENSE="QPL-1.0 LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~ppc ~ppc64 -s390 sparc ~x86"
IUSE="tk latex"

DEPEND="tk? ( >=dev-lang/tk-3.3.3 )"
RDEPEND="${DEPEND}"

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
	use tk || myconf="-no-tk"

	# Fix for bug #23767.
	if [ "${ARCH}" = "sparc" ]; then
		myconf="${myconf} -host sparc-unknown-linux-gnu"
	fi

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
	# Native code generation unsupported on some archs
	if ! use ppc64 ; then
		make opt || die
		make opt.opt || die
	fi
}

src_install() {
	make BINDIR="${D}/usr/bin" \
		LIBDIR="${D}/usr/$(get_libdir)/ocaml" \
		MANDIR="${D}/usr/share/man" \
		install || die

	# compiler libs
	dodir /usr/lib/ocaml/compiler-libs
	insinto /usr/lib/ocaml/compiler-libs
	doins {utils,typing,parsing}/*.{mli,cmi,cmo,cmx,o}

	# headers
	dodir /usr/include
	dosym /usr/include/caml /usr/lib/ocaml/caml

	# silly, silly makefiles
	dosed "s:${D}::g" /usr/$(get_libdir)/ocaml/ld.conf

	# documentation
	dodoc Changes INSTALL README Upgrading
}

pkg_postinst() {
	if use latex; then
		echo "TEXINPUTS=/usr/$(get_libdir)/ocaml/ocamldoc:" > /etc/env.d/99ocamldoc
	fi

	echo
	elog "OCaml is not binary compatible from version to version,"
	elog "so you (may) need to rebuild all packages depending on it that"
	elog "are actually installed on your system."
	elog "To do so, you can run: "
	elog "sh '${FILESDIR}/ocaml-rebuild.sh' [-h | emerge options]"
	elog "Which will call emerge on all old packages with the given options"
	echo
}
