# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Bart Verwilst <verwilst@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-gfx/k3studio/k3studio-0.97.ebuild,v 1.4 2002/05/27 17:27:38 drobbins Exp $

inherit kde-base || die

need-kde 2.1

newdepend "=dev-lang/python-2.0*
	   >=media-libs/glut-3.7
	   >=sys-libs/readline-4.1
	   >=media-libs/freetype-2.0.5
	   >=media-libs/qhull-3.1
	  "
#	>=media-libs/gle
#	>=media-libs/nurbs++
#	>=media-libs/libvrml97
#	>=media-libs/gltt

DESCRIPTION="KDE universal workbench for 2D/3D modeling, visualization and simulation."
SRC_URI="mirror://sourceforge/k3studio/k3studio-0.97.tar.gz"
HOMEPAGE="http://k3studio.sourceforge.net"

src_compile() {
	myconf="--with-qhull-includes=/usr/include/qhull"
	myconf="$myconf --with-qhull-libraries=/usr/lib"
	myconf="$myconf	--with-python-includes=/usr/include/python2.0"
	myconf="$myconf --with-python-libraries=\\\"-L. -L/usr/lib/python2.0/config `python-config`\\\""

	echo $myconf
	kde_src_compile myconf
	kde_src_compile configure
	kde_src_compile make
}
