# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/phpxmlrpc/phpxmlrpc-1.0.99.2.ebuild,v 1.9 2005/04/01 04:56:48 agriffis Exp $

inherit php-lib

MY_PN="xmlrpc"
MY_P="${MY_PN}-${PV}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="PHP implementation of the XML-RPC web RPC protocol"
HOMEPAGE="http://phpxmlrpc.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"
RESTRICT="nomirror"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ppc ia64 ~sparc ~amd64"

IUSE=""
DEPEND=""
RDEPEND=">=virtual/php-4.0.5"

src_install() {
	# install php files
	php-lib_src_install . xmlrpc.inc xmlrpcs.inc

	# Install docs and demos
	dodoc README
	dohtml doc/*.html
	dodir /usr/share/${PN}
	cp *.fttb *.pem *.php *.pl *.py *.txt ${D}/usr/share/${PN}/
}
