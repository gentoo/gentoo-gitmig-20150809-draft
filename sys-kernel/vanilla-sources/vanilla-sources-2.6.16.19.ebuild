# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/vanilla-sources/vanilla-sources-2.6.16.19.ebuild,v 1.5 2006/06/18 22:06:25 chainsaw Exp $

K_NOUSENAME="yes"
K_NOSETEXTRAVERSION="yes"
ETYPE="sources"
inherit kernel-2
detect_version

DESCRIPTION="Full sources for the Linux kernel"
HOMEPAGE="http://www.kernel.org"
SRC_URI="${KERNEL_URI}"

KEYWORDS="~alpha ~amd64 ~arm ~ia64 ppc ppc64 ~s390 ~sparc x86"
