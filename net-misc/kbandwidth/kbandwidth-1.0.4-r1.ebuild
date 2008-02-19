# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/kbandwidth/kbandwidth-1.0.4-r1.ebuild,v 1.5 2008/02/19 01:57:51 ingmar Exp $

inherit kde

DESCRIPTION="Network monitoring Kicker-applet for KDE 3.x"
HOMEPAGE="http://www.kde-apps.org/content/show.php?content=18939"
SRC_URI="http://people.freenet.de/stealth/kbandwidth/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha amd64 ppc ~sparc x86"
IUSE=""

DEPEND=""
RDEPEND="|| ( =kde-base/kdebase-3.5* =kde-base/kicker-3.5* )"

need-kde 3.5

src_unpack() {
	kde_src_unpack

	# Fixes bug 202388. Upstream is dead so this hack will have to suffice.
	sed -i -e 's:p\.begin://p.begin:' "${S}"/src/fenster.cpp || die "sed failed"
}
