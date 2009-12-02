# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/tornado/tornado-0.2.ebuild,v 1.2 2009/12/02 10:51:05 maekke Exp $

EAPI="2"

inherit distutils

DESCRIPTION="a scalable, non-blocking web server and tools (as used at FriendFeed)"
HOMEPAGE="http://www.tornadoweb.org/"
SRC_URI="http://www.tornadoweb.org/static/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=">=dev-lang/python-2.5"
RDEPEND="${DEPEND}
			dev-python/simplejson
			dev-python/pycurl"
