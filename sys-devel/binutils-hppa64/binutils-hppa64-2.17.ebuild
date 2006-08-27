# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/binutils-hppa64/binutils-hppa64-2.17.ebuild,v 1.1 2006/08/27 08:30:50 vapier Exp $

export CTARGET=hppa64-${CHOST#*-}

PATCHVER="1.0"
UCLIBC_PATCHVER="1.0"
ELF2FLT_VER=""
inherit toolchain-binutils

DESCRIPTION="binutils package for building 64bit kernels on HPPA"

KEYWORDS="-* ~hppa"
