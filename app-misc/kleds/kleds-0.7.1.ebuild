# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/kleds/kleds-0.7.1.ebuild,v 1.12 2004/06/19 03:31:46 mr_bones_ Exp $

inherit kde
need-kde 3.0

DESCRIPTION="A KDE applet that displays the keyboard lock states."
HOMEPAGE="http://www.hansmatzen.de/english/kleds.html"
SRC_URI="http://www.hansmatzen.de/software/kleds/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~sparc"
IUSE=""

S="${WORKDIR}/kleds-${PV}"
