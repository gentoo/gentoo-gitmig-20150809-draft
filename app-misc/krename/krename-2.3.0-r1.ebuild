# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/krename/krename-2.3.0-r1.ebuild,v 1.8 2002/10/30 18:55:08 hannes Exp $

IUSE=""

inherit kde-base

DESCRIPTION="KRename - a very powerful batch file renamer"
SRC_URI="http://ftp.kde.com/Utilities/File_System/krename/${P}.tar.bz2"
HOMEPAGE="http://krename.sourceforge.net/"


LICENSE="GPL-2"
KEYWORDS="x86"

need-kde 3

src_unpack() {
	unpack ${A}
	cd ${S}
	patch -p1 < ${FILESDIR}/${P}-gentoo.patch || die "Patching failed"
}
