# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/gdata/gdata-1.0.2.ebuild,v 1.1 2007/05/22 16:19:12 lack Exp $

inherit distutils

MY_P="gdata.py-${PV}"
DESCRIPTION="The Google data Python Client Library provides a library and source code that make it easy to access data through Google Data APIs."
HOMEPAGE="http://code.google.com/p/gdata-python-client/"
SRC_URI="http://gdata-python-client.googlecode.com/files/${MY_P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${MY_P}"
