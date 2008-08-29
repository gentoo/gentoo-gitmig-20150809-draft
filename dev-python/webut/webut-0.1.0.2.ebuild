# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/webut/webut-0.1.0.2.ebuild,v 1.3 2008/08/29 12:10:15 fmccor Exp $

inherit distutils versionator

MY_P=${PN}_$(replace_version_separator 2 '-')

DESCRIPTION="Miscellaneous utilities for nevow and twisted.web programming"
HOMEPAGE="http://www.inoi.fi/open/trac/webut"
SRC_URI="mirror://debian/pool/main/${PN:0:1}/${PN}/${MY_P}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE="examples"

DEPEND=""
RDEPEND=">=dev-python/twisted-2
		>=net-zope/zopeinterface-3.0.1
		>=dev-python/nevow-0.9.18"

S="${WORKDIR}/${PN}-$(get_version_component_range 1-2)"

src_install() {
	distutils_src_install

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi

	rm -rf "${D}/examples"
}
