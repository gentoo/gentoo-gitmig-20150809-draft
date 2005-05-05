# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/linux-headers/linux-headers-2.4.26-r1.ebuild,v 1.2 2005/05/05 21:49:34 gustavoz Exp $

ETYPE="headers"
H_SUPPORTEDARCH="arm m68k sparc"
inherit kernel-2 eutils
detect_version

SRC_URI="${KERNEL_URI}"
KEYWORDS="-* arm m68k ~sparc"

UNIPATCH_LIST=""

src_unpack() {
	tc-arch-kernel
	kernel-2_src_unpack
}
