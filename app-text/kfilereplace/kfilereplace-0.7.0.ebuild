# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/kfilereplace/kfilereplace-0.7.0.ebuild,v 1.10 2003/06/12 20:27:14 msterret Exp $

inherit kde-base || die

need-kde 3.0.1

DESCRIPTION="A KDE 3.x multifile replace utility"
SRC_URI="mirror://sourceforge/kfilereplace/${P}.tar.bz2"
HOMEPAGE="http://kfilereplace.sourceforge.net"
KEYWORDS="x86 sparc  ~ppc"
SLOT="0"
LICENSE="GPL-2"

DEPEND="$DEPEND dev-lang/perl"


