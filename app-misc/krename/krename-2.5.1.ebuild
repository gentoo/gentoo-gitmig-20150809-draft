# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/krename/krename-2.5.1.ebuild,v 1.1 2003/02/03 00:03:36 hannes Exp $

IUSE=""

inherit kde-base

DESCRIPTION="KRename - a very powerful batch file renamer"
SRC_URI="http://ftp.kde.com/Utilities/File_System/krename/${P}.tar.bz2"
HOMEPAGE="http://krename.sourceforge.net/"


LICENSE="GPL-2"
KEYWORDS="~x86"

need-kde 3
