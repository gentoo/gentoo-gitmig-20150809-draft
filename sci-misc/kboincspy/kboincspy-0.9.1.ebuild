# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-misc/kboincspy/kboincspy-0.9.1.ebuild,v 1.2 2009/11/11 11:48:36 ssuominen Exp $

ARTS_REQUIRED=never
inherit kde

DESCRIPTION="KDE monitoring utility for the BOINC distributed client"
HOMEPAGE="http://kboincspy.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

need-kde 3.5
