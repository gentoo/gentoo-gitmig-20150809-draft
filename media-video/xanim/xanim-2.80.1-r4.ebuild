# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/xanim/xanim-2.80.1-r4.ebuild,v 1.26 2004/11/14 09:18:26 corsair Exp $

inherit flag-o-matic gcc

DESCRIPTION="program for playing a wide variety of animation, audio and video formats"
HOMEPAGE="http://smurfland.cit.buffalo.edu/xanim/home.html"

LICENSE="XAnim"
SLOT="0"
KEYWORDS="x86 ppc sparc ~mips alpha hppa amd64 ia64 ~ppc64"
IUSE=""

RDEPEND="virtual/x11
	>=sys-libs/zlib-1.1.3"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4.0.5"

MY_P=${PN}${PV//.}
S=${WORKDIR}/${MY_P}

_XA_CYUV_ALPHA=xa1.0_cyuv_linuxAlpha.o
_XA_CVID_ALPHA=xa2.0_cvid_linuxAlpha.o
_XA_IV32_ALPHA=xa2.0_iv32_linuxAlpha.o
_XA_ALPHA_EXT=.gz

_XA_CYUV_PPC=xa1.0_cyuv_linuxPPC.o
_XA_CVID_PPC=xa2.0_cvid_linuxPPC.o
_XA_IV32_PPC=xa2.0_iv32_linuxPPC.o
_XA_PPC_EXT=.Z

_XA_CYUV_SPARC=xa1.0_cyuv_sparcELF.o
_XA_CVID_SPARC=xa2.0_cvid_sparcELF.o
_XA_IV32_SPARC=xa2.0_iv32_sparcELF.o
_XA_SPARC_EXT=.Z

_XA_CYUV_X86=xa1.0_cyuv_linuxELFg21.o
_XA_CVID_X86=xa2.0_cvid_linuxELFg21.o
_XA_IV32_X86=xa2.1_iv32_linuxELFg21.o
_XA_X86_EXT=.gz

# This might leave _XA_EXT empty and that's fine, just indicates no
# particular support for a given arch
eval _XA_EXT=\$_XA_`echo $ARCH | tr a-z A-Z`_EXT
eval _XA_CVID=\$_XA_CVID_`echo $ARCH | tr a-z A-Z`
eval _XA_CYUV=\$_XA_CYUV_`echo $ARCH | tr a-z A-Z`
eval _XA_IV32=\$_XA_IV32_`echo $ARCH | tr a-z A-Z`

SRC_URI="mirror://gentoo/${MY_P}.tar.gz
	sparc? (
		mirror://gentoo/${_XA_CVID_SPARC}${_XA_SPARC_EXT}
		mirror://gentoo/${_XA_CYUV_SPARC}${_XA_SPARC_EXT}
		mirror://gentoo/${_XA_IV32_SPARC}${_XA_SPARC_EXT}
	)
	alpha? (
		mirror://gentoo/${_XA_CVID_ALPHA}${_XA_ALPHA_EXT}
		mirror://gentoo/${_XA_CYUV_ALPHA}${_XA_ALPHA_EXT}
		mirror://gentoo/${_XA_IV32_ALPHA}${_XA_ALPHA_EXT}
	)
	ppc? (
		mirror://gentoo/${_XA_CVID_PPC}${_XA_PPC_EXT}
		mirror://gentoo/${_XA_CYUV_PPC}${_XA_PPC_EXT}
		mirror://gentoo/${_XA_IV32_PPC}${_XA_PPC_EXT}
	)
	x86? (
		mirror://gentoo/${_XA_CVID_X86}${_XA_X86_EXT}
		mirror://gentoo/${_XA_CYUV_X86}${_XA_X86_EXT}
		mirror://gentoo/${_XA_IV32_X86}${_XA_X86_EXT}
	)"


src_unpack() {
	unpack ${MY_P}.tar.gz
	if [[ -n ${_XA_EXT} ]]; then
		mkdir ${S}/mods || die
		cd ${S}/mods || die
		unpack ${_XA_CVID}${_XA_EXT}
		unpack ${_XA_CYUV}${_XA_EXT}
		unpack ${_XA_IV32}${_XA_EXT}
	fi
}

src_compile() {
	# -O higher than -O2 breaks for GCC3.1
	replace-flags -O3 -O2
	filter-flags -finline-functions

	# Set XA_DLL_PATH even though we statically link the mods, I guess
	# this provides extensibility
	make CC="$(gcc-getCC)" OPTIMIZE="${CFLAGS}" \
		XA_DLL_DEF="-DXA_DLL -DXA_PRINT" XA_DLL_PATH=/usr/lib/xanim/mods \
		${_XA_EXT:+ \
			XA_IV32_LIB="mods/${_XA_CVID}" \
			XA_CYUV_LIB="mods/${_XA_CYUV}" \
			XA_CVID_LIB="mods/${_XA_IV32}" }
}

src_install() {
	dobin xanim || die
	newman docs/xanim.man xanim.1
	dodoc README
	dodoc docs/README.* docs/*.readme docs/*.doc

	# I don't know why we're installing these modules when they're
	# statically linked, but whatever...
	if [[ -n ${_XA_EXT} ]]; then
		insinto /usr/lib/xanim/mods
		doins mods/${_XA_CVID}
		doins mods/${_XA_CYUV}
		doins mods/${_XA_IV32}
	fi
}
