# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/qhull/qhull-3.1-r1.ebuild,v 1.7 2004/06/06 16:55:29 kugelfang Exp $

MY_P="${PN}${PV}"
DESCRIPTION="Geometry library"
HOMEPAGE="http://www.qhull.org"
SRC_URI="http://www.geom.umn.edu/software/qhull/${MY_P}.tgz"

SLOT="0"
LICENSE="BSD"
KEYWORDS="x86 sparc ~ppc amd64"
IUSE=""

RDEPEND="virtual/glibc"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd ${S}/src
	mv Makefile.txt Makefile
	# This echo statement appends a new build target to the exisiting Makefile
	# for an additional shared library; originally added to support octave-forge
	echo 'libqhull.so: $(OBJS)
	c++ -shared -Xlinker -soname -Xlinker $@ -o libqhull.so $(OBJS)' >> Makefile

	# the newly compiled programs will be run during the build.  seems
	# easiest to statically link.
	sed -i \
		-e 's/-lqhull/libqhull.a/' \
		-e '/^all:/ s/$/ libqhull.so/' Makefile \
			|| die "sed Makefile failed"
}

src_compile() {
	cd src
	emake CCOPTS1="${CFLAGS}" || die "emake failed"
}

src_install() {
	cd src

	dolib libqhull.a || die "dolib failed"
	dolib.so libqhull.so || die "dolib.so failed"
	dobin qconvex qdelaunay qhalf qhull qvoronoi rbox || die "dobin failed"

	insinto /usr/include/qhull
	doins *.h

	cd ${S}
	dodoc Announce.txt COPYING.txt File_id.diz README.txt REGISTER.txt
	cd html
	dohtml *
	dodoc *.txt
	for m in *man
	do
		newman ${m} ${m/.man/.1}
	done
}
