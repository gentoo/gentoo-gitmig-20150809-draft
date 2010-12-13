# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/openerp-web/openerp-web-5.0.6.ebuild,v 1.2 2010/12/13 15:41:12 mr_bones_ Exp $

EAPI="2"

inherit eutils distutils

DESCRIPTION="Open Source ERP & CRM"
HOMEPAGE="http://www.openerp.com/"
SRC_URI="http://www.openerp.com/download/stable/source/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

CDEPEND="dev-python/cherrypy
	dev-python/mako
	dev-python/Babel
	dev-python/formencode
	dev-python/simplejson
	dev-python/beaker"

RDEPEND="${CDEPEND}"
DEPEND="${CDEPEND}"

S="${WORKDIR}/openerp-client-web-${PV}"

src_install() {
	distutils_src_install

	doinitd "${FILESDIR}/${PN}"
	newconfd "${FILESDIR}/openerp-web-confd" "${PN}"

	rm "${D}/usr/scripts/${PN}"
	rm "${D}/usr/config/${PN}.cfg"
}
