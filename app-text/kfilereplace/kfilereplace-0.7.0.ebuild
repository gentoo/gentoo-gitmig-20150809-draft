# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# /space/gentoo/cvsroot/gentoo-x86/app-text/kfilereplace/kfilereplace-0.6.1.ebuild,v 1.3 2002/05/21 18:14:07 danarmak Exp

inherit kde-base || die

need-kde 3.0.1

DESCRIPTION="A KDE 3.x multifile replace utility"
SRC_URI="mirror://sourceforge/kfilereplace/${P}.tar.bz2"
HOMEPAGE="http://kfilereplace.sourceforge.net"
LICENSE="GPL-2"

DEPEND="$DEPEND sys-devel/perl"


