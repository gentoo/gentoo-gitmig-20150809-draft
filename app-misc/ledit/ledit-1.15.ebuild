# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/ledit/ledit-1.15.ebuild,v 1.1 2007/08/30 12:53:27 aballier Exp $

inherit eutils

IUSE=""

DESCRIPTION="A line editor to be used with interactive commands."
SRC_URI="http://pauillac.inria.fr/~ddr/ledit/${P}.tgz"
HOMEPAGE="http://pauillac.inria.fr/~ddr/ledit/"

DEPEND=">=dev-lang/ocaml-3.10 dev-ml/camlp5"
RDEPEND="${DEPEND}"

SLOT="0"
LICENSE="BSD"
KEYWORDS="~amd64 ~x86"

src_compile()
{
	emake -j1 all || die "make failed"
	emake -j1 ledit.opt || die "make failed"
}

src_install()
{
	newbin ledit.opt ledit
	doman ledit.1
	dodoc CHANGES README
}
