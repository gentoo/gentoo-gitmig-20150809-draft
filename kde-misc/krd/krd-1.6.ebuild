# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/krd/krd-1.6.ebuild,v 1.1 2007/10/26 20:23:01 philantrop Exp $

inherit kde

DESCRIPTION="kde remote desktop connections manager"
HOMEPAGE="http://krdm.sourceforge.net/"
SRC_URI="mirror://sourceforge/krdm/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="|| ( >=net-misc/tightvnc-1.2.9-r3 >=net-misc/rdesktop-1.4.1 )"
DEPEND=""

need-kde 3.5

S="${WORKDIR}/${PN}"
