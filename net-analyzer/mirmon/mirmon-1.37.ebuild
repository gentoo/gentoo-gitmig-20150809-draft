# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/mirmon/mirmon-1.37.ebuild,v 1.1 2007/07/05 10:40:48 armin76 Exp $

inherit webapp

DESCRIPTION="Monitor the status of mirrors"
HOMEPAGE="http://www.cs.uu.nl/people/henkp/mirmon/"
SRC_URI="http://www.cs.uu.nl/people/henkp/$PN/src/$P.tar.gz"

LICENSE="GPL-2"

KEYWORDS="~ppc ~x86"

DEPEND=">=dev-lang/perl-5.8.5-r2"


src_install() {
	webapp_src_preinst

	for file in mirmon.html mirmon.txt; do
		dodoc ${file}
		rm -f ${file}
	done
	cp -R . ${D}/${MY_HTDOCSDIR}

	webapp_src_install
}
