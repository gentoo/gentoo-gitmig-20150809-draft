# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/freshmeat-submit/freshmeat-submit-1.6.ebuild,v 1.1 2004/12/10 14:09:46 ka0ttic Exp $

DESCRIPTION="A utility for submitting version updates to freshmeat.net, designed to run from within a project release script, using freshmeat.net's XML- RPC interface."
HOMEPAGE="http://www.catb.org/~esr/freshmeat-submit/"
SRC_URI="http://www.catb.org/~esr/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

RDEPEND="virtual/python"
DEPEND="${RDEPEND}"

src_compile() {
	einfo "Nothing to compile"
}

src_install() {
	doman freshmeat-submit.1 || die "doman failed"
	dodoc AUTHORS COPYING README || die "dodoc failed"
	dobin freshmeat-submit || die "dobin failed"
}
