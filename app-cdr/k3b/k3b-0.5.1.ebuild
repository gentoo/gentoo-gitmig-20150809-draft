# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-cdr/k3b/k3b-0.5.1.ebuild,v 1.10 2002/08/16 02:31:09 murphy Exp $

inherit kde-base || die

need-kde 2.2

DESCRIPTION="K3b, KDE CD Writing Software"
SRC_URI="mirror://sourceforge/k3b/${P}.tar.gz"
HOMEPAGE="http://k3b.sourceforge.net"
LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64"

newdepend ">=media-sound/mpg123-0.59
	>=media-sound/cdparanoia-3.9.8
	>=app-cdr/cdrtools-1.11
	>=app-cdr/cdrdao-1.1.5
	>=media-libs/id3lib-3.8.0_pre2"
