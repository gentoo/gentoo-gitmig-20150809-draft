# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/mjpegtools/mjpegtools-1.6.2-r3.ebuild,v 1.20 2005/03/27 20:08:31 lu_zero Exp $

inherit flag-o-matic gcc eutils

M4V="1"

DESCRIPTION="Tools for MJPEG video"
HOMEPAGE="http://mjpeg.sourceforge.net/"
SRC_URI="mirror://sourceforge/mjpeg/${P}.tar.gz
	mirror://gentoo/${PN}-m4-${M4V}.tar.bz2"

LICENSE="as-is"
SLOT="1"
KEYWORDS="x86 ppc amd64 ~sparc ppc64"
IUSE="gtk avi dv quicktime sdl X yv12 3dnow mmx sse v4l dga"

RDEPEND="media-libs/jpeg
	x86? ( media-libs/libmovtar
		mmx? ( >=media-libs/jpeg-mmx-1.1.2-r1 )
	)
	gtk? ( =x11-libs/gtk+-1.2*
		=dev-libs/glib-1.2* )
	avi? ( media-video/avifile )
	dv? ( >=media-libs/libdv-0.99 )
	quicktime? ( virtual/quicktime )
	sdl? ( >=media-libs/libsdl-1.2.7-r3 )
	X? ( virtual/x11 )"

DEPEND="${RDEPEND}
	x86? ( mmx? ( dev-lang/nasm )
		3dnow? ( dev-lang/nasm )
		sse? ( dev-lang/nasm )
		)
	>=sys-apps/sed-4
	sys-devel/autoconf
	=sys-devel/automake-1.5*"

src_unpack() {
	unpack ${A} ; cd ${S}

	epatch ${FILESDIR}/${P}-configure.patch
	epatch ${FILESDIR}/${P}-fPIC.patch
	epatch ${FILESDIR}/${P}-gcc34.patch

	if use ppc; then
		# Fix an error in the detection of the altivec-support
		# in the compiler
		epatch "${FILESDIR}/altivec-fix-${PV}.patch"
		sed -i -e 's:-O3::' configure.in
		#Worst workaround ever...
		sed -i -e "s/const vector signed short/vector signed short/g" \
			${S}/utils/altivec/fdct_idct.c
	fi

	libtoolize --copy --force
	ACLOCAL="aclocal -I ${WORKDIR}/m4" autoreconf || die

	use X || epatch "${FILESDIR}/no-x11-lib-2.patch"
}

src_compile() {
	local myconf

	if use yv12 && use dv; then
		myconf="${myconf} --with-dv-yv12"
	elif use yv12; then
		ewarn "yv12 support is possible when 'dv' is in your USE flags."
	fi

	# This could be changed to allow building on g/fbsd in the future.
	if use x86; then
		if use mmx || use 3dnow || use sse; then
			myconf="${myconf} --enable-simd-accel"
			strip-flags -fstack-protector
		fi
		if use mmx; then
			myconf="${myconf} --with-jpeg-mmx=/usr/include/jpeg-mmx"
		fi
		
		if [[ ${CHOST/i686/} != ${CHOST} ]] || [[ ${CHOST/x86_64/} != ${CHOST} ]]; then
			myconf="${myconf} --enable-cmov-extension"
		fi
		
		[[ $(gcc-major-version) -eq 3 ]] && append-flags -mno-sse2
	fi

	econf \
		$(use_with X x) \
		$(use_enable dga xfree-ext) \
		$(use_with quicktime) \
		$(use_with v4l) \
		$(use_with gtk) \
		$(use_with sdl) \
		$(use_with dv dv /usr) \
		${myconf} || die

	if has_pie; then
		pie_magic="$(test_flag -fno-pic) $(test_flag -nopie)"
		
		find "${S}" -name Makefile | xargs sed -i \
			-e "s:CC = gcc:CC = gcc ${pie_magic}:g" \
			-e "s:CXX = gcc:CXX = g++ ${pie_magic}:g" \
			-e "s:CXXCPP = gcc -E:CXX = g++ -E ${pie_magic}:g" \
			|| die "sed failed"
	fi

	emake CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}" -j1 || die "emake failed"
	cd docs
	local infofile
	for infofile in mjpeg*info*; do
		echo "INFO-DIR-SECTION Miscellaneous" >> ${infofile}
		echo "START-INFO-DIR-ENTRY" >> ${infofile}
		echo "* mjpeg-howto: (mjpeg-howto).                  How to use the mjpeg-tools" >> ${infofile}
		echo "END-INFO-DIR-ENTRY" >> ${infofile}
	done
}

src_install() {
	einstall || die "install failed"
	dodoc mjpeg_howto.txt README PLANS NEWS README.AltiVec README.avilib \
		README.DV README.glav README.lavpipe README.transist TODO \
		HINTS BUGS ChangeLog AUTHORS CHANGES
}
