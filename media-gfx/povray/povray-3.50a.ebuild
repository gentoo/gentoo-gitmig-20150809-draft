# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-gfx/povray/povray-3.50a.ebuild,v 1.6 2002/08/26 19:32:19 rphillips Exp $

S=${WORKDIR}/${P}
DESCRIPTION="POV Ray- The Persistance of Vision Ray Tracer"
SRC_URI="ftp://ftp.povray.org/pub/povray/Official/Unix/povuni_s.tgz"
HOMEPAGE="http://www.povray.org/"

SLOT="0"
LICENSE="povlegal-3.50a"
KEYWORDS="x86"


DEPEND="media-libs/libpng
	sys-libs/zlib
	X?	  ( virtual/x11 )
	icc?	( dev-lang/icc )
	svga?   ( media-libs/svgalib )"

src_compile() {

	econf || die

	# fix system default povray.ini to point to install directory
	cp povray.ini povray.ini.orig
	sed -e "s:\(/usr/\)local/\(lib\):\1share:" povray.ini.orig > povray.ini

	cd src
	cp Makefile makefile.orig

	DCPU=`echo ${CPPFLAGS} | sed -e "s/.*i\(.86\).*/\\1/"`
	echo "s/^CPPFLAGS.*-DCPU=686/CPPFLAGS = -DCPU=${DCPU}/" > makefile.sed
	
	# Change the header file with the banner when you start povray
	cp optout.h optout.h.orig
	sed -e "s/DISTRIBUTION_MESSAGE_2.*$/DISTRIBUTION_MESSAGE_2 \"Gentoo Linux - `uname -n` - ${USER}\"/" optout.h.orig > optout.h
	cp optout.h optout.h.orig
	sed -e "s/#error You must complete the following DISTRIBUTION_MESSAGE macro//" optout.h.orig > optout.h

	# rphillips - removed because of compilation issues
	# echo "s/^CPPFLAGS =/CPPFLAGS = -ansi -c/" >> makefile.sed

	if [ "`use icc`" ]; then
		# ICC CPPFLAGS
		echo "s/g++/icc/" >> makefile.sed
		echo "s/gcc/icc/" >> makefile.sed

		# Should pull from /etc/make.conf
		# If you have a P4 add -tpp7 after the -O3
		# If you want lean/mean replace -axiMKW with -x? (see icc docs for -x)
		# Note: -ipo breaks povray
		# Note: -ip breaks povray on a P3
		# echo "s/^CPPFLAGS =/CPPFLAGS = -O3 -axiMKW /" >> makefile.sed
		# This is optimized for my Pentium 2:
		echo "s/^CPPFLAGS =/CPPFLAGS = -O3 -xM -ip /" >> makefile.sed
		# This is optimized for Pentium 3 (semi-untested, I don't own one):
		#echo "s/^CPPFLAGS =/CPPFLAGS = -O3 -xK /" >> makefile.sed
		#This is optimized for Pentium 4 (untested, I don't own one):
		#echo "s/^CPPFLAGS =/CPPFLAGS = -O3 -xW -ip -tpp7 /" >> makefile.sed

		# GCC CPPFLAGS
		echo "s/^CPPFLAGS =/CPPFLAGS = -finline-functions -ffast-math /" >> makefile.sed
		echo "s/^CPPFLAGS =/CPPFLAGS = ${CFLAGS} /" >> makefile.sed

    # fix library dependency
	echo 's/LIBS = \(.*\)/LIBS = \1 -ldl/' >> makefile.sed

	cp Makefile Makefile.orig
	sed -f makefile.sed Makefile.orig > Makefile

	cd ${P}

	# stl compatibility
	patch -f -p1 < ${FILESDIR}/gentoo-3.50a.patch

	einfo Building povray
	emake || die
}

src_install ()
{
	emake DESTDIR=${D} install || die

	mkdir -p ${D}/etc
	dosym /usr/share/povray-3.5/povray.ini /etc/povray.ini
}

pkg_postinst ()
{
	einfo "Installing configuration files"
	einfo "*Warning* I/O Security disabled by default"
	einfo "          Check /etc/povray.conf to enable"

	echo -e "[File I/O Security]\nnone" > /etc/povray.conf
	
}
