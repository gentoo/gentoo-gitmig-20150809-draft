# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/chipmunksystem/chipmunksystem-20031105-r2.ebuild,v 1.1 2004/10/31 19:43:21 ribosome Exp $

inherit toolchain-funcs

DESCRIPTION="Chipmunk System - circuit schematic and simulation environment"

HOMEPAGE="http://www.cs.berkeley.edu/~lazzaro/chipmunk/"

#This is a complete install of Chipmunk Tools, even with examples, but doesn't have
#XCircuit (that can be installed with emerge xcircuit) and xnf-tools (see the HOMEPAGE
#for details)
SRC_URI="http://www.cs.berkeley.edu/~lazzaro/chipmunk/pickup/sources/webdoc-1.47.tar.gz
	http://www.cs.berkeley.edu/~lazzaro/chipmunk/pickup/sources/psys-1.58.tar.gz
	http://www.cs.berkeley.edu/~lazzaro/chipmunk/pickup/sources/log-5.62.tar.gz
	http://www.cs.berkeley.edu/~lazzaro/chipmunk/pickup/sources/view-1.14.tar.gz
	http://www.cs.berkeley.edu/~lazzaro/chipmunk/pickup/sources/until-1.14.tar.gz
	http://www.cs.berkeley.edu/~lazzaro/chipmunk/pickup/sources/wol-1.14.tar.gz
	http://www.cs.berkeley.edu/~lazzaro/chipmunk/pickup/sources/wolcomp-1.14.tar.gz
	http://www.cs.berkeley.edu/~lazzaro/chipmunk/pickup/sources/netcmp-1.13.tar.gz
	http://www.cs.berkeley.edu/~lazzaro/chipmunk/pickup/sources/mosis-1.14.tar.gz
	http://www.cs.berkeley.edu/~lazzaro/chipmunk/pickup/sources/util-1.11.tar.gz"
#For while I have to take out this source:
#http://www.cs.berkeley.edu/~lazzaro/chipmunk/pickup/sources/examples.tar.gz
#It's a file with examples for chipmunk, it conflicts with other examples.tar.gz
#file found in Gentoo Mirrors

LICENSE="GPL-1"
SLOT="0"

#ARCH: I only tested on x86, it's the only platform I have access, but it's
#      supposed to work on other platforms, see HOMEPAGE
KEYWORDS="~x86 ~ppc"

IUSE=""

DEPEND="virtual/libc
	virtual/x11"

src_compile() {

	local COMPILING_ERROR
	COMPILING_ERROR="Compiling of ${P} FAILED"
	cd ${WORKDIR}
	sed -e "s:^CHIPMUNKCC.*:CHIPMUNKCC = $(tc-getCC) ${CFLAGS}:" \
		-e 's:^CHIPMUNKFLAGS.*:CHIPMUNKFLAGS = -DBSD -Dlinux -DF_OK=0:' \
		-e 's:^LIB .*:LIB = \$\(LIBDIR\)/libp2c.a:' \
		-i psys/src/Makefile || die "sed failed in psys/src"
	sed -e "s:^CHIPMUNKCC.*:CHIPMUNKCC = $(tc-getCC) ${CFLAGS}:" \
		-e 's:^CHIPMUNKFLAGS.*:CHIPMUNKFLAGS = -DBSD -Dlinux -DF_OK=0:' \
		-i log/src/ana/Makefile || die "sed failed in log/src/ana"
	sed -e "s:^CHIPMUNKCC.*:CHIPMUNKCC = $(tc-getCC) ${CFLAGS}:" \
		-e 's:^CHIPMUNKFLAGS.*:CHIPMUNKFLAGS = -DBSD -Dlinux:' \
		-e 's:^LIBX11.*:LIBX11 = -lX11 -L/usr/X11R6/lib:' \
		-e "s:^LOGLIBDIR.*:LOGLIBDIR = /usr/share/${P}/lib:" \
		-e 's:^LIBDIR.*:LIBDIR = ../lib:' \
		-e 's:^LIBP2C.*:LIBP2C = ../../lib/libp2c.a:' \
		-i log/src/Makefile || die "sed failed in log/src"
	sed -e "s:^CHIPMUNKCC.*:CHIPMUNKCC = $(tc-getCC) ${CFLAGS}:" \
		-e 's:^CHIPMUNKFLAGS.*:CHIPMUNKFLAGS = -DBSD -Dlinux:' \
		-e 's:^LIBX11.*:LIBX11 = -lX11 -L/usr/X11R6/lib:' \
		-e 's:^LIBP2C.*:LIBP2C = ../lib/libp2c.a:' \
		-i view/Makefile || die "sed failed in view"
	sed -e "s:^CHIPMUNKCC.*:CHIPMUNKCC = $(tc-getCC) ${CFLAGS}:" \
		-e 's:^CHIPMUNKFLAGS.*:CHIPMUNKFLAGS = -DBSD -Dlinux:' \
		-e 's:^LIBX11.*:LIBX11 = -lX11 -L/usr/X11R6/lib:' \
		-e 's:^LIBP2C.*:LIBP2C = ../../lib/libp2c.a:' \
		-i until/V1.2/Makefile || die "sed failed in until/V1.2"
	sed -e "s:^CHIPMUNKCC.*:CHIPMUNKCC = $(tc-getCC) ${CFLAGS}:" \
		-e 's:^CHIPMUNKFLAGS.*:CHIPMUNKFLAGS = -DBSD -Dlinux -DF_OK=0:' \
		-e 's:^LIBX11.*:LIBX11 = -lX11 -L/usr/X11R6/lib:' \
		-e 's:^LIBP2C.*:LIBP2C = ../lib/libp2c.a:' \
		-i wol/Makefile || die "sed failed in wol"
	sed -e "s:^CHIPMUNKCC.*:CHIPMUNKCC = $(tc-getCC) ${CFLAGS}:" \
		-e 's:^CHIPMUNKFLAGS.*:CHIPMUNKFLAGS = -DBSD -Dlinux -DF_OK=0:' \
		-i wolcomp/Makefile || die "sed failed in wolcomp"
	sed -e "s:^CHIPMUNKCC.*:CHIPMUNKCC = $(tc-getCC) ${CFLAGS}:" \
		-e 's:^CHIPMUNKFLAGS.*:CHIPMUNKFLAGS = -DBSD -Dlinux -DF_OK=0:' \
		-i netcmp/Makefile || die "sed failed in netcmp"
	sed -e "s:^CHIPMUNKCC.*:CHIPMUNKCC = $(tc-getCC) ${CFLAGS}:" \
		-e 's:^CHIPMUNKFLAGS.*:CHIPMUNKFLAGS = -DBSD -Dlinux -DF_OK=0:' \
		-e 's:^LIBX11.*:LIBX11 = -lX11 -L/usr/X11R6/lib:' \
		-i mosis/Makefile || die "sed failed in mosis"
	sed -e "s:^CHIPMUNKCC.*:CHIPMUNKCC = $(tc-getCC) ${CFLAGS}:" \
		-e 's:^CFLAGS.*:CFLAGS = -DBSD -Dlinux -DF_OK=0:' \
		-i util/boxify/Makefile || die "sed failed in util/boxify"
	sed -e "s:^CHIPMUNKCC.*:CHIPMUNKCC = $(tc-getCC) ${CFLAGS}:" \
		-e 's:^CFLAGS.*:CFLAGS = -DBSD -Dlinux -DF_OK=0:' \
		-i util/boxify/trapes/Makefile || die "sed failed in util/boxify/trapes"
	sed -e "s:^CHIPMUNKCC.*:CHIPMUNKCC = $(tc-getCC) ${CFLAGS}:" \
		-e 's:^CFLAGS.*:CFLAGS = -DBSD -Dlinux -DF_OK=0:' \
		-i util/cleancif/Makefile || die "sed failed in util/cleancif"
	sed -e "s:^CHIPMUNKCC.*:CHIPMUNKCC = $(tc-getCC) ${CFLAGS}:" \
		-e 's:^CFLAGS.*:CFLAGS = -DBSD -Dlinux -DF_OK=0:' \
		-i util/sctomat/Makefile || die "sed failed in util/sctomat"
	sed -e "s:^CHIPMUNKCC.*:CHIPMUNKCC = $(tc-getCC) ${CFLAGS}:" \
		-e 's:^CFLAGS.*:CFLAGS = -DBSD -Dlinux -DF_OK=0:' \
		-i util/spc-tools/sf/Makefile || die "sed failed in util/spc-tools/sf"
	sed -e "s:^CHIPMUNKCC.*:CHIPMUNKCC = $(tc-getCC) ${CFLAGS}:" \
		-e 's:^CFLAGS.*:CFLAGS = -DBSD -Dlinux -DF_OK=0:' \
		-i util/spc-tools/ss/Makefile || die "sed failed in util/spc-tools/ss"

	for dir in psys/src log/src view until/V1.2 wol wolcomp netcmp mosis \
		util util/spc-tools; do
		pushd ${dir}
		make install || die $COMPILING_ERROR
		popd
	done
}

src_install () {

	cd ${WORKDIR}

	dobin bin/*
	dolib lib/*
	dolib wolcomp/wolcomp.a

	dodir /usr/share/${P}/lib
	cp -a log/lib/* ${D}/usr/share/${P}/lib
	cp -a view/lib/* ${D}/usr/share/${P}/lib
	dodir /usr/share/${P}/until/designrules
	cp -a until/designrules/* ${D}/usr/share/${P}/until/designrules
	cp until/V1.2/*.ff ${D}/usr/share/${P}/until
	dodir /usr/share/${P}/netcmp
	cp netcmp/*.ntk ${D}/usr/share/${P}/netcmp
	dodir /usr/share/doc/${P}/html
	cp -a webdoc/* ${D}/usr/share/doc/${P}/html

	#**** Example file taken out,
	#     uncomment the line below if this is resolved
	#     (refer to SRC_URI)
	#cp -a example ${D}/usr/share/${P}

	dodoc log/src/LNOTES util/sctomat/doc/scope_to_mat.ps
	newdoc log/src/COPYING COPYING.log
	newdoc log/README README.log
	newdoc mosis/COPYING COPYING.mosis
	newdoc mosis/README README.mosis
	newdoc netcmp/COPYING COPYING.netcmp
	newdoc netcmp/README README.netcmp
	newdoc psys/src/COPYING COPYING.psys
	newdoc psys/src/README README.psys
	newdoc until/V1.2/COPYING COPYING.until
	newdoc until/README README.until
	newdoc util/boxify/COPYING COPYING.boxify
	newdoc util/cleancif/COPYING COPYING.cleancif
	newdoc util/cleancif/README README.cleancif
	newdoc util/conscripts/COPYING COPYING.conscripts
	newdoc util/conscripts/README README.conscripts
	newdoc util/sctomat/README README.sctomat
	newdoc util/spc-tools/COPYING COPYING.spc-tools
	newdoc util/spc-tools/README README.spc-tools
	newdoc util/README README.util
	newdoc view/COPYING COPYING.view
	newdoc view/README README.view
	newdoc wol/COPYING COPYING.wol
	newdoc wol/README README.wol
	newdoc wolcomp/COPYING COPYING.wolcomp
	newdoc wolcomp/README README.wolcomp
	doman util/boxify/boxify.1

}
