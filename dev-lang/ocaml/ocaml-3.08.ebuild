# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/ocaml/ocaml-3.08.ebuild,v 1.9 2004/10/23 06:07:00 mr_bones_ Exp $

inherit flag-o-matic eutils

DESCRIPTION="fast modern type-inferring functional programming language descended from the ML (Meta Language) family"
HOMEPAGE="http://www.ocaml.org/"

SRC_URI="http://caml.inria.fr/distrib/ocaml-3.08/${P}.0.tar.gz"

LICENSE="QPL-1.0 LGPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc ~alpha ~ia64 amd64 hppa ~ppc-macos"
IUSE="tcltk latex"

DEPEND="virtual/libc
	tcltk? ( >=dev-lang/tk-3.3.3 )"

S="${WORKDIR}/${P}.0"

pkg_setup() {
	ewarn
	ewarn "Building ocaml with unsafe CFLAGS can have unexpected results"
	ewarn "Please retry building with safer CFLAGS before reporting bugs"
	ewarn
}

src_compile() {
	filter-flags "-fstack-protector"
	replace-flags "-O?" -O2

	local myconf
	use tcltk || myconf="-no-tk"

	# Fix for bug #23767.
	if [ "${ARCH}" = "sparc" ]; then
		myconf="${myconf} -host sparc-unknown-linux-gnu"
	fi

	# Fix for bug #46703
	export LC_ALL=C

	./configure -prefix /usr \
		-bindir /usr/bin \
		-libdir /usr/lib/ocaml \
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
		LIBDIR=${D}/usr/lib/ocaml \
		MANDIR=${D}/usr/share/man \
		install || die

	# silly, silly makefiles
	dosed "s:${D}::g" /usr/lib/ocaml/ld.conf

	# documentation
	dodoc Changes INSTALL LICENSE README Upgrading
}

pkg_postinst() {
	ranlib /usr/lib/ocaml/*.a

	if use latex; then
		echo "TEXINPUTS=/usr/lib/ocaml/ocamldoc:" > /etc/env.d/99ocamldoc
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
