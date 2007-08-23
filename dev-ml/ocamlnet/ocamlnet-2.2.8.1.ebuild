# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/ocamlnet/ocamlnet-2.2.8.1.ebuild,v 1.1 2007/08/23 09:02:23 aballier Exp $

inherit eutils findlib

DESCRIPTION="Modules for OCaml application-level Internet protocols"
HOMEPAGE="http://ocamlnet.sourceforge.net"
SRC_URI="mirror://sourceforge/ocamlnet/${P}.tar.gz"

LICENSE="as-is GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="gtk ssl tk httpd"

# the auth-dh compile flag has been disabled as well, since it depends on
# ocaml-cryptgps, which is not available.

DEPEND="!dev-ml/equeue
		!dev-ml/rpc
		!dev-ml/netclient
		>=dev-ml/findlib-1.0
		>=dev-ml/pcre-ocaml-5
		gtk? ( >=dev-ml/lablgtk-2 )
		ssl? ( dev-ml/ocaml-ssl )"

pkg_setup() {
	if use tk && ! built_with_use 'dev-lang/ocaml' tk ;
		 then die "If you want to enable tcl/tk, you need to rebuild dev-lang/ocaml with the 'tk' USE flag";
	fi
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

	emake -j1 all opt || die "make failed"
}

src_install() {
	findlib_src_install
}
