# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/kpovmodeler/kpovmodeler-0.2.ebuild,v 1.5 2003/09/11 01:18:39 msterret Exp $
inherit kde-base

need-kde 3
DESCRIPTION="Graphical KDE POVRay modeler"
SRC_URI="http://www.uni-ulm.de/~s_azehen/${P}.tar.gz"
HOMEPAGE="http://www.kpovmodeler.org"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

newdepend "virtual/opengl virtual/glu virtual/glut >=media-libs/freetype-2.0.9"
RDEPEND="$RDEPEND media-gfx/povray"

warning_msg() {

ewarn "WARNING: this app is now part of kdegraphics-3.1. It is very much recommended that you"
ewarn "upgrade to kde 3.1 instead of using this standalone app, because it is no longer being"
ewarn "updated or fixed. In addition, it won't even compile on a kde 3.1 system."

}

src_unpack() {

	warning_msg
	kde_src_unpack

}

src_postinst() {
	warning_msg
}
