# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/kpovmodeler/kpovmodeler-0.2.ebuild,v 1.2 2002/10/05 19:22:30 cybersystem Exp $
inherit kde-base

need-kde 3
DESCRIPTION="Graphical KDE POVRay modeler"
SRC_URI="http://www.uni-ulm.de/~s_azehen/${P}.tar.gz"
HOMEPAGE="http://www.kpovmodeler.org"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

newdepend "virtual/opengl virtual/glu virtual/glut >=media-libs/freetype-2.0.9"
RDEPEND="$RDEPEND media-gfx/povray"
