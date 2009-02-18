# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/py-rrdtool/py-rrdtool-0.2.1-r1.ebuild,v 1.8 2009/02/18 14:53:20 pva Exp $

EAPI="2"
inherit eutils distutils

DESCRIPTION="Python wrapper for RRDtool"
SRC_URI="mirror://sourceforge/py-rrdtool/${P}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/py-rrdtool/"

KEYWORDS="~ia64 ppc x86"
LICENSE="LGPL-2.1"
SLOT="0"
IUSE=""

DEPEND="virtual/python
	>=net-analyzer/rrdtool-1.2[-python]"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PN}-rrdtool12.patch"
}
