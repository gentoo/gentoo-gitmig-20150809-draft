# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/webut/webut-0.1.0.2.ebuild,v 1.1 2008/08/21 23:47:35 neurogeek Exp $

inherit distutils versionator

MY_P=${PN}_$(replace_version_separator 2 '-')
DESCRIPTION="Miscellaneous utilities for nevow and twisted.web programming"
HOMEPAGE="http://www.inoi.fi/open/trac/webut"
SRC_URI="http://debian.cn99.com/debian/pool/main/w/${PN}/${MY_P}.tar.gz"

LICENSE="X11"
SLOT="0"
KEYWORDS="~x86"
IUSE="examples"

DEPEND=""
RDEPEND=">=dev-python/twisted-2
		>=net-zope/zopeinterface-3.0.1
		>=dev-python/nevow-0.9.18"

S="${WORKDIR}/${PN}-${PV:0:3}"

src_install(){
	distutils_src_install

	use examples && \
		insinto "/usr/share/${PF}"
		doins -r examples

	rm -rf "${D}"/examples
}
