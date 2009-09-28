# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/cryptokit/cryptokit-1.3.ebuild,v 1.5 2009/09/28 16:47:43 betelgeuse Exp $

EAPI="2"

inherit eutils findlib

DESCRIPTION="Cryptographic primitives library for Objective Caml"
HOMEPAGE="http://cristal.inria.fr/~xleroy/software.html"
SRC_URI="http://caml.inria.fr/distrib/bazar-ocaml/${P}.tar.gz"
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-fbsd"
IUSE="doc +ocamlopt"

DEPEND=">=dev-lang/ocaml-3.10.2[ocamlopt?]
		>=sys-libs/zlib-1.1"

src_prepare() {
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
	dodoc Changes README || die
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
