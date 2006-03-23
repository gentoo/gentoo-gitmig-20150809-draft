# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/katapult/katapult-0.3.1.3.ebuild,v 1.1 2006/03/23 11:47:51 flameeyes Exp $

inherit kde

DESCRIPTION="KDE application to allow fast access to applications, bookmarks and other items."
HOMEPAGE="http://www.thekatapult.org.uk/"
SRC_URI="mirror://sourceforge/${PN}/${P/-/_}.orig.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

need-kde 3.3
