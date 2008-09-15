# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/ispell-no/ispell-no-2.0.ebuild,v 1.2 2008/09/15 16:35:02 pva Exp $

MY_P="norsk-${PV}"
DESCRIPTION="A Norwegian dictionary for ispell"
SRC_URI="http://www.uio.no/~runekl/ispell-${MY_P}.tar.gz"
HOMEPAGE="http://www.stanford.edu/services/pubsw/package/dicts/norsk.html"

SLOT="0"
LICENSE="GPL-2"
IUSE=""
KEYWORDS="~x86 ~amd64"

DEPEND="app-text/ispell"

S=${WORKDIR}/norsk

src_compile() {
	export LC_ALL=C #227055
	make BUILDHASH="/usr/bin/buildhash" all || die
}

src_install () {
	    insinto /usr/lib/ispell
	    doins norsk.{aff,hash,munch.hash} nynorsk.{aff,hash} || die
}
