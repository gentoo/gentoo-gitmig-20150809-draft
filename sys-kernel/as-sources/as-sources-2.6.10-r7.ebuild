# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/as-sources/as-sources-2.6.10-r7.ebuild,v 1.1 2005/04/15 17:27:21 blubb Exp $

ETYPE="sources"
UNIPATCH_LIST="${DISTDIR}/patch-${KV}.gz"
K_PREPATCHED="yes"
UNIPATCH_STRICTORDER="yes"
ASVERSION="as7"
inherit kernel-2
detect_version
K_NOSETEXTRAVERSION="don't_set_it"
DESCRIPTION="Andres Salomon's  kernel, mostly bugfixes. More Informatins http://kerneltrap.org/node/4545"
SRC_URI="${KERNEL_URI} http://www.acm.rpi.edu/~dilinger/patches/${PV}/${ASVERSION}/patch-${KV}.gz"
HOMEPAGE="http://www.acm.cs.rpi.edu/~dilinger/patches/"
KEYWORDS="~x86 ~amd64"
IUSE=""
