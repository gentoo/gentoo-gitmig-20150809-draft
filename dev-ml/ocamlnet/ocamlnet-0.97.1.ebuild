# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/ocamlnet/ocamlnet-0.97.1.ebuild,v 1.3 2004/09/30 18:48:06 mattam Exp $

inherit findlib

DESCRIPTION="Modules for O'Caml application-level Internet protocols"
HOMEPAGE="http://ocamlnet.sourceforge.net"
SRC_URI="mirror://sourceforge/ocamlnet/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ~ppc amd64"

DEPEND=">=dev-ml/pcre-ocaml-5.03.3"

IUSE=""
S="${WORKDIR}/${P}/src"

src_compile() {
	./configure || die
	make all opt || die
}

src_install() {
	findlib_src_install NET_DB_DIR=${D}`ocamlfind printconf destdir`/netstring

	cd ${WORKDIR}/${P}
	dodoc README
	dohtml doc/intro/html/*
}
