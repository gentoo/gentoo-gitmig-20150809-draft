# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/kimagemapeditor/kimagemapeditor-0.9.5.1.ebuild,v 1.12 2004/08/03 13:22:55 vapier Exp $

inherit kde gcc
need-kde 3

DESCRIPTION="An imagemap editor for KDE"
HOMEPAGE="http://kimagemapeditor.sourceforge.net/"
SRC_URI="mirror://sourceforge/kimagemapeditor/${P}-kde3.tar.gz"

LICENSE="GPL-2"
KEYWORDS="x86 ~ppc"
IUSE=""

src_unpack() {
	[ "`gcc-major-version`" == "3" ] && PATCHES="$FILESDIR/$P-gcc3.diff"
	kde_src_unpack
}
