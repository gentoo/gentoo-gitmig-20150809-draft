# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/freshmeat-submit/freshmeat-submit-1.6.ebuild,v 1.4 2009/10/12 20:08:13 ssuominen Exp $

DESCRIPTION="A utility for submitting version updates to freshmeat.net, designed to run from within a project release script, using freshmeat.net's XML- RPC interface."
HOMEPAGE="http://www.catb.org/~esr/freshmeat-submit/"
SRC_URI="http://www.catb.org/~esr/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc x86"
IUSE=""

RDEPEND="virtual/python"
DEPEND="${RDEPEND}"

src_compile() { :; }

src_install() {
	doman freshmeat-submit.1 || die "doman failed"
	dodoc AUTHORS README || die "dodoc failed"
	dobin freshmeat-submit || die "dobin failed"
}
