# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/development-sources/development-sources-2.6.11_rc3.ebuild,v 1.1 2005/02/03 13:41:17 spock Exp $

K_NOUSENAME="yes"
K_NOSETEXTRAVERSION="yes"
ETYPE="sources"
inherit kernel-2
detect_arch
detect_version

DESCRIPTION="Full sources for the vanilla 2.6 kernel tree"
HOMEPAGE="http://www.kernel.org/"
SRC_URI="${KERNEL_URI} ${ARCH_URI}"
UNIPATCH_LIST="${ARCH_PATCH}"

KEYWORDS="~x86 ~ia64 ~ppc ~amd64 ~alpha ~arm"
IUSE=""
