# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Philippe Namias <pnamias@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-gfx/kuickshow/kuickshow-0.8-r2.ebuild,v 1.4 2002/04/28 04:50:25 seemant Exp $
. /usr/portage/eclass/inherit.eclass || die
inherit kde-base || die

need-kde 2.1.1

DESCRIPTION="Kuickshow image loader for kde2"
SRC_URI="http://prdownloads.sourceforge.net/kuickshow/${P}.tgz"
HOMEPAGE="http://kuickshow.sourceforge.net/"

DEPEND="$DEPEND sys-apps/which"
newdepend ">=media-libs/imlib-1.9.10"

src_compile() {
	CXXFLAGS="-I/usr/X11R6/include ${CXXFLAGS}"
	kde_src_compile myconf configure make
}
