# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/redland/redland-0.9.18.ebuild,v 1.2 2004/08/30 23:30:11 dholm Exp $

DESCRIPTION="High-level interface for the Resource Description Framework"
HOMEPAGE="http://www.redland.opensource.ac.uk/"
SRC_URI="http://www.redland.opensource.ac.uk/dist/source/${P}.tar.gz"

LICENSE="LGPL-2 MPL-1.1"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="mysql"

DEPEND="mysql? ( dev-db/mysql )"

src_compile() {
	econf `use_with mysql` || die
	emake || die
}

src_install() {
	make install DESTDIR=${D} || die
	dodoc AUTHORS ChangeLog* INSTALL NEWS README TODO
	dohtml *.html
}
