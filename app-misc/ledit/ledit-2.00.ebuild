# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/ledit/ledit-2.00.ebuild,v 1.1 2008/01/23 18:54:49 aballier Exp $

inherit eutils

EAPI="1"

RESTRICT="installsources"
IUSE="+ocamlopt"

DESCRIPTION="A line editor to be used with interactive commands."
SRC_URI="http://pauillac.inria.fr/~ddr/ledit/distrib/src/${P}.tgz"
HOMEPAGE="http://pauillac.inria.fr/~ddr/ledit/"

DEPEND=">=dev-lang/ocaml-3.09 dev-ml/camlp5"
RDEPEND="${DEPEND}"

SLOT="0"
LICENSE="BSD"
KEYWORDS="~amd64 ~ppc ~x86"

pkg_setup() {
	if use ocamlopt && ! built_with_use --missing true dev-lang/ocaml ocamlopt; then
		eerror "In order to build ${PN} with native code support from ocaml"
		eerror "You first need to have a native code ocaml compiler."
		eerror "You need to install dev-lang/ocaml with ocamlopt useflag on."
		die "Please install ocaml with ocamlopt useflag"
	fi
}

src_compile()
{
	emake -j1 all || die "make failed"
	if use ocamlopt; then
		emake -j1 ledit.opt || die "make failed"
	else
		# If using bytecode we dont want to strip the binary as it would remove the
		# bytecode and only leave ocamlrun...
		export STRIP_MASK="*/bin/*"
	fi
}

src_install()
{
	if use ocamlopt; then
		newbin ledit.opt ledit
	else
		newbin ledit.out ledit
	fi
	doman ledit.1
	dodoc CHANGES README
}
