# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/krename/krename-3.0.2.ebuild,v 1.1 2004/10/30 17:42:15 carlo Exp $

inherit kde

#needed for rc versions
MY_P=${P/_/}
S=${WORKDIR}/${MY_P}

DESCRIPTION="KRename - a very powerful batch file renamer"
HOMEPAGE="http://www.krename.net/"
SRC_URI="mirror://sourceforge/krename/${MY_P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 amd64 ppc"
IUSE=""

need-kde 3.1