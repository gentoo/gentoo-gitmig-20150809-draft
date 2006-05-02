# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/rawdog/rawdog-2.6.ebuild,v 1.5 2006/05/02 00:35:40 weeve Exp $

inherit distutils

DESCRIPTION="Rawdog - RSS Aggregator Without Delusions Of Grandeur"
SRC_URI="http://offog.org/files/${P}.tar.gz"
HOMEPAGE="http://offog.org/code/rawdog.html"
KEYWORDS="alpha ~amd64 ~hppa ia64 ~ppc ~s390 sparc x86"
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

