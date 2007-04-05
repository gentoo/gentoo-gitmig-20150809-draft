# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kima/kima-0.7.1.ebuild,v 1.1 2007/04/05 21:09:18 genstef Exp $

inherit kde

DESCRIPTION="Hardware monitoring applet for Kicker"
HOMEPAGE="http://www.kde-apps.org/content/show.php?content=33257"
SRC_URI="http://www.elliptique.net/~ken/${PN}/${P}.tar.gz"

KEYWORDS="~amd64 ~x86"

SLOT="0"
LICENSE="GPL-2"
IUSE=""

need-kde 3.5
