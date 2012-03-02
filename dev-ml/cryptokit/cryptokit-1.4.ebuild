# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/cryptokit/cryptokit-1.4.ebuild,v 1.3 2012/03/02 15:03:04 ago Exp $

EAPI="2"

inherit findlib multilib

DESCRIPTION="Cryptographic primitives library for Objective Caml"
HOMEPAGE="http://forge.ocamlcore.org/projects/cryptokit/"
SRC_URI="https://forge.ocamlcore.org/frs/download.php/460/${P}.tar.gz"
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~x86 ~x86-fbsd"
IUSE="debug doc +ocamlopt zlib"

DEPEND=">=dev-lang/ocaml-3.10.2[ocamlopt?]
		zlib? ( >=sys-libs/zlib-1.1 )"
RDEPEND="${DEPEND}"

oasis_use_enable() {
	echo "--override $2 `use $1 && echo \"true\" || echo \"false\"`"
}

src_configure() {
	./configure --prefix usr \
		--libdir /usr/$(get_libdir) \
		--destdir "${D}" \
		$(use_enable zlib) \
		$(oasis_use_enable debug debug) \
		$(oasis_use_enable ocamlopt is_native) \
		|| die
}

src_compile() {
	emake || die
	if use doc ; then
		emake doc || die
	fi
}

src_install() {
	findlib_src_install
	dodoc Changes README* AUTHORS* || die
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
