# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-visualization/opendx/opendx-4.3.2-r1.ebuild,v 1.2 2007/06/26 02:45:02 mr_bones_ Exp $

# Set SMP="no" to force disable of SMP compilation.
# Set SMP="yes" to force enable of SMP compilation.
# Otherwise it will be autodetected from /usr/src/linux.

inherit eutils flag-o-matic linux-info

DESCRIPTION="A 3D data visualization tool"
HOMEPAGE="http://www.opendx.org/"
SRC_URI="http://opendx.npaci.edu/source/${P/open}.tar.gz"

#	There are a few jar files that can be added to enhance JX.
#	These are java40.jar from the Netscape libraries
#	(we've provided them in the OpenDX.org lib area) nscosmop211.jar
#	from the Cosmo Player libs.
#	http://opendx.npaci.edu/libs/
#SRC_URI="${SRC_URI}
#	http://opendx.npaci.edu/libs/netscape-java40.tar.gz
#	http://opendx.npaci.edu/libs/cosmoplayer-jar.tar.gz"

LICENSE="IPL-1"
SLOT="0"
# Should work on x86, ppc, alpha at least
KEYWORDS="amd64 ppc x86"

IUSE="hdf cdf netcdf tiff imagemagick szip" # java doc"

DEPEND="|| ( ( x11-libs/libXmu
			x11-libs/libXi
			x11-libs/libXp
			x11-libs/libXpm
		)
		virtual/x11
	)
	x11-libs/openmotif
	szip? ( sci-libs/szip )
	hdf? ( sci-libs/hdf )
	cdf? ( sci-libs/cdf )
	netcdf? ( sci-libs/netcdf )
	tiff? ( media-libs/tiff )
	imagemagick? ( >=media-gfx/imagemagick-5.3.4 )"
# waiting on bug #36349 for media-libs/jasper in imagemagick
# java support gives some trouble - deprecated api and other unresolved symbols
#		java? ( virtual/jdk
#				dev-java/java-config )"

S="${WORKDIR}/${P/open}"

smp() {
	has "$1" "${SMP}"
}

smp_check() {
	linux_chkconfig_present SMP
}

src_compile() {
	local myconf="--with-x \
		--host=${CHOST}"

	# Check for SMP
	# This needs to be done for /usr/src/linux, NOT the running kernel
	# Allow override using smp().
	if smp no
	then
		myconf="${myconf} --disable-smp-linux"
		einfo "Disabling SMP capabilities"
	elif smp yes || smp_check
	then
		myconf="${myconf} --enable-smp-linux"
		einfo "Enabling SMP capabilities"
	else
		myconf="${myconf} --disable-smp-linux"
		einfo "Disabling SMP capabilities"
	fi

	# with gcc 3.3.2 I had an infinite loop on src/exec/libdx/zclipQ.c
	append-flags -fno-strength-reduce

	# (#82672)
	filter-flags -finline-functions
	replace-flags -O3 -O2

	local GENTOOARCH="${ARCH}"
	# opendx uses this variable
	unset ARCH

	local morelibs=""
	use szip && morelibs="-lsz"
	# use java && myconf="${myconf} JNIPATH=$(java-config -O)/include:$(java-config -O)/include/linux"
	econf LIBS="${morelibs}" \
		`use_with cdf` \
		`use_with netcdf` \
		`use_with hdf` \
		`use_with tiff` \
		`use_with imagemagick magick` \
		${myconf} || die

	#		`use_with java javadx`
	# This is broken
	#	`use_enable doc installhtml`

	make || die
	ARCH="${GENTOOARCH}"
}

src_install() {
	make DESTDIR=${D} install || die
}
