# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/rpy/rpy-0.3.5-r1.ebuild,v 1.1 2005/04/26 13:27:34 liquidx Exp $

inherit distutils

DESCRIPTION="RPy is a very simple, yet robust, Python interface to the R Programming Language."
HOMEPAGE="http://rpy.sourceforge.net"
SRC_URI="mirror://sourceforge/rpy/${P}.tar.gz http://cran.r-project.org/src/base/R-2/R-2.0.0.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="virtual/python
	>=dev-lang/R-2
	dev-python/numeric"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/rpy-0.3.5-cvs_backport.patch

	# compat fix for R-2.0.0
	sed -e "s#^r_libs = .*#r_libs = '/usr/lib/R/lib'#" \
		-i ${S}/setup.py

	# fix for undefined symbol: MAIN__
	echo "int  MAIN__( ) {  return(0); }" >> ${S}/src/rpymodule.c
}

src_compile() {
	export R_SRC=${WORKDIR}/R-2.0.0
	export R_HOME=/usr/lib/R
	distutils_src_compile
}

src_install() {
	export R_SRC=${WORKDIR}/R-2.0.0
	export R_HOME=/usr/lib/R
	distutils_src_install
}