# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/kimagemapeditor/kimagemapeditor-0.9.5.1.ebuild,v 1.15 2005/01/14 23:13:17 danarmak Exp $

inherit kde gcc

DESCRIPTION="An imagemap editor for KDE"
HOMEPAGE="http://kimagemapeditor.sourceforge.net/"
SRC_URI="mirror://sourceforge/kimagemapeditor/${P}-kde3.tar.gz"

LICENSE="GPL-2"
KEYWORDS="x86 ~ppc"
IUSE=""

DEPEND="!kde-base/kdewebdev !kde-base/kimagemapeditor"
need-kde 3

src_unpack() {
	[ "`gcc-major-version`" == "3" ] && PATCHES="$FILESDIR/$P-gcc3.diff"
	kde_src_unpack
}
