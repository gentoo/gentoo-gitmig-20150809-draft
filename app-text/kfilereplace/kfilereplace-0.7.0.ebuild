# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/kfilereplace/kfilereplace-0.7.0.ebuild,v 1.17 2005/01/01 16:24:07 eradicator Exp $

inherit kde

DESCRIPTION="A KDE 3.x multifile replace utility"
HOMEPAGE="http://kfilereplace.sourceforge.net"
SRC_URI="mirror://sourceforge/kfilereplace/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc ~ppc"
IUSE=""

DEPEND="dev-lang/perl"
need-kde 3