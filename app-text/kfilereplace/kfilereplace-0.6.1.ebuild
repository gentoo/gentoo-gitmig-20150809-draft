# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/kfilereplace/kfilereplace-0.6.1.ebuild,v 1.9 2002/10/19 16:16:04 aliz Exp $

inherit kde-base || die

need-kde 2.1.1

DESCRIPTION="A multifile replace utility"
SRC_URI="mirror://sourceforge/kfilereplace/${P}.tar.bz2"
HOMEPAGE="http://kfilereplace.sourceforge.net"
KEYWORDS="x86 sparc sparc64"
SLOT="0"
LICENSE="GPL-2"

DEPEND="$DEPEND sys-devel/perl"


