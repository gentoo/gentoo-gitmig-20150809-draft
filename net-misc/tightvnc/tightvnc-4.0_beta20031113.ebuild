# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/tightvnc/tightvnc-4.0_beta20031113.ebuild,v 1.2 2004/01/15 15:27:35 aliz Exp $

inherit eutils
IUSE="java tcpd"

# Setup XFree version and sources
XFREE_PV="4.3.0"
MY_SV="${XFREE_PV//\.}"
SRC_PATH="mirror://xfree/${BASE_PV}/source"

# realvnc beta number
REALVNC_PV="4.0b4"

# tightvnc cvs patch
TIGHTVNC_CVS="20031113"

S="${WORKDIR}/vnc-${REALVNC_PV}-unixsrc"
DESCRIPTION="A great client/server software package allowing remote network access to graphical desktops."
SRC_URI="http://www.realvnc.com/dist/vnc-${REALVNC_PV}-unixsrc.tar.gz
	${SRC_PATH}/X${MY_SV}src-1.tgz
	${SRC_PATH}/X${MY_SV}src-2.tgz
	${SRC_PATH}/X${MY_SV}src-3.tgz
	${SRC_PATH}/X${MY_SV}src-4.tgz
	${SRC_PATH}/X${MY_SV}src-5.tgz"

HOMEPAGE="http://www.tightvnc.com/"

KEYWORDS="-* ~amd64"
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
	unpack vnc-${REALVNC_PV}-unixsrc.tar.gz

	cd ${S}
	epatch ${FILESDIR}/tightvnc_cvs${TIGHTVNC_CVS}.patch.bz2

	cd ${S}/xc
	epatch ../xc.patch
	epatch ${FILESDIR}/4.0/0121_all_4.2.99.3-build-libs-with-pic.patch
	epatch ${FILESDIR}/4.0/0160_all_4.2.99.4-IncludeSharedObjectInNormalLib.patch
	epatch ${FILESDIR}/4.0/0180_amd64_4.2.99.4-glx-nopic.patch


	echo "#define InstallManPages NO" >>config/cf/vnc.def
	echo "#define OptimizedCDebugFlags ${CFLAGS} -fPIC" >> config/cf/vnc.def
	echo "#define OptimizedCplusplusDebugFlags ${CXXFLAGS} -fPIC" >> config/cf/vnc.def
	echo "#define ExtraLibraries -ljpeg" >> config/cf/vnc.def
	echo "#define IncludeSharedObjectInNormalLib" >>config/cf/vnc.def

	cd ${S}/rfb
	sed -i 's:#include "jpeg/jpeglib.h":#include "jpeglib.h":g' TightEncoder.h
	sed -i 's:#include <rfb/TightEncoder.h>:#include <rfb/TightEncoder.h>\nextern "C" {\n#include <jpeglib.h>\n}:g' TightEncoder.cxx
}
src_compile() {
	autoconf
	libtoolize -c -f

	econf --with-installed-zlib --with-installed-jpeg || die

	make CXXFLAGS="${CXXFLAGS} -fPIC" CFLAGS="${CFLAGS} -fPIC" || die

	cd ${S}/xc
	make World || die
}

src_install() {
	mkdir -p  ${D}/usr/bin ${D}/usr/share/man ${D}/usr/X11R6/lib/modules/extensions
	./vncinstall ${D}/usr/bin ${D}/usr/share/man ${D}/usr/X11R6/lib/modules/extensions
}
