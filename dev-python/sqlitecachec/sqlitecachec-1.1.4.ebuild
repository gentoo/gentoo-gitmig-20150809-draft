# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/sqlitecachec/sqlitecachec-1.1.4.ebuild,v 1.1 2010/12/26 16:22:38 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit distutils

MY_P="yum-metadata-parser-${PV}"

DESCRIPTION="sqlite cacher for python applications"
HOMEPAGE="http://yum.baseurl.org/"
SRC_URI="http://yum.baseurl.org/download/yum-metadata-parser/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

RDEPEND="dev-db/sqlite:3
	dev-libs/glib:2
	dev-libs/libxml2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="sqlitecachec.py"
