# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/cddb-py/cddb-py-1.4.ebuild,v 1.10 2006/04/01 14:45:11 agriffis Exp $

inherit distutils

DESCRIPTION="CDDB Module for Python"
SRC_URI="mirror://sourceforge/cddb-py/CDDB-${PV}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/cddb-py/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ia64 ppc ppc64 sparc x86"
IUSE=""

S=${WORKDIR}/CDDB-${PV}
