# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/delta/delta-20050913.ebuild,v 1.4 2006/03/17 23:31:58 halcy0n Exp $

MY_PV="${PV:0:4}.${PV:4:2}.${PV:6:2}"
DESCRIPTION="Heuristically minimizes interesting files"
HOMEPAGE="http://delta.tigris.org/"
SRC_URI="http://delta.tigris.org/files/documents/3103/25616/${PN}-${MY_PV}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~ppc ~ppc64 ~x86"

IUSE=""

DEPEND="dev-lang/perl"

S="${WORKDIR}"/${PN}-${MY_PV}

src_compile() {
	emake CFLAGS="${CFLAGS}"
}

src_install() {
	exeinto /usr/bin/
	cd "${S}"
	doexe delta multidelta topformflat
}
