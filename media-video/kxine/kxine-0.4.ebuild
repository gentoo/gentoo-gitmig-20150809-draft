# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-video/kxine/kxine-0.4.ebuild,v 1.2 2002/08/13 20:17:50 gerk Exp $
inherit kde-base
need-kde 3

DESCRIPTION="A simple KDE interface to the xine library"
SRC_URI="mirror://sourceforge/kxine/${P}.tar.gz"
HOMEPAGE="http://kxine.sourceforge.net/"
newdepend ">=media-libs/xine-lib-0.9.9"
KEYWORDS="x86 ppc"
LICENSE="GPL-2"

PATCHES="$FILESDIR/$P-gentoo.diff"

