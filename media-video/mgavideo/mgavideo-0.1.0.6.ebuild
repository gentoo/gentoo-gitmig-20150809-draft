# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later

A=${PN}-0.1.0-test6.tar.gz
S=${WORKDIR}/${PN}-0.1.0-test6/driver
SRC_URI="mirror://sourceforge/marvel/${A}"
DESCRIPTION="Matrox Marvel G200/G400/Rainbow Runner G-series V4L I and II drivers"
HOMEPAGE="http://marvel.sourceforge.net"

DEPEND="virtual/glibc
	virtual/linux-sources
        >=sys-apps/portage-1.9.10"

RDEPEND="virtual/linux-sources"

src_unpack() {
	unpack ${A}
	cd ${S}

	# This allows us to compile the i2c-algo-ks.o module even if the user doesn't have
	# the i2c-core.o module, incase they want to compile that later.  At the end of this
	# script we warn them if that is the case

	cp Makefile Makefile.orig
	sed -e '/i2c-algo-ks\.o\:/,+3c\
i2c-algo-ks.o:\
	\$(CC) \$(CFLAGS) -c i2c-algo-ks.c' Makefile.orig > Makefile
}

src_compile() {
	check_KV
	make mjpeg
}

src_install() {
	local install_dir=/lib/modules/${KV}/kernel/drivers/mgavideo

	dodir ${install_dir}
	dodoc README CHANGELOG
	cp i2c-algo-ks.o ${D}/${install_dir}
	cp tuner.o ${D}/${install_dir}
	cp ks0127.o ${D}/${install_dir}
	cp msp3400.o ${D}/${install_dir}
	cp maven.o ${D}/${install_dir}
	cp mga_core.o ${D}/${install_dir}
	cp mgavideo.o ${D}/${install_dir}
	cp mgacap.o ${D}/${install_dir}
	cp zr36060.o ${D}/${install_dir}
	cp i33.o ${D}/${install_dir}
	cp mgajpg.o ${D}/${install_dir}
	cp mgagrab.o ${D}/${install_dir}
}

pkg_postinst() {
	depmod -a
	if [ ! -f /lib/modules/${KV}/kernel/drivers/i2c/i2c-core.o ] ; then
		echo
		echo '###############################################################'
		echo '##  WARNING: i2c support must be compiled into your kernel   ##'
		echo '##  as a module for these drivers to work.                   ##'
		echo '###############################################################'
		echo
	fi
}
