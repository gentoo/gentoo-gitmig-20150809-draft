# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/netclient/netclient-0.3.1.ebuild,v 1.1 2005/03/08 23:39:57 mattam Exp $

inherit findlib

DESCRIPTION="A wannabe univeral network client"
HOMEPAGE="http://www.ocaml-programming.de/packages/"
LICENSE="MIT X11"
SRC_URI="http://www.ocaml-programming.de/packages/${P}.tar.gz"

IUSE=""
DEPEND=">=dev-ml/ocamlnet-0.98
dev-ml/xstr"

SLOT="0"
RDEPEND=""
KEYWORDS="x86 ppc"
S="${WORKDIR}/${PN}-0.3"

src_compile()
{
	make all opt || die
}

src_install()
{
	findlib_src_install
	dodoc LICENSE README RELEASE
}
