# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/ispell-no/ispell-no-2.0.ebuild,v 1.1 2005/09/20 19:00:27 arj Exp $

MY_P="norsk-${PV}"
S="${WORKDIR}/norsk"
DESCRIPTION="A Norwegian dictionary for ispell"
SRC_URI="http://www.uio.no/~runekl/ispell-${MY_P}.tar.gz"
HOMEPAGE="http://www.stanford.edu/services/pubsw/package/dicts/norsk.html"

SLOT="0"
LICENSE="GPL-2"
IUSE=""
KEYWORDS="~x86 ~amd64"

DEPEND="app-text/ispell"

src_compile() {
	      make BUILDHASH="/usr/bin/buildhash" all || die
}

src_install () {
	    insinto /usr/lib/ispell
	    doins norsk.aff norsk.hash norsk.munch.hash nynorsk.aff nynorsk.hash
}
