# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/netclient/netclient-0.3.1.ebuild,v 1.3 2005/03/27 15:18:54 mattam Exp $

inherit findlib

DESCRIPTION="A wannabe univeral network client"
HOMEPAGE="http://www.ocaml-programming.de/packages/"
SRC_URI="http://www.ocaml-programming.de/packages/${P}.tar.gz"

LICENSE="MIT X11"
SLOT="0"
KEYWORDS="ppc x86"
IUSE=""

DEPEND=">=dev-ml/ocamlnet-0.98
	dev-ml/xstr"
RDEPEND=""

S="${WORKDIR}/${PN}-0.3"

src_compile() {
	make all opt || die "make failed"
}

src_install() {
	findlib_src_install
	dodoc LICENSE README RELEASE
}
