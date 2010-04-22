# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/tornado/tornado-0.2.ebuild,v 1.3 2010/04/22 18:51:30 arfrever Exp $

EAPI="2"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="a scalable, non-blocking web server and tools (as used at FriendFeed)"
HOMEPAGE="http://www.tornadoweb.org/"
SRC_URI="http://www.tornadoweb.org/static/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="dev-python/pycurl
	dev-python/simplejson"
RDEPEND="${DEPEND}"
RESTRICT_PYTHON_ABIS="3.*"
