# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/development-sources/development-sources-2.6.7-r1.ebuild,v 1.2 2004/07/09 22:08:47 ciaranm Exp $

K_NOUSENAME="yes"
ETYPE="sources"
inherit kernel-2
detect_version

DESCRIPTION="Full sources for the vanilla 2.6 kernel tree"
HOMEPAGE="http://www.kernel.org/"
SRC_URI="${KERNEL_URI}"


KEYWORDS="x86 -sparc ppc ~amd64"

