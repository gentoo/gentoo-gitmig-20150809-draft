# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/ocaml/ocaml-3.07-r1.ebuild,v 1.16 2004/07/25 20:07:57 alexander Exp $

inherit flag-o-matic eutils

DESCRIPTION="fast modern type-inferring functional programming language descended from the ML (Meta Language) family"
HOMEPAGE="http://www.ocaml.org/"

SRC_URI="http://caml.inria.fr/distrib/${P}/${P}.tar.gz
	http://caml.inria.fr/distrib/${P}/${P}-patch2.diffs"

LICENSE="QPL-1.0 LGPL-2"
SLOT="0"
KEYWORDS="x86 ~sparc ~ppc alpha ~ia64 ~amd64 hppa macos"
IUSE="tcltk"

DEPEND="virtual/libc
	tcltk? ( >=dev-lang/tk-3.3.3 )"

src_unpack() {
	unpack ${P}.tar.gz
	cd ${S}
	use hppa && epatch ${FILESDIR}/${P}-hppa.patch
	epatch ${DISTDIR}/${P}-patch2.diffs
	grep -rle "head -1" . | xargs sed -i "s:head -1:head -n 1:g"
}

src_compile() {
	filter-flags "-fstack-protector"

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
	echo
	einfo "OCaml is not binary compatible from version to version,"
	einfo "so you (may) need to rebuild all packages depending on it that"
	einfo "are actually installed on your system."
	einfo "To do so, you can run: "
	einfo "sh ${FILESDIR}/ocaml-rebuild.sh [-h | emerge options]"
	einfo "Which will call emerge on all old packages with the given options"
	echo
}