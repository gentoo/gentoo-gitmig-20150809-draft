# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/linux-headers/linux-headers-2.2.26-r1.ebuild,v 1.1 2006/09/03 10:17:51 vapier Exp $

ETYPE="headers"
H_SUPPORTEDARCH="m68k"
inherit kernel-2
detect_version

SRC_URI="${KERNEL_URI}"

KEYWORDS="-* m68k"
