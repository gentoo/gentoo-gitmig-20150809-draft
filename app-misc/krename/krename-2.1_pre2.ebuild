# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Michael v.Ostheim <MvOstheim@web.de>
# /space/gentoo/cvsroot/gentoo-x86/skel.build,v 1.11 2001/12/06 22:12:34 drobbins Exp
. /usr/portage/eclass/inherit.eclass || die
inherit kde-base

MY_P=${PN}-${PV//_/-}
S=${WORKDIR}/${MY_P}
DESCRIPTION="KRename - a very powerful batch file renamer"
SRC_URI="http://ftp.kde.com/Utilities/File_System/krename/${MY_P}.tar.bz2"
HOMEPAGE="http://krename.sourceforge.net/"

need-kde 3
