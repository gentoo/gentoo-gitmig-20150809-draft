# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/ocamlnet/ocamlnet-0.98.ebuild,v 1.7 2005/03/30 05:10:28 vapier Exp $

inherit findlib

DESCRIPTION="Modules for O'Caml application-level Internet protocols"
HOMEPAGE="http://ocamlnet.sourceforge.net"
SRC_URI="mirror://sourceforge/ocamlnet/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND=">=dev-ml/pcre-ocaml-4.31.0"

S="${WORKDIR}/${P}/src"

DATADIR=/usr/share/${PN}

src_compile() {
	./configure -enable-compatcgi -with-pop -datadir ${DATADIR}  || die "configure failed"
	make all opt || die "make failed"
}

src_install() {
	findlib_src_install NET_DB_DIR="${D}${DATADIR}"

	cd "${WORKDIR}/${P}"
	dodoc README
	dohtml doc/intro/html/*
}
