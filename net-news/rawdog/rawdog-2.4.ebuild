# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/rawdog/rawdog-2.4.ebuild,v 1.1 2005/07/25 23:12:25 lucass Exp $

inherit distutils

DESCRIPTION="Rawdog - RSS Aggregator Without Delusions Of Grandeur"
SRC_URI="http://offog.org/files/${P}.tar.gz"
HOMEPAGE="http://offog.org/code/rawdog.html"
KEYWORDS="~x86 ~ppc ~sparc ~hppa ~amd64 ~s390 ~alpha ~ia64"
LICENSE="GPL-2"
SLOT="0"
IUSE=""
DOCS="NEWS PLUGINS config style.css"

pkg_postinst() {
	distutils_pkg_postinst
	einfo
	einfo "You can find sample config and style.css in /usr/share/doc/${PF}"
	einfo
	einfo "If you are upgrading rawdog from 1.x, you"
	einfo "need to perform as user the following steps:"
	einfo
	einfo "$ cp -R ~/.rawdog ~/.rawdog-old"
	einfo "$ rm ~/.rawdog/state"
	einfo "$ rawdog -u"
	einfo "$ rawdog --upgrade ~/.rawdog-old ~/.rawdog (to copy the state)"
	einfo "$ rawdog -w"
	einfo "$ rm -r ~/.rawdog-old (once you're happy with the new version)"
	einfo
}

