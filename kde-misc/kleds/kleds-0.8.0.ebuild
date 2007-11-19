# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kleds/kleds-0.8.0.ebuild,v 1.6 2007/11/19 15:52:45 philantrop Exp $

inherit kde

DESCRIPTION="A KDE applet that displays the keyboard lock states."
HOMEPAGE="http://www.hansmatzen.de/?page_id=33&language=en"
SRC_URI="http://www.hansmatzen.de/wp-content/software/kleds/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~sparc x86"
IUSE=""

need-kde 3.5

S="${WORKDIR}/kleds-${PV}"
