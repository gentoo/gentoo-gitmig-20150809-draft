# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/xanim-export/xanim-export-2.80.1-r3.ebuild,v 1.12 2004/07/14 22:26:55 agriffis Exp $

inherit flag-o-matic eutils
strip-flags -finline-functions
replace-flags -O3 -O2

_XA_CYUV_SPARC=xa1.0_cyuv_sparcELF.o
_XA_CVID_SPARC=xa2.0_cvid_sparcELF.o
_XA_IV32_SPARC=xa2.0_iv32_sparcELF.o
_XA_SPARC_EXT=.Z

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
	ppc)
		_XA_CYUV=$_XA_CYUV_PPC
		_XA_CVID=$_XA_CVID_PPC
		_XA_IV32=$_XA_IV32_PPC
		_XA_EXT=$_XA_PPC_EXT
		_XA_UNCOMPRESS=uncompress
		;;
	x86)
		_XA_CYUV=$_XA_CYUV_I386
		_XA_CVID=$_XA_CVID_I386
		_XA_IV32=$_XA_IV32_I386
		_XA_EXT=$_XA_I386_EXT
		_XA_UNCOMPRESS=gunzip
		;;
esac

DESCRIPTION="XAnim with Quicktime and RAW Audio export functions"
HOMEPAGE="http://heroin.linuxave.net/toys.html"
SRC_URI="http://heroine.linuxave.net/xanim_exporting_edition.tar.gz
	sparc? (
		ftp://xanim.va.pubnix.com/modules/${_XA_CYUV_SPARC}${_XA_SPARC_EXT}
		ftp://xanim.va.pubnix.com/modules/${_XA_CVID_SPARC}${_XA_SPARC_EXT}
		ftp://xanim.va.pubnix.com/modules/${_XA_IV32_SPARC}${_XA_SPARC_EXT}
	)
	ppc? (
		ftp://xanim.va.pubnix.com/modules/${_XA_CYUV_PPC}${_XA_PPC_EXT}
		ftp://xanim.va.pubnix.com/modules/${_XA_CVID_PPC}${_XA_PPC_EXT}
		ftp://xanim.va.pubnix.com/modules/${_XA_IV32_PPC}${_XA_PPC_EXT}
	)
	x86? (
		ftp://xanim.va.pubnix.com/modules/${_XA_CYUV_I386}${_XA_I386_EXT}
		ftp://xanim.va.pubnix.com/modules/${_XA_CVID_I386}${_XA_I386_EXT}
		ftp://xanim.va.pubnix.com/modules/${_XA_IV32_I386}${_XA_I386_EXT}
	)"

LICENSE="XAnim"
SLOT="0"
KEYWORDS="x86 ppc sparc"
IUSE=""

DEPEND=">=sys-libs/glibc-2.1.3
	>=media-libs/jpeg-6b
	>=media-libs/libpng-1.2.1
	virtual/x11"
RDEPEND="app-arch/ncompress"

S=${WORKDIR}/xanim_exporting_edition

src_unpack() {
	unpack xanim_exporting_edition.tar.gz

	cd ${S}/mods
	cp ${DISTDIR}/${_XA_CYUV}${_XA_EXT} .
	$_XA_UNCOMPRESS ${_XA_CYUV}${_XA_EXT}
	cp ${DISTDIR}/${_XA_CVID}${_XA_EXT} .
	$_XA_UNCOMPRESS ${_XA_CVID}${_XA_EXT}
	cp ${DISTDIR}/${_XA_IV32}${_XA_EXT} .
	$_XA_UNCOMPRESS ${_XA_IV32}${_XA_EXT}

	cd ${S}
	rm xanim
	epatch ${FILESDIR}/${PV}-makefile.patch
}

src_compile() {
	cd ${S}/quicktime
	make \
		XA_IV32_LIB=mods/${_XA_CYUV} \
		XA_CVID_LIB=mods/${_XA_CVID} \
		XA_CYUV_LIB=mods/${_XA_IV32} \
		|| die "make quicktime failed"
	cd ..
	make \
		XA_IV32_LIB=mods/${_XA_CYUV} \
		XA_CVID_LIB=mods/${_XA_CVID} \
		XA_CYUV_LIB=mods/${_XA_IV32} \
		OPTIMIZE="${CFLAGS}" \
		|| die "main make failed"
}

src_install() {
	newbin xanim xanim-export
	insinto /usr/lib/xanim/mods-export
	doins mods/*
	dodoc README*
	dodoc docs/README.* docs/*.readme docs/*.doc
}
