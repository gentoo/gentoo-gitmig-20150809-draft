# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/xanim/xanim-2.80.1-r4.ebuild,v 1.19 2004/01/29 13:38:31 agriffis Exp $

inherit flag-o-matic

SLOT="0"
LICENSE="XAnim"
KEYWORDS="x86 ppc sparc alpha -mips -hppa -arm amd64 -ia64"

_XA_CYUV_SPARC=xa1.0_cyuv_sparcELF.o
_XA_CVID_SPARC=xa2.0_cvid_sparcELF.o
_XA_IV32_SPARC=xa2.0_iv32_sparcELF.o
_XA_SPARC_EXT=.Z

_XA_CYUV_ALPHA=xa1.0_cyuv_linuxAlpha.o
_XA_CVID_ALPHA=xa2.0_cvid_linuxAlpha.o
_XA_IV32_ALPHA=xa2.0_iv32_linuxAlpha.o
_XA_ALPHA_EXT=.gz

_XA_CYUV_I386=xa1.0_cyuv_linuxELFg21.o
_XA_CVID_I386=xa2.0_cvid_linuxELFg21.o
_XA_IV32_I386=xa2.1_iv32_linuxELFg21.o
_XA_I386_EXT=.gz

_XA_CYUV_PPC=xa1.0_cyuv_linuxPPC.o
_XA_CVID_PPC=xa2.0_cvid_linuxPPC.o
_XA_IV32_PPC=xa2.0_iv32_linuxPPC.o
_XA_PPC_EXT=.Z

case $ARCH in
	sparc)
			_XA_CYUV=$_XA_CYUV_SPARC
			_XA_CVID=$_XA_CVID_SPARC
			_XA_IV32=$_XA_IV32_SPARC
			_XA_EXT=$_XA_SPARC_EXT
			_XA_UNCOMPRESS=uncompress
			;;
	alpha)
			_XA_CYUV=$_XA_CYUV_ALPHA
			_XA_CVID=$_XA_CVID_ALPHA
			_XA_IV32=$_XA_IV32_ALPHA
			_XA_EXT=$_XA_ALPHA_EXT
			_XA_UNCOMPRESS=gunzip
			;;
	ppc)
			_XA_CYUV=$_XA_CYUV_PPC
			_XA_CVID=$_XA_CVID_PPC
			_XA_IV32=$_XA_IV32_PPC
			_XA_EXT=$_XA_PPC_EXT
			_XA_UNCOMPRESS=uncompress
			;;
	amd64)
			_XA_EXT=$_XA_I386_EXT
			_XA_UNCOMPRESS=gunzip
			;;
	*)
			_XA_CYUV=$_XA_CYUV_I386
			_XA_CVID=$_XA_CVID_I386
			_XA_IV32=$_XA_IV32_I386
			_XA_EXT=$_XA_I386_EXT
			_XA_UNCOMPRESS=gunzip
			;;
esac

MY_P=${PN}${PV//.}
S=${WORKDIR}/${MY_P}
DESCRIPTION="XAnim"
HOMEPAGE="http://smurfland.cit.buffalo.edu/xanim/home.html"
XANIM_SRC="mirror://gentoo/"
SRC_URI="${XANIM_SRC}/${MY_P}.tar.gz
	sparc? ${XANIM_SRC}/${_XA_CYUV_SPARC}${_XA_SPARC_EXT}
	sparc? ${XANIM_SRC}/${_XA_CVID_SPARC}${_XA_SPARC_EXT}
	sparc? ${XANIM_SRC}/${_XA_IV32_SPARC}${_XA_SPARC_EXT}
	alpha? ${XANIM_SRC}/${_XA_CYUV_ALPHA}${_XA_ALPHA_EXT}
	alpha? ${XANIM_SRC}/${_XA_CVID_ALPHA}${_XA_ALPHA_EXT}
	alpha? ${XANIM_SRC}/${_XA_IV32_ALPHA}${_XA_ALPHA_EXT}
	ppc? ${XANIM_SRC}/${_XA_CYUV_PPC}${_XA_PPC_EXT}
	ppc? ${XANIM_SRC}/${_XA_CVID_PPC}${_XA_PPC_EXT}
	ppc? ${XANIM_SRC}/${_XA_IV32_PPC}${_XA_PPC_EXT}
	x86? ${XANIM_SRC}/${_XA_CYUV_I386}${_XA_I386_EXT}
	x86? ${XANIM_SRC}/${_XA_CVID_I386}${_XA_I386_EXT}
	x86? ${XANIM_SRC}/${_XA_IV32_I386}${_XA_I386_EXT}"

DEPEND="virtual/x11
	>=sys-libs/zlib-1.1.3
	>=sys-apps/sed-4.0.5
	ppc? ( app-arch/ncompress )
	sparc? ( app-arch/ncompress )"


src_unpack() {
	unpack ${MY_P}.tar.gz
	if [ "$ARCH" != "amd64" ]
	then
		mkdir ${S}/mods
		cd ${S}/mods
		cp ${DISTDIR}/${_XA_CYUV}${_XA_EXT} .
		$_XA_UNCOMPRESS ${_XA_CYUV}${_XA_EXT}
		cp ${DISTDIR}/${_XA_CVID}${_XA_EXT} .
		$_XA_UNCOMPRESS ${_XA_CVID}${_XA_EXT}
		cp ${DISTDIR}/${_XA_IV32}${_XA_EXT} .
		$_XA_UNCOMPRESS ${_XA_IV32}${_XA_EXT}
	fi

	# -O higher than -O2 breaks for GCC3.1
	filter-flags -finline-functions
	filter-flags "-O?" "-O2"
	#CFLAGS=${CFLAGS//-O[0-9]/-O2}
	if [ "$ARCH" = "amd64" ]
	then
		sed -e "s:-O2:${CFLAGS}:" ${FILESDIR}/Makefile.amd64 > ${S}/Makefile
	else
		sed -e "s:-O2:${CFLAGS}:" ${FILESDIR}/Makefile > ${S}/Makefile
	fi

}

src_compile() {
	if [ "$ARCH" = "amd64" ]
	then
		make || die
	else
		make XA_IV32_LIB=mods/${_XA_CYUV} XA_CVID_LIB=mods/${_XA_CVID} \
			XA_CYUV_LIB=mods/${_XA_IV32} || die
	fi
}

src_install () {
	into /usr
	dobin xanim
	newman docs/xanim.man xanim.1
	insinto /usr/lib/xanim/mods
	doins mods/*
	dodoc README
	dodoc docs/README.* docs/*.readme docs/*.doc
}
