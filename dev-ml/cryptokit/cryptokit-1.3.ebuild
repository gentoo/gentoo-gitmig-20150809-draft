# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/cryptokit/cryptokit-1.3.ebuild,v 1.3 2008/01/02 20:07:27 aballier Exp $

inherit eutils findlib

EAPI="1"

DESCRIPTION="Cryptographic primitives library for Objective Caml"
HOMEPAGE="http://cristal.inria.fr/~xleroy/software.html"
SRC_URI="http://caml.inria.fr/distrib/bazar-ocaml/${P}.tar.gz"
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc +ocamlopt"

DEPEND=">=dev-lang/ocaml-3.09
		>=sys-libs/zlib-1.1"

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
	sed -e "s/VERSION/${PV}/" "${FILESDIR}/META" >> META
	epatch "${FILESDIR}/${PN}-gentoo.patch"
}

src_compile() {
	emake all || die "emake all failed"
	if use ocamlopt; then
		emake allopt || die "emake allopt failed, is ocamlopt missing ?"
	fi
}

src_install() {
	findlib_src_install
	dodoc Changes README
	use doc && dohtml doc/*.html doc/*.css
}

pkg_postinst() {
	elog ""
	elog "This library uses the /dev/random device to generate "
	elog "random data and RSA keys.  The device should either be"
	elog "built into the kernel or provided as a module. An"
	elog "alternative is to use the Entropy Gathering Daemon"
	elog "(http://egd.sourceforge.net).  Please note that the"
	elog "remainder of the library will still work even in the"
	elog "absence of a one of these sources of randomness."
	elog ""
}

src_test() {
	echo ""
	einfo "You must have either /dev/random or the Entropy Gathering"
	einfo "Daemon (EGD) for this test to succeed!"
	echo ""

	emake test || die "emake test failed"
}
