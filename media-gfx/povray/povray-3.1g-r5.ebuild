# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/povray/povray-3.1g-r5.ebuild,v 1.12 2003/04/25 15:41:23 vapier Exp $

S=${WORKDIR}/povray31
DESCRIPTION="The Persistance Of Vision Ray Tracer"
SRC_URI="http://www.ibiblio.org/gentoo/distfiles/povuni_s_3.1.tgz
	http://www.ibiblio.org/gentoo/distfiles/povuni_d_3.1.tgz"
HOMEPAGE="http://www.povray.org/"

SLOT="0"
LICENSE="povlegal-3.1g"
KEYWORDS="x86 ppc alpha"
IUSE="icc X svga"

DEPEND="media-libs/libpng
	sys-libs/zlib
	X? ( virtual/x11 )
	icc? ( dev-lang/icc )
	svga? ( media-libs/svgalib )"

src_compile() {
	patch -p1 < ${FILESDIR}/gentoo.patch

	# fix system default povray.ini to point to install directory
	cp povray.ini povray.ini.orig
	sed -e "s:\(/usr/\)local/\(lib\):\1\2:" povray.ini.orig > povray.ini

	cd source
	# Use the system libpng and zlib, not the version w/ the package
	rm -rf libpng/ zlib/

	# Change the header file with the banner when you start povray
	cp optout.h optout.h.orig
	sed -e "s/DISTRIBUTION_MESSAGE_2.*$/DISTRIBUTION_MESSAGE_2 \"Gentoo Linux - `uname -n` - ${USER}\"/" optout.h.orig > optout.h
	
	cd unix
	cp makefile makefile.orig

	DCPU=`echo ${CFLAGS} | sed -e "s/.*i\(.86\).*/\\1/"`
	echo "s/^CFLAGS.*-DCPU=686/CFLAGS = -DCPU=${DCPU}/" > makefile.sed

	## Stuff common to both compilers
	# Use system libpng
	echo "s:^PNGDIR.*:PNGDIR = /usr/include:" >> makefile.sed
	echo "s:^LIBPNGINC.*:LIBPNGINC =:" >> makefile.sed
	echo "s:^LIBPNGLIB.*:LIBPNGLIB = -lpng:" >> makefile.sed

	# Use system zlib
	echo "s:^ZLIBDIR.*:ZLIBDIR =:" >> makefile.sed
	echo "s:^ZLIBINC.*:ZLIBINC =:" >> makefile.sed
	echo "s:^ZLIBLIB.*:ZLIBLIB = -lz:" >> makefile.sed

	echo "s/^CFLAGS =/CFLAGS = -ansi -c/" >> makefile.sed

	if [ "`use icc`" ]; then
		# ICC CFLAGS
		echo "s/gcc/icc/" >> makefile.sed

		# Should pull from /etc/make.conf
		# If you have a P4 add -tpp7 after the -O3
		# If you want lean/mean replace -axiMKW with -x? (see icc docs for -x)
		# Note: -ipo breaks povray
		# Note: -ip breaks povray on a P3
		echo "s/^CFLAGS =/CFLAGS = -O3 -axiMKW /" >> makefile.sed
		# This is optimized for my Pentium 2:
		#echo "s/^CFLAGS =/CFLAGS = -O3 -xM -ip /" >> makefile.sed
		# This is optimized for Pentium 3 (semi-untested, I don't own one):
		#echo "s/^CFLAGS =/CFLAGS = -O3 -xK /" >> makefile.sed
		# This is optimized for Pentium 4 (untested, I don't own one):
		#echo "s/^CFLAGS =/CFLAGS = -O3 -xW -ip -tpp7 /" >> makefile.sed

		if [ "`use icc-pgo`" ]; then
			IPD=${BUILDDIR}/icc-pgo
			echo "s:^CFLAGS =:CFLAGS = -prof_dir ${IPD} :" >> makefile.sed
			if [ ! -d "${IPD}" ]; then
				mkdir -m 777 -p ${IPD}
				echo "s/^CFLAGS =/CFLAGS = -prof_gen /" >> makefile.sed
				einfo Building PGO prof_gen version.
			else 
				einfo Building PGO prof_use version. 
				echo "s/^CFLAGS =/CFLAGS = -prof_use /" >> makefile.sed
			fi
		fi
	else
		# GCC CFLAGS
		echo "s/^CFLAGS =/CFLAGS = -finline-functions -ffast-math /" >> makefile.sed
		echo "s/^CFLAGS =/CFLAGS = ${CFLAGS} /" >> makefile.sed
	fi

	sed -f makefile.sed makefile.orig > makefile

	einfo Building povray
	emake newunix || die

	if [ "`use X`" ] ; then
		einfo Building x-povray
		emake newxwin || die
	fi
	if [ "`use svga`" ] ; then
		einfo Building s-povray
		make newsvga || die
	fi
}

src_install() {
	cd source/unix
	dodir usr/bin
	dodir usr/lib
	dodir usr/share/man/man1
	make DESTDIR=${D} install || die
	cd ${S}
	rm -rf source
	cd ..
	mv povray31 ${D}/usr/lib
}
