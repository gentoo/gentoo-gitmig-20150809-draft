# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-gfx/k3studio/k3studio-0.98.ebuild,v 1.2 2002/07/05 09:55:52 verwilst Exp $

inherit kde-base || die

need-kde 3
LICENSE="GPL-2"
newdepend "=dev-lang/python-2.2*
	   >=media-libs/glut-3.7
	   >=sys-libs/readline-4.1
	   >=media-libs/freetype-2.0.5
	   >=media-libs/qhull-3.1"

DESCRIPTION="KDE universal workbench for 2D/3D modeling, visualization and simulation."
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://k3studio.sourceforge.net"

src_compile() {
	myconf="--with-qhull-includes=/usr/include/qhull"
	myconf="$myconf --with-qhull-libraries=/usr/lib"
	myconf="$myconf --with-python-includes=/usr/include/python2.2"
	myconf="$myconf --with-python-libraries=/usr/lib/python2.2/config"

	kde_src_compile myconf
	kde_src_compile configure
	kde_src_compile make
}
