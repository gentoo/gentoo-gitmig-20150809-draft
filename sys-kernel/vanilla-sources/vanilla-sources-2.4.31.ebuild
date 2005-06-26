# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/vanilla-sources/vanilla-sources-2.4.31.ebuild,v 1.1 2005/06/26 09:38:20 dsd Exp $

K_NOUSENAME="yes"
K_NOSETEXTRAVERSION="yes"
ETYPE="sources"
inherit kernel-2
detect_version

HOMEPAGE="http://www.kernel.org"
SRC_URI="${KERNEL_URI}"
KEYWORDS="~x86 ~amd64"
