# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/linux-headers/linux-headers-2.4.26-r1.ebuild,v 1.1 2005/03/30 04:10:16 vapier Exp $

ETYPE="headers"
H_SUPPORTEDARCH="arm m68k"
inherit kernel-2 eutils
detect_version

SRC_URI="${KERNEL_URI}"
KEYWORDS="-* arm m68k"

UNIPATCH_LIST=""

src_unpack() {
	tc-arch-kernel
	kernel-2_src_unpack
}
