# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/kgcc64/kgcc64-4.1.1.ebuild,v 1.2 2006/08/17 15:58:25 kumba Exp $

case ${CHOST} in
	hppa*)    CTARGET=hppa64-${CHOST#*-};;
	mips*)    CTARGET=${CHOST/mips/mips64};;
	powerpc*) CTARGET=${CHOST/powerpc/powerpc64};;
	s390*)    CTARGET=${CHOST/s390/s390x};;
	sparc*)   CTARGET=${CHOST/sparc/sparc64};;
	i?86*)    CTARGET=x86_64-${CHOST#*-};;
esac
export CTARGET
TOOLCHAIN_ALLOWED_LANGS="c"
GCC_TARGET_NO_MULTILIB=true

PATCH_VER="1.6"
ETYPE="gcc-compiler"
GCC_FILESDIR=${FILESDIR/${PN}/gcc}

inherit toolchain eutils

DESCRIPTION="64bit kernel compiler"

KEYWORDS="-* ~hppa ~mips ~ppc ~s390 ~sparc ~x86"

# unlike every other target, hppa has not unified the 32/64 bit
# ports in binutils yet
DEPEND="hppa? ( sys-devel/binutils-hppa64 )
	!sys-devel/gcc-mips64"

src_unpack() {
	gcc_src_unpack

	# Fix cross-compiling
	epatch "${GCC_FILESDIR}"/4.1.0/gcc-4.1.0-cross-compile.patch
}
