# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-misc/kboincspy/kboincspy-0.9.1.ebuild,v 1.1 2006/04/09 23:31:34 cryos Exp $

inherit kde

DESCRIPTION="KDE monitoring utility for the BOINC distributed client"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
HOMEPAGE="http://kboincspy.sourceforge.net/"

IUSE=""
SLOT="0"
LICENSE="GPL-2"

KEYWORDS="~amd64 ~x86"

need-kde 3.4
