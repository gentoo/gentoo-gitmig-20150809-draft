# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/mjpegtools/mjpegtools-1.6.1.90.ebuild,v 1.4 2003/09/20 20:05:58 pappy Exp $

inherit flag-o-matic

DESCRIPTION="Tools for MJPEG video."
HOMEPAGE="http://mjpeg.sourceforge.net/"
SRC_URI="mirror://sourceforge/mjpeg/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 -ppc"
IUSE="gtk avi dv quicktime sdl X 3dnow mmx sse"

DEPEND="media-libs/jpeg
	>=sys-apps/sed-4
	=dev-libs/glib-1.2*
	x86? ( media-libs/libmovtar )
	mmx? ( >=media-libs/jpeg-mmx-1.1.2-r1 dev-lang/nasm )
	3dnow? ( dev-lang/nasm )
	sse? ( dev-lang/nasm )
	gtk? ( =x11-libs/gtk+-1.2* )
	avi? ( >=media-video/avifile-0.7.38 )
	dv? ( >=media-libs/libdv-0.99 )
	quicktime? ( virtual/quicktime )
	sdl? ( media-libs/libsdl )
	X? ( x11-base/xfree )"

src_compile() {
	local myconf

	replace-flags "-march=pentium4" "-march=pentium3"
	filter-flags "-mfpmath=sse"

	myconf="${myconf} `use_with X x`"
	myconf="${myconf} `use_with quicktime`"
	myconf="${myconf} `use_enable x86 cmov-extensions`"

	if [ "`use dv`" ] ; then
		myconf="${myconf} --with-dv=/usr"
	fi
	if [ "`use mmx`" -o "`use 3dnow`" -o "`use sse`" ] ; then
		myconf="${myconf} --enable-simd-accel"
	fi
	if [ "`use mmx`" ] ; then
		myconf="${myconf} --with-jpeg-mmx=/usr/include/jpeg-mmx"
	fi

	econf ${myconf}

	# http://www.gentoo.org/proj/en/hardened/etdyn-ssp.xml
	has_version 'sys-devel/hardened-gcc' && find ${W} -name "Makefile" -type f -exec \
		sed -i "s:CC = gcc:CC = gcc -yet_exec:g" {} \;
	has_version 'sys-devel/hardened-gcc' && find ${W} -name "Makefile" -type f -exec \
		sed -i "s:CXX = gcc:CXX = g++ -yet_exec:g" {} \;
	has_version 'sys-devel/hardened-gcc' && find ${W} -name "Makefile" -type f -exec \
		sed -i "s:CXXCPP = gcc -E:CXX = g++ -E -yet_exec:g" {} \;

	emake || die "compile problem"
}

src_install() {
	einstall
	dodoc mjpeg_howto.txt
}
