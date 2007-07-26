# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/linux-headers/linux-headers-2.4.26-r1.ebuild,v 1.23 2007/07/26 04:52:13 vapier Exp $

ETYPE="headers"
H_SUPPORTEDARCH="alpha amd64 arm m68k ppc sh sparc x86"
inherit eutils kernel-2
detect_version

SRC_URI="${KERNEL_URI}"

KEYWORDS="-* alpha -amd64 arm ia64 m68k -mips ppc ppc64 s390 sh sparc x86"

UNIPATCH_LIST="${FILESDIR}/linux-headers-2.4-armeb-stat.patch
	${FILESDIR}/linux-headers-2.4-arm-cris-ELF_DATA.patch
	${FILESDIR}/unistd.h-i386-pic.patch
	${FILESDIR}/${PN}-strict-ansi-fix.patch
	${FILESDIR}/${PN}-soundcard-ppc64.patch
	${FILESDIR}/linux-headers-2.4-errno-in-unistd.patch"
