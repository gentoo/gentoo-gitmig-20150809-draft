# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/freshmeat-submit/freshmeat-submit-1.4.ebuild,v 1.1 2004/06/12 12:44:09 jmglov Exp $

DESCRIPTION="A tool to submit version updates to freshmeat.net. It is designed to run from within a project release script, and uses freshmeat.net's XML- RPC interface."
HOMEPAGE="http://www.catb.org/~esr/freshmeat-submit/"
SRC_URI="http://www.catb.org/~esr/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

RDEPEND="virtual/python"
DEPEND="${RDEPEND}"

src_compile() {
	einfo "Nothing to compile"
}

src_install() {
	doman freshmeat-submit.1
	dodoc AUTHORS COPYING README freshmeat-submit.spec freshmeat-submit.xml
	dobin freshmeat-submit
}
