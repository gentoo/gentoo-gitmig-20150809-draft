# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/hevea/hevea-1.10.ebuild,v 1.1 2008/01/02 22:19:08 aballier Exp $

inherit eutils multilib

EAPI="1"

IUSE="+ocamlopt"

DESCRIPTION="HeVeA is a quite complete and fast LaTeX to HTML translator"
HOMEPAGE="http://pauillac.inria.fr/~maranget/hevea/"
SRC_URI="ftp://ftp.inria.fr/INRIA/moscova/hevea/${P}.tar.gz"

LICENSE="QPL"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

DEPEND=">=dev-lang/ocaml-3.07"

pkg_setup() {
	if use ocamlopt && ! built_with_use --missing true dev-lang/ocaml ocamlopt; then
		eerror "In order to build ${PN} with native code support from ocaml"
		eerror "You first need to have a native code ocaml compiler."
		eerror "You need to install dev-lang/ocaml with ocamlopt useflag on."
		die "Please install ocaml with ocamlopt useflag"
	fi
}

src_compile() {
	rm -f config.sh
	emake PREFIX=/usr DESTDIR="${D}" LIBDIR="/usr/$(get_libdir)/hevea" LATEXLIBDIR="/usr/$(get_libdir)/hevea" config.sh || die "Failed to create config.sh"
	if use ocamlopt; then
		emake PREFIX=/usr || die "Failed to build native code binaries"
	else
		emake PREFIX=/usr TARGET=byte || die "Failed to build bytecode binaries"
	fi
}

src_install() {
	if use ocamlopt; then
		emake DESTDIR="${D}" PREFIX=/usr install || die "Install failed"
	else
		emake DESTDIR="${D}" PREFIX=/usr TARGET=byte install || die "Install failed"
	fi

	doenvd "${FILESDIR}"/99hevea

	dodoc README CHANGES
}
