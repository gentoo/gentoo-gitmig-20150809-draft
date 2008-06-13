# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/switcher/switcher-0.3.7a.ebuild,v 1.8 2008/06/13 19:55:44 flameeyes Exp $

inherit kde
need-kde 3.1

DESCRIPTION="A small KDE app for switching the order of letters (as in logical and visual hebrew)"
HOMEPAGE="http://www.penguin.org.il/~uvgroovy/"
SRC_URI="http://www.penguin.org.il/~uvgroovy/${P}.tar.bz2
	mirror://gentoo/kde-admindir-3.5.5.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE=""
