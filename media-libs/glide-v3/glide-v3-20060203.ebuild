# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/glide-v3/glide-v3-20060203.ebuild,v 1.5 2006/08/13 17:49:10 dberkholz Exp $

inherit multilib eutils

LIBVER="3.10.0"

MY_PN="${PN/g/G}"
MY_PN="${MY_PN/-v3/3}"
MY_P="${MY_PN}-${PV}"

S="${WORKDIR}/${MY_P}"
DESCRIPTION="Hardware support for 3dfx Voodoo cards"
HOMEPAGE="http://glide.sourceforge.net/"
SRC_URI="mirror://gentoo/${MY_P}.tar.bz2"
LICENSE="3DFX"
SLOT="0"
KEYWORDS="-sparc x86"
IUSE="voodoo5 voodoo3 voodoo2 voodoo1"

RDEPEND="|| ( x11-libs/libX11 virtual/x11 )"
DEPEND="${RDEPEND}
	dev-lang/nasm
	|| ( x11-libs/libXt virtual/x11 )"

src_compile() {
	local compilefor glide_flags

	if use voodoo5; then
		compilefor="${compilefor} h5"
	fi
	if use voodoo3; then
		compilefor="${compilefor} h3"
	fi
	if use voodoo2; then
		compilefor="${compilefor} cvg"
	fi
	if use voodoo1; then
		if use x86; then
			compilefor="${compilefor} sst1"
		else
			ewarn "Voodoo1 support only available on x86 so far."
		fi
	fi
	# If nothing's set, build everything
	if [[ ! -n "${compilefor}" ]]; then
		compilefor="h5 h3 cvg"
		if use x86; then
			compilefor="${compilefor} sst1"
		fi
	fi

	glide_flags="TEXUS2=1"
	if use x86; then
		# Still checks for 3dnow etc at runtime
		glide_flags="${glide_flags} USE_X86=1 USE_3DNOW=1 USE_MMX=1 USE_SSE=1
			USE_SSE2=1"
	fi

	for card in ${compilefor}; do
		if [[ $card = h3 ]] || [[ $card = h5 ]]; then
			glide_flags="${glide_flags} DRI=1 XPATH=/usr/$(get_libdir)"
		fi
		make -f makefile.linux \
			FX_GLIDE_HW=${card} \
			OPTFLAGS="${CFLAGS}" \
			${glide_flags}
		if [[ $card = h5 ]]; then
			mv ${card}/lib/libglide*so libglide3-v5.so
		elif [[ $card = h3 ]]; then
			mv ${card}/lib/libglide*so libglide3-v3.so
		elif [[ $card = cvg ]]; then
			mv ${card}/lib/libglide*so libglide3-v2.so
		elif [[ $card = sst1 ]]; then
			mv ${card}/lib/libglide*so libglide3-v1.so
		fi
		make -f makefile.linux \
			FX_GLIDE_HW=${card} \
			realclean
	done
}

src_install() {
	local default_lib default_libver

	dolib.so ${S}/libglide3-v*.so

	if use voodoo5; then
		default_libver="5"
	elif use voodoo3; then
		default_libver="3"
	elif use voodoo2; then
		default_libver="2"
	elif use voodoo1; then
		default_libver="1"
	else
		# Default to voodoo3
		default_libver="3"
	fi
	default_lib="libglide3-v${default_libver}.so"

	dosym ${default_lib} /usr/$(get_libdir)/libglide3.so.${LIBVER}
	dosym libglide3.so.${LIBVER} /usr/$(get_libdir)/libglide3.so.3
	dosym libglide3.so.${LIBVER} /usr/$(get_libdir)/libglide3.so

	insinto /usr/include/glide3
	doins \
		swlibs/fxmisc/3dfx.h \
		h5/glide3/src/g3ext.h \
		h5/glide3/src/glide.h \
		h5/glide3/src/glidesys.h \
		h5/glide3/src/glideutl.h \
		swlibs/fxmisc/linutil.h \
		h5/incsrc/sst1vid.h \
		swlibs/texus2/lib/texus.h
}
