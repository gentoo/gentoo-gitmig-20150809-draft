# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/vanilla-sources/vanilla-sources-2.6.11_rc1.ebuild,v 1.2 2005/01/21 20:22:53 dsd Exp $

K_NOUSENAME="yes"
K_NOSETEXTRAVERSION="yes"
ETYPE="sources"
inherit kernel-2
detect_version

DESCRIPTION="Full sources for the Linux kernel"
HOMEPAGE="http://www.kernel.org"
SRC_URI="${KERNEL_URI}"
KEYWORDS="~amd64 ~alpha ~ia64 ~ppc ~x86 ~arm"
