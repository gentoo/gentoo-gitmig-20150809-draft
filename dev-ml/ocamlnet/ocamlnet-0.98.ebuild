# Copyright 1999-2005 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/ocamlnet/ocamlnet-0.98.ebuild,v 1.1 2005/02/17 23:30:15 mattam Exp $

inherit findlib

DESCRIPTION="Modules for O'Caml application-level Internet protocols"
HOMEPAGE="http://ocamlnet.sourceforge.net"
SRC_URI="mirror://sourceforge/ocamlnet/${P}.tar.gz"
LICENSE="as-is"

IUSE=""
KEYWORDS="~x86 ~ppc"
DEPEND=">=dev-ml/pcre-ocaml-4.31.0"

S="${WORKDIR}/${P}/src"

src_compile() {
	./configure || die
	make all opt || die
}

src_install() {	
	findlib_src_install NET_DB_DIR=${D}${OCAML_SITELIB}/netstring

	cd ${WORKDIR}/${P}
	dodoc README
	dohtml doc/intro/html/*
}
