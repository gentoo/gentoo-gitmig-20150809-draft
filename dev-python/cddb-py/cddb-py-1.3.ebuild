# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/cddb-py/cddb-py-1.3.ebuild,v 1.7 2004/06/25 01:26:47 agriffis Exp $

DESCRIPTION="CDDB Module for Python"
SRC_URI="mirror://sourceforge/cddb-py/CDDB-${PV}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/cddb-py/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc"
IUSE=""

S=${WORKDIR}/CDDB-${PV}

inherit distutils
