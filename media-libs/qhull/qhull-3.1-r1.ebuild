# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/qhull/qhull-3.1-r1.ebuild,v 1.2 2003/07/12 18:06:04 aliz Exp $

IUSE=""

S=${WORKDIR}/qhull3.1
DESCRIPTION="Geometry library"
SRC_URI="http://www.geom.umn.edu/software/qhull/qhull3.1.tgz"
HOMEPAGE="http://www.geom.umn.edu/software/qhull/"

SLOT="0"
LICENSE="BSD"
KEYWORDS="x86 ~sparc "

DEPEND=""

src_compile() {
	cd src
	# This echo statement appends a new build target to the exisiting Makefile
	# for an additional shared library; originally added to support octave-forge
	echo 'libqhull.so: $(OBJS)
	c++ -shared -Xlinker -soname -Xlinker $@ -o libqhull.so $(OBJS)' >> Makefile.txt
	# This line now specifies the build targets, including the target added on
	# the previous line
	make -f Makefile.txt all libqhull.so

}

src_install () {

	cd src

	dolib libqhull.a
	# This line installs the extra shared lib compiled with the target added
	# above
	dolib.so libqhull.so
	dobin qconvex
	dobin qdelaunay
	dobin qhalf
	dobin qhull
	dobin qvoronoi
	dobin rbox

	dodir /usr/include/qhull
	insinto /usr/include/qhull
	doins *.h

	cd ${S}
	dodoc Announce.txt COPYING.txt File_id.diz README.txt REGISTER.txt

	cd html

	rename .htm .html *.htm
	rename .man .1 *.man

	dohtml -a html,gif *

	doman *.1

	dodoc *.txt
}
