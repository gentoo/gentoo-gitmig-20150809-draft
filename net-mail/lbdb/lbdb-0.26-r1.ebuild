# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/lbdb/lbdb-0.26-r1.ebuild,v 1.12 2004/07/15 01:49:39 agriffis Exp $

IUSE="pda"

MY_P=${P/-/_}
DESCRIPTION="Little Brother database"
SRC_URI="http://www.spinnaker.de/debian/${MY_P}.tar.gz"
HOMEPAGE="http://www.spinnaker.de/debian/lbdb.html"

DEPEND=">=mail-client/mutt-1.2.5"


SLOT="0"
KEYWORDS="x86 ppc sparc"
LICENSE="GPL-2"

RDEPEND="pda? ( dev-perl/p5-Palm )"

src_compile() {

	econf --libdir=/usr/lib/lbdb || die
	emake || die
}

src_install () {

	make install_prefix=${D} install || die
	dodoc README INSTALL COPYING NEWS TODO
}
