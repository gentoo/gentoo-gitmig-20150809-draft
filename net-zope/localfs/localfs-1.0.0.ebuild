# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/localfs/localfs-1.0.0.ebuild,v 1.5 2003/09/08 06:53:30 msterret Exp $

inherit zproduct

S="${WORKDIR}/lib/python/Products/"
PV_NEW=${PV//./-}

DESCRIPTION="Zope product for accessing the local filesystem"
HOMEPAGE="http://sourceforge.net/projects/localfs/"
SRC_URI="mirror://sourceforge/localfs/LocalFS-${PV_NEW}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"

ZPROD_LIST="LocalFS"
