# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# /space/gentoo/cvsroot/gentoo-x86/skel.build,v 1.11 2001/12/06 22:12:34 drobbins Exp

inherit kde-base

DESCRIPTION="KRename - a very powerful batch file renamer"
SRC_URI="http://ftp.kde.com/Utilities/File_System/krename/${P}.tar.bz2"
HOMEPAGE="http://krename.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

need-kde 3

src_unpack() {
	unpack ${A}
	cd ${S}
	patch -p1 < ${FILESDIR}/${P}-gentoo.patch || die "Patching failed"
}
