# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/twisted-web/twisted-web-0.5.0.ebuild,v 1.3 2005/06/27 08:15:55 dholm Exp $

inherit distutils

# for alphas,..
MY_PV="${PV/_alpha/a}"
MY_PN="TwistedWeb"
MY_P="${MY_PN}-${MY_PV}"
DESCRIPTION="Twisted web has web servers and clients."
HOMEPAGE="http://twistedmatrix.com/projects/web/"
SRC_URI="http://tmrc.mit.edu/mirror/twisted/Web/0.5/${MY_P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~ppc ~sparc ~x86"
IUSE="doc"

DEPEND=">=dev-python/twisted-2.0.0"

S=${WORKDIR}/${MY_P}

src_install() {
	distutils_src_install

	if use doc; then
		dodir /usr/share/doc/${P}
		cp -r ${S}/docs ${D}/usr/share/doc/${P}/
	fi
}
