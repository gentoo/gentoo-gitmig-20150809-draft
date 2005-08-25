# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/rawdog/rawdog-1.12.ebuild,v 1.3 2005/08/25 00:52:10 agriffis Exp $

inherit distutils

DESCRIPTION="Rawdog - RSS Aggregator Without Delusions Of Grandeur"
SRC_URI="http://offog.org/files/${P}.tar.gz"
HOMEPAGE="http://offog.org/code/rawdog.html"
KEYWORDS="~alpha ~amd64 ~hppa ia64 ~ppc ~s390 ~sparc x86"
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

