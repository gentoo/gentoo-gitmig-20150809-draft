# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-gfx/kuickshow/kuickshow-0.8-r2.ebuild,v 1.9 2002/07/23 05:18:07 seemant Exp $

inherit kde-base || die

need-kde 2.1.1

DESCRIPTION="Kuickshow image loader for kde2"
SRC_URI="mirror://sourceforge/kuickshow/${P}.tgz"
HOMEPAGE="http://kuickshow.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="${DEPEND} sys-apps/which"
newdepend ">=media-libs/imlib-1.9.10"

src_compile() {
	CXXFLAGS="-I/usr/X11R6/include ${CXXFLAGS}"
	kde_src_compile myconf configure make
}
