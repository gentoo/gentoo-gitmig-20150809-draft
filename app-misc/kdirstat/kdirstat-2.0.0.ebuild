# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Maciek Borowka <mborowka@ifaedi.insa-lyon.fr>
# /space/gentoo/cvsroot/gentoo-x86/skel.build,v 1.11 2001/12/06 22:12:34 drobbins Exp
. /usr/portage/eclass/inherit.eclass || die
inherit kde-base

DESCRIPTION="KDirStat - nice KDE replacement to du command"
SRC_URI="http://kdirstat.sourceforge.net/download/${P}.tgz"
HOMEPAGE="http://kdirstat.sourceforge.net/"
S=${WORKDIR}/${P}

need-kde 2.2

