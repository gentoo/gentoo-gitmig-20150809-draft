# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/tightvnc/tightvnc-4.0_beta20031031.ebuild,v 1.2 2003/11/03 21:25:53 mr_bones_ Exp $

inherit eutils
IUSE="java tcpd"

BASE_PV="4.3.0"
MY_SV="${BASE_PV//\.}"
SRC_PATH="mirror://xfree/${BASE_PV}/source"
S="${WORKDIR}/vnc-4.0b4-unixsrc"
DESCRIPTION="A great client/server software package allowing remote network access to graphical desktops."
SRC_URI="http://www.realvnc.com/dist/vnc-4.0b4-unixsrc.tar.gz
	${SRC_PATH}/X${MY_SV}src-1.tgz
	${SRC_PATH}/X${MY_SV}src-2.tgz
	${SRC_PATH}/X${MY_SV}src-3.tgz
	${SRC_PATH}/X${MY_SV}src-4.tgz
	${SRC_PATH}/X${MY_SV}src-5.tgz"

HOMEPAGE="http://www.tightvnc.com/"

KEYWORDS="~amd64"
LICENSE="GPL-2"
SLOT="0"

DEPEND=">=x11-base/xfree-4.2.1
	~media-libs/jpeg-6b
	sys-libs/zlib
	tcpd? ( >=sys-apps/tcp-wrappers-7.6-r2 )
	!net-misc/vnc"

RDEPEND="${DEPEND}
	dev-lang/perl
	java? ( || ( >=virtual/jdk-1.3.1 >=virtual/jre-1.3.1 ) )"

src_unpack() {
	mkdir -p ${S}
	cd ${S}
	unpack X${MY_SV}src-{1,2,3,4,5}.tgz

	cd ${WORKDIR}
		unpack vnc-4.0b4-unixsrc.tar.gz

	cd ${S}
	tar -jxf ${FILESDIR}/tight.tar.bz2
	epatch ${FILESDIR}/tightvnc.patch.bz2

	cd ${S}/xc
	epatch ../xc.patch
	epatch ${FILESDIR}/0121_all_4.2.99.3-build-libs-with-pic.patch
	epatch ${FILESDIR}/0160_all_4.2.99.4-IncludeSharedObjectInNormalLib.patch
	epatch ${FILESDIR}/0180_amd64_4.2.99.4-glx-nopic.patch


	echo "#define InstallManPages NO" >>config/cf/vnc.def
	echo "#define OptimizedCDebugFlags ${CFLAGS} -fPIC" >> config/cf/vnc.def
	echo "#define OptimizedCplusplusDebugFlags ${CXXFLAGS} -fPIC" >> config/cf/vnc.def
	echo "#define ExtraLibraries -ljpeg" >> config/cf/vnc.def

#	echo "#define PositionIndependentCFlags -fpic" >>config/cf/vnc.def
#	echo "#define PositionIndependentCplusplusFlags -fpic" >>config/cf/vnc.def
	echo "#define IncludeSharedObjectInNormalLib" >>config/cf/vnc.def

	cd ${S}/rfb
#	sed -i 's:#include <stdio.h>:#include <stdio.h>\n#include "jpeglib.h":g' TightEncoder.h
	sed -i 's:#include "jpeg/jpeglib.h":#include "jpeglib.h":g' TightEncoder.h

	sed -i 's:#include <rfb/TightEncoder.h>:#include <rfb/TightEncoder.h>\nextern "C" {\n#include <jpeglib.h>\n}:g' TightEncoder.cxx
}
src_compile() {
#	econf --with-installed-zlib
	econf --with-installed-zlib --with-installed-jpeg
#	make CXXFLAGS="${CXXFLAGS} -DNEED_SHORT_EXTERNAL_NAMES -fPIC" CFLAGS="${CFLAGS} -fPIC -DNEED_SHORT_EXTERNAL_NAMES" || die
	make CXXFLAGS="${CXXFLAGS} -fPIC" CFLAGS="${CFLAGS} -fPIC" || die

	cd ${S}/xc
	make World || die
}

src_install() {
	mkdir -p  ${D}/usr/bin ${D}/usr/share/man ${D}/usr/X11R6/lib/modules/extensions
	./vncinstall ${D}/usr/bin ${D}/usr/share/man ${D}/usr/X11R6/lib/modules/extensions
}
