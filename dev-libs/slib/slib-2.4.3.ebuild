# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-libs/slib/slib-2.4.3.ebuild,v 1.4 2002/08/01 18:46:28 seemant Exp $

MY_P=${PN}2d3
S=${WORKDIR}/${PN}
DESCRIPTION="SLIB is a library providing functions for Scheme implementations."
SRC_URI="http://swissnet.ai.mit.edu/ftpdir/scm/${MY_P}.zip"
HOMEPAGE="http://swissnet.ai.mit.edu/~jaffer/SLIB.html"

SLOT="0"
LICENSE="public-domain BSD"
KEYWORDS="x86"

RDEPEND=">=dev-util/guile-1.4"

DEPEND="${RDEPEND}
	>=app-arch/unzip-5.21
	>=dev-util/guile-1.4"


src_install () {

	insinto /usr/share/guile/site/slib
	doins *.scm
	dodoc ANNOUNCE ChangeLog FAQ README
	doinfo slib.info
}

pkg_postinst () {

	if [ "${ROOT}" == "/" ]
	then
	echo "Installing..."
		guile -c "(use-modules (ice-9 slib)) (require 'new-catalog)" "/" 
	fi
}
