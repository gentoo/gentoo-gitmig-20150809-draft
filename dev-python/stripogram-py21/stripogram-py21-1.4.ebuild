# Copyright 2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-python/stripogram-py21/stripogram-py21-1.4.ebuild,v 1.3 2003/06/22 12:16:00 liquidx Exp $

PYTHON_SLOT_VERSION=2.1

inherit distutils
P_NEW="${PN%-py21}-${PV/\./-}"
S=${WORKDIR}/${PN%-py21}

DESCRIPTION="A library for converting HTML to Plain Text."
HOMEPAGE="http://www.zope.org/Members/chrisw/StripOGram/"
SRC_URI="${HOMEPAGE}/${P_NEW}.tgz"
SLOT="0"
KEYWORDS="~x86 ~ppc"
LICENSE="MIT"
IUSE=""

