# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/kleds/kleds-0.7.1.ebuild,v 1.5 2002/10/04 04:56:04 vapier Exp $
inherit kde-base || die

need-kde 3.0 

S=${WORKDIR}/kleds-${PV}
DESCRIPTION="A KDE applet that displays the keyboard lock states."
SRC_URI="http://www.hansmatzen.de/software/kleds/${P}.tar.gz"
HOMEPAGE="http://www.hansmatzen.de/english/kleds.html"


LICENSE="GPL-2"
KEYWORDS="x86"
