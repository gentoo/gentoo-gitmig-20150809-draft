# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/rawdog/rawdog-2.6.ebuild,v 1.2 2006/02/05 20:57:29 antarus Exp $

inherit distutils

DESCRIPTION="Rawdog - RSS Aggregator Without Delusions Of Grandeur"
SRC_URI="http://offog.org/files/${P}.tar.gz"
HOMEPAGE="http://offog.org/code/rawdog.html"
KEYWORDS="x86 ~ppc ~sparc ~hppa ~amd64 ~s390 ~alpha ~ia64"
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

