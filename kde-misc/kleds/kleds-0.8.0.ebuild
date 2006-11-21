# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kleds/kleds-0.8.0.ebuild,v 1.5 2006/11/21 06:47:04 genstef Exp $

inherit kde
need-kde 3.0

DESCRIPTION="A KDE applet that displays the keyboard lock states."
HOMEPAGE="http://www.hansmatzen.de/en/kleds.html"
SRC_URI="http://www.hansmatzen.de/software/kleds/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~sparc x86"
IUSE=""

S="${WORKDIR}/kleds-${PV}"
