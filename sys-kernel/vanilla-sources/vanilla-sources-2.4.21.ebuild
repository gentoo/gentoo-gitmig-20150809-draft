# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/vanilla-sources/vanilla-sources-2.4.21.ebuild,v 1.20 2005/07/08 11:25:44 dsd Exp $

ETYPE="sources"
K_NOUSENAME="yes"
K_NOSETEXTRAVERSION="yes"
inherit kernel-2
detect_version

DESCRIPTION="Full sources for the Linux kernel"
HOMEPAGE="http://www.kernel.org"
SRC_URI="${KERNEL_URI}"
KEYWORDS="~s390"
