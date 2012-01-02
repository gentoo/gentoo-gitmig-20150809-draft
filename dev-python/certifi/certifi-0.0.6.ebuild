# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/certifi/certifi-0.0.6.ebuild,v 1.1 2012/01/02 06:56:38 floppym Exp $

EAPI="4"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="SSL root certificate bundle"
HOMEPAGE="http://python-requests.org/"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="app-misc/ca-certificates"

src_install() {
	distutils_src_install
	installing() {
		# Overwrite bundled certificates with a symlink.
		dosym "${EPREFIX}/etc/ssl/certs/ca-certificates.crt" \
			"$(python_get_sitedir -b)/certifi/cacert.pem"
	}
	python_execute_function installing
}
