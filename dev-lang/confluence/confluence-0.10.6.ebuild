# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/confluence/confluence-0.10.6.ebuild,v 1.1 2008/01/06 20:19:37 aballier Exp $

inherit eutils

EAPI="1"

DESCRIPTION="a functional programming language for reactive system design (digital logic, hard-real-time software)"
HOMEPAGE="http://www.funhdl.org/wiki/doku.php?id=confluence"
SRC_URI="http://www.funhdl.org/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE="+ocamlopt"

RDEPEND="dev-lang/ocaml"
DEPEND="${RDEPEND}
	sys-apps/sed"

pkg_setup() {
	if use ocamlopt && ! built_with_use --missing true dev-lang/ocaml ocamlopt; then
		eerror "In order to build ${PN} with native code support from ocaml"
		eerror "You first need to have a native code ocaml compiler."
		eerror "You need to install dev-lang/ocaml with ocamlopt useflag on."
		die "Please install ocaml with ocamlopt useflag"
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	# Install non binary stuff in share...
	sed -i -e "s:lib/confluence:share/confluence:" Makefile || die "failed to sed the makefile"
	sed -i -e "s:lib/confluence:share/confluence:" src/cfeval/cf.ml || die "failed to sed ml files"
	sed -i -e "s:lib/confluence:share/confluence:" src/cfeval/cfParserUtil.ml || die "failed to sed ml files"
	if ! use ocamlopt; then
		sed -i -e "s:cmxa:cma:" src/Makefile || die "failed to disable ocamlopt	support"
		sed -i -e "s:cmx:cmo:" src/Makefile || die "failed to disable ocamlopt	support"
	fi
}

src_compile() {
	if use ocamlopt; then
		emake -j1 PREFIX="${D}/usr" OCAMLLIB=`ocamlc -where` || die "failed to build"
	else
		emake -j1 OCAMLOPT="ocamlc" OCAMLC="ocamlc" PREFIX="${D}/usr" OCAMLLIB=`ocamlc -where` || die "failed to build"
	fi
}

src_install() {
	emake -j1 PREFIX="${D}/usr" OCAMLLIB=`ocamlc -where` install || die "install failed"
	echo "CF_LIB=/usr/share/confluence" > "${T}/99${PN}"
	doenvd "${T}/99${PN}"
	dodoc NEWS
}
