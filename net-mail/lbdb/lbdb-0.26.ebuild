# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-mail/lbdb/lbdb-0.26.ebuild,v 1.2 2002/07/11 06:30:47 drobbins Exp $

MY_P=${P/-/_}
S=${WORKDIR}/${P}
DESCRIPTION="Little Brother database"
SRC_URI="http://www.spinnaker.de/debian/${MY_P}.tar.gz"
HOMEPAGE="http://www.spinnaker.de/debian/lbdb.html"
DEPEND=">=net-mail/mutt-1.2.5"
SLOT="0"
KEYWORDS="x86"
LICENSE="GPL-2"

#RDEPEND=""
# NOTE: You need to have the Palm::PDB and Palm::Address Perl modules
# installed to use the m_palm module. use perl's CPAN module to fetch
# and install "perl -MCPAN -e shell" see "perldoc CPAN"



src_compile() {

	econf --libdir=/usr/lib/lbdb || die
	
	emake || die
}

src_install () {
	
    make install_prefix=${D} install || die
	 dodoc README INSTALL COPYING NEWS TODO
}
