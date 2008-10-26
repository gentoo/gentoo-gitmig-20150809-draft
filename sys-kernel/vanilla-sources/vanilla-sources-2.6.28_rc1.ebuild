# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/vanilla-sources/vanilla-sources-2.6.28_rc1.ebuild,v 1.3 2008/10/26 17:31:47 corsair Exp $

K_NOUSENAME="yes"
K_NOSETEXTRAVERSION="yes"
K_SECURITY_UNSUPPORTED="1"
ETYPE="sources"
inherit kernel-2
detect_version

DESCRIPTION="Full sources for the Linux kernel"
HOMEPAGE="http://www.kernel.org"
SRC_URI="${KERNEL_URI}"

KEYWORDS="~ppc ~ppc64 ~x86"
IUSE=""

K_EXTRAEWARN="The e1000e driver is this kernel version is non-functional but
will not damage your hardware. See bug #238489 for more information"
