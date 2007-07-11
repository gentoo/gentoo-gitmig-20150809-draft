# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/httplib2/httplib2-0.2.0.ebuild,v 1.2 2007/07/11 06:19:47 mr_bones_ Exp $

inherit distutils

DESCRIPTION="A comprehensive HTTP client library with caching and authentication."
HOMEPAGE="http://bitworking.org/projects/httplib2/"
SRC_URI="http://bitworking.org/projects/${PN}/dist/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""
DEPEND=">=dev-lang/python-2.3"
RDEPEND="${DEPEND}"
