# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/mock/mock-0.6.0.ebuild,v 1.1 2009/10/05 22:06:00 patrick Exp $

EAPI="2"

inherit distutils

DESCRIPTION="Python mocking library using action -> assertion pattern"
SRC_URI="http://www.voidspace.org.uk/downloads/${P}.zip"
HOMEPAGE="http://www.voidspace.org.uk/python/mock/"

IUSE=""
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"

DEPEND=">=virtual/python-2.4"
