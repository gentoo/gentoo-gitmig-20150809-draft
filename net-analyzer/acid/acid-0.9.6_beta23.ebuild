# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/acid/acid-0.9.6_beta23.ebuild,v 1.1 2004/07/24 13:20:24 eldad Exp $

inherit webapp

MY_P=${P/_beta/b}
DESCRIPTION="Snort ACID - Analysis Console for Intrusion Databases"
HOMEPAGE="http://acidlab.sourceforge.net"
SRC_URI="http://acidlab.sourceforge.net/${MY_P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~x86"

IUSE="apache2"
S=${WORKDIR}/${PN}

# Note: jpgraph is an unstable package
DEPEND="apache2? ( >=net-www/apache-2 ) : ( =net-www/apache-1.* )
		>=dev-php/adodb-4.0.5
		>=dev-php/jpgraph-1.12.2
		net-analyzer/snort"

src_install () {
	webapp_src_preinst

	insinto ${MY_HTDOCSDIR}
	doins *

	webapp_src_install
}

src_compile () {
	einfo "Nothing to compile."
}

pkg_postinst() {
	webapp_pkg_postinst

	echo ""
	einfo "Note: ACID is installed as a webapp."
	einfo "The ACID database is an extension of the SNORT database."
	einfo "To setup ACID database look in the README"
	echo ""
}

