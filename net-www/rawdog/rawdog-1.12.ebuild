# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/rawdog/rawdog-1.12.ebuild,v 1.2 2004/06/25 01:11:09 agriffis Exp $

inherit distutils

DESCRIPTION="Rawdog - RSS Aggregator Without Delusions Of Grandeur"
SRC_URI="http://offog.org/files/${P}.tar.gz"
HOMEPAGE="http://offog.org/code/rawdog.html"
KEYWORDS="~x86 ~ppc ~sparc ~hppa ~amd64 ~s390 ~alpha ~ia64"
LICENSE="GPL-2"
SLOT="0"
IUSE=""
DOCS="NEWS config style.css"

pkg_postinst() {
	distutils_pkg_postinst
	einfo
	einfo "You can find sample config and style.css in /usr/share/doc/${PF}"
	einfo
}

