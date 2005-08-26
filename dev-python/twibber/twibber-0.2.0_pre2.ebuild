# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/twibber/twibber-0.2.0_pre2.ebuild,v 1.2 2005/08/26 14:22:57 agriffis Exp $

inherit distutils

# for alphas,..
MY_PV="${PV/_pre/pre}"
MY_P="${PN}-${MY_PV}"
DESCRIPTION="twibber is a Python package aimed at handling the Jabber - XMMP protocol in a completely asynchronous way. This means absolutely no threads which may become very harmful and cause a lot of pain."
HOMEPAGE="http://slarty.polito.it:8069/~sciasbat/wiki/moin.cgi/twibber"
SRC_URI="http://www.jabberstudio.org/projects/twibber/releases/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE="doc"

DEPEND=">=dev-python/pyxml-0.8.3
	>=dev-python/twisted-1.3.0"

S=${WORKDIR}/${MY_P}

src_install() {
	distutils_src_install

	# install docs if wanted
	if use doc; then
		dodir /usr/share/docs/${P}
		cp -r ${S}/docs ${S}/tests ${S}/examples ${D}/usr/share/doc/${P}/
	fi
}
