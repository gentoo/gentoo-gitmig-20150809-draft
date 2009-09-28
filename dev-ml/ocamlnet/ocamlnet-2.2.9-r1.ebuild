# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/ocamlnet/ocamlnet-2.2.9-r1.ebuild,v 1.11 2009/09/28 16:43:22 betelgeuse Exp $

EAPI="2"

inherit eutils findlib

DESCRIPTION="Modules for OCaml application-level Internet protocols"
HOMEPAGE="http://projects.camlcity.org/projects/ocamlnet.html"
SRC_URI="mirror://sourceforge/ocamlnet/${P}.tar.gz"

LICENSE="as-is GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86 ~x86-fbsd"
IUSE="gtk ssl tk httpd +ocamlopt"
RESTRICT="installsources"

# the auth-dh compile flag has been disabled as well, since it depends on
# ocaml-cryptgps, which is not available.

DEPEND=">=dev-ml/findlib-1.0
		>=dev-ml/pcre-ocaml-5
		>=dev-ml/camlp5-5.05
		>=dev-lang/ocaml-3.10.2[tk?,ocamlopt?]
		gtk? ( >=dev-ml/lablgtk-2 )
		ssl? ( dev-ml/ocaml-ssl )"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/build_w_camlp5.dpatch"
	epatch "${FILESDIR}/${P}-glibc28.patch"
}

ocamlnet_use_with() {
	if use $1; then
		echo "-with-$2"
	else
		echo "-without-$2"
	fi
}

ocamlnet_use_enable() {
	if use $1; then
		echo "-enable-$2"
	else
		echo "-disable-$2"
	fi
}

src_configure() {
	./configure \
	    -bindir /usr/bin \
		-datadir /usr/share/${PN} \
		$(ocamlnet_use_enable gtk gtk2) \
		$(ocamlnet_use_enable ssl ssl) \
		$(ocamlnet_use_enable tk tcl) \
		$(ocamlnet_use_with httpd nethttpd) \
		|| die "Error : econf failed!"
}

src_compile() {
	emake -j1 all || die "make failed"
	if use ocamlopt; then
		emake -j1 opt || die "make failed"
	fi
}

src_install() {
	export STRIP_MASK="*/bin/*"
	findlib_src_install
}
