# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/twisted-conch/twisted-conch-0.5.0.ebuild,v 1.1 2005/04/08 14:06:17 lordvan Exp $

inherit distutils

# for alphas,..
MY_PV="${PV/_alpha/a}"
MY_PN="TwistedConch"
MY_P="${MY_PN}-${MY_PV}"
DESCRIPTION="An SSH and SFTP protocol implementation together with clients and servers."
HOMEPAGE="http://twistedmatrix.com/projects/conch/"
SRC_URI="http://tmrc.mit.edu/mirror/twisted/Conch/0.5/${MY_P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc ~alpha ~sparc"
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
