# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/kile/kile-1.7.1.ebuild,v 1.1 2004/10/19 14:48:38 carlo Exp $

inherit kde

MY_P=${P/_beta/b}
S=${WORKDIR}/${MY_P}

DESCRIPTION="A Latex Editor and TeX shell for kde"
SRC_URI="mirror://sourceforge/kile/${MY_P}.tar.bz2"
HOMEPAGE="http://kile.sourceforge.net"

IUSE="kde"
SLOT=0

KEYWORDS="~x86 ~amd64 ~sparc ~ppc"
LICENSE="GPL-2"

DEPEND="dev-lang/perl"
RDEPEND="virtual/tetex
	kde? ( kde-base/kdegraphics )"
need-kde 3.2
