# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/fresco-base/fresco-cvs/fresco-cvs-20021020.ebuild,v 1.4 2003/02/28 16:54:59 liquidx Exp $

ECVS_SERVER="cvs.fresco.org:/cvs/fresco"
ECVS_MODULE="Fresco"
#ECVS_BRANCH=${PN/cvs/}${PV/./-}
ECVS_TOP_DIR="${DISTDIR}/cvs-src/${ECVS_BRANCH}"

inherit cvs
inherit gcc

MY_PN="${PN/fresco-cvs/Fresco}"
S="${WORKDIR}/${MY_PN}"
DESCRIPTION="fresco -- A free X11 replacement which is under heavy development. CVS ebuild."
HOMEPAGE="http://www2.fresco.org"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
PATCH="gcc-3.2.patch"
	
DEPEND="net-misc/omniORB
	media-libs/libggi
	media-libs/libsdl
	dev-libs/DirectFB
	virtual/opengl
	media-libs/libart_lgpl
	>=media-libs/freetype-2.0.0
	sys-libs/zlib
	media-libs/libpng
	fresco-base/fresco-env"


src_compile() {
	cd ${S}
	
	# Apply the patch on gcc3.2 boxes
	if([ "`gcc-version`" == "3.2" ]) then
		einfo "GCC 3.2 found. Applying patch"
		cp ${FILESDIR}/${PATCH}.bz2 ${S}
		bunzip2 ${S}/${PATCH}.bz2
		patch -p0 < ${PATCH}
	fi

	./autogen.sh || die "autogen.sh failed"
	./configure || die "configure failed" 
	make configure_args="--prefix=/opt/fresco --enable-tracer" || die "make failed"
}

src_install () {
	make DESTDIR=${D} install || die
	exeinto /opt/fresco
	doexe ${FILESDIR}/rundemo.sh
	dodoc INSTALL README
}

pkg_postinst () {
	einfo "Use /opt/fresco/rundemo.sh to run the demo."
}
