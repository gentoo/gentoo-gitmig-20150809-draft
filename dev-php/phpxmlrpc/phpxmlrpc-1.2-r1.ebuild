# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/phpxmlrpc/phpxmlrpc-1.2-r1.ebuild,v 1.1 2005/08/23 17:47:56 tomk Exp $

inherit php-lib eutils

MY_PN="xmlrpc"
MY_P="${MY_PN}_${PV}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="PHP implementation of the XML-RPC web RPC protocol"
HOMEPAGE="http://phpxmlrpc.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P/_/.}.tgz"
RESTRICT="nomirror"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ~ppc ~ia64 ~sparc amd64"

IUSE=""
DEPEND=""
RDEPEND=">=virtual/php-4.0.5
	app-text/openjade
	app-text/docbook-dsssl-stylesheets"

src_unpack() {
	unpack ${A}
	cd ${S}

	# patch to fix the jade document creation
	epatch ${FILESDIR}/${P}-gentoo.patch
}

src_install() {
	# install php files
	php-lib_src_install . xmlrpc.inc xmlrpcs.inc

	# Install docs and demos
	dodoc README
	dohtml doc/*.html
	dodir /usr/share/${PN}
	cp *.fttb *.pem *.php *.pl *.py *.txt ${D}/usr/share/${PN}/
}
