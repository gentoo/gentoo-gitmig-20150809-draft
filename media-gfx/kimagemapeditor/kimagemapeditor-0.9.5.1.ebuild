# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/kimagemapeditor/kimagemapeditor-0.9.5.1.ebuild,v 1.11 2004/07/14 17:47:15 agriffis Exp $

inherit kde

DESCRIPTION="An imagemap editor for KDE"
SRC_URI="mirror://sourceforge/kimagemapeditor/${P}-kde3.tar.gz"
HOMEPAGE="http://kimagemapeditor.sourceforge.net/"

need-kde 3

LICENSE="GPL-2"
KEYWORDS="x86 ~ppc"
IUSE=""

if [ "$COMPILER" == "gcc3" ]
then
	PATCHES="$FILESDIR/$P-gcc3.diff"
fi
#changed from an && construct which causes this script to return a
#non-zero error code. (drobbins, 02 Dec 2002)
