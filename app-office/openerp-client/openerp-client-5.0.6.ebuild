# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/openerp-client/openerp-client-5.0.6.ebuild,v 1.1 2010/01/29 19:48:20 elvanor Exp $

EAPI="2"

inherit eutils distutils

DESCRIPTION="Open Source ERP & CRM"
HOMEPAGE="http://www.openerp.com/"
SRC_URI="http://www.openerp.com/download/stable/source/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

CDEPEND="dev-python/matplotlib
		dev-python/egenix-mx-base
		x11-libs/hippo-canvas[python]"

RDEPEND="${CDEPEND}"
DEPEND="${CDEPEND}"

src_install() {
	distutils_src_install
	rm "${D}/usr/bin/openerp-client"
	dobin "${FILESDIR}/openerp-client"
}
