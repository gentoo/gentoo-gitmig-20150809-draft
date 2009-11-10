# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/switcher/switcher-0.3.7a.ebuild,v 1.10 2009/11/10 22:41:36 ssuominen Exp $

ARTS_REQUIRED=never
inherit kde

DESCRIPTION="A small KDE app for switching the order of letters (as in logical and visual hebrew)"
HOMEPAGE="http://www.penguin.org.il/~uvgroovy/"
SRC_URI="http://www.penguin.org.il/~uvgroovy/${P}.tar.bz2
	mirror://gentoo/kde-admindir-3.5.5.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

need-kde 3.5
