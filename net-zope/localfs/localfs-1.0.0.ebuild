# Copyright 2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/localfs/localfs-1.0.0.ebuild,v 1.2 2003/03/27 05:28:19 vladimir Exp $

inherit zproduct
S="${WORKDIR}/lib/python/Products/"
PV_NEW=$(echo ${PV} |sed -e "s/\./-/g")

DESCRIPTION="Zope product for accessing the local filesystem"
HOMEPAGE="http://sourceforge.net/projects/localfs/"
SRC_URI="mirror://sourceforge/localfs/LocalFS-${PV_NEW}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"

ZPROD_LIST="LocalFS"
