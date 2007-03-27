# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/ocamlnet/ocamlnet-2.2.4.ebuild,v 1.1 2007/03/27 18:15:39 aballier Exp $

inherit eutils findlib

DESCRIPTION="Modules for OCaml application-level Internet protocols"
HOMEPAGE="http://ocamlnet.sourceforge.net"
SRC_URI="mirror://sourceforge/ocamlnet/${P}.tar.gz"

LICENSE="as-is GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
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

src_unpack() {
	cd "${S}"
	unpack ${A}
	epatch "${FILESDIR}/ocamlnet-2.2.4-configure-fix.patch"
}

pkg_setup() {
	if use tk && ! built_with_use 'dev-lang/ocaml' tk ;
		 then die "If you want to enable tcl/tk, you need to rebuild dev-lang/ocaml with the 'tk' USE flag";
	fi
}

src_compile() {
	./configure \
	    --bindir /usr/bin \
		--datadir /usr/share/${PN} \
		$(use_enable gtk gtk2) \
		$(use_enable ssl) \
		$(use_enable tk tcl) \
		$(use_with httpd nethttpd) \
		|| die "Error : econf failed!"

	emake -j1 all opt || die "make failed"
}

src_install() {
	findlib_src_install
}
