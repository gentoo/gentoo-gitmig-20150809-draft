# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/localfs/localfs-1.0.0.ebuild,v 1.9 2006/01/27 02:37:25 vapier Exp $

inherit zproduct

PV_NEW=${PV//./-}
DESCRIPTION="Zope product for accessing the local filesystem"
HOMEPAGE="http://sourceforge.net/projects/localfs/"
SRC_URI="mirror://sourceforge/localfs/LocalFS-${PV_NEW}.tgz"

LICENSE="GPL-2"
KEYWORDS="~ppc x86"

S=${WORKDIR}/lib/python/Products

ZPROD_LIST="LocalFS"
