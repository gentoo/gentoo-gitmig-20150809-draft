# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/rawdog/rawdog-2.6.ebuild,v 1.7 2007/03/04 18:34:23 lucass Exp $

inherit distutils

DESCRIPTION="Rawdog - RSS Aggregator Without Delusions Of Grandeur"
SRC_URI="http://offog.org/files/${P}.tar.gz"
HOMEPAGE="http://offog.org/code/rawdog.html"
KEYWORDS="alpha ~amd64 ~hppa ia64 ~ppc s390 sparc x86"
LICENSE="GPL-2"
SLOT="0"
IUSE=""
DOCS="NEWS PLUGINS config style.css"

pkg_postinst() {
	distutils_pkg_postinst
	elog
	elog "You can find sample config and style.css in /usr/share/doc/${PF}"
	elog
	elog "If you are upgrading rawdog from 1.x, you"
	elog "need to perform as user the following steps:"
	elog
	elog "$ cp -R ~/.rawdog ~/.rawdog-old"
	elog "$ rm ~/.rawdog/state"
	elog "$ rawdog -u"
	elog "$ rawdog --upgrade ~/.rawdog-old ~/.rawdog (to copy the state)"
	elog "$ rawdog -w"
	elog "$ rm -r ~/.rawdog-old (once you're happy with the new version)"
	elog
}
