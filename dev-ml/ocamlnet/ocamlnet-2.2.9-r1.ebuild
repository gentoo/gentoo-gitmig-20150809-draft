# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/ocamlnet/ocamlnet-2.2.9-r1.ebuild,v 1.8 2008/05/12 07:04:40 aballier Exp $

inherit eutils findlib

EAPI="1"

DESCRIPTION="Modules for OCaml application-level Internet protocols"
HOMEPAGE="http://projects.camlcity.org/projects/ocamlnet.html"
SRC_URI="mirror://sourceforge/ocamlnet/${P}.tar.gz"

LICENSE="as-is GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="gtk ssl tk httpd +ocamlopt"
RESTRICT="installsources"

# the auth-dh compile flag has been disabled as well, since it depends on
# ocaml-cryptgps, which is not available.

DEPEND=">=dev-ml/findlib-1.0
		>=dev-ml/pcre-ocaml-5
		>=dev-ml/camlp5-5.05
		gtk? ( >=dev-ml/lablgtk-2 )
		ssl? ( dev-ml/ocaml-ssl )"
RDEPEND="${DEPEND}"

pkg_setup() {
	if use tk && ! built_with_use 'dev-lang/ocaml' tk ;
		 then die "If you want to enable tcl/tk, you need to rebuild dev-lang/ocaml with the 'tk' USE flag";
	fi
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

	epatch "${FILESDIR}/build_w_camlp5.dpatch"
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

src_compile() {
	./configure \
	    -bindir /usr/bin \
		-datadir /usr/share/${PN} \
		$(ocamlnet_use_enable gtk gtk2) \
		$(ocamlnet_use_enable ssl ssl) \
		$(ocamlnet_use_enable tk tcl) \
		$(ocamlnet_use_with httpd nethttpd) \
		|| die "Error : econf failed!"

	emake -j1 all || die "make failed"
	if use ocamlopt; then
		emake -j1 opt || die "make failed"
	fi
}

src_install() {
	export STRIP_MASK="*/bin/*"
	findlib_src_install
}
