# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/apsw/apsw-3.3.5.1.ebuild,v 1.1 2006/06/02 17:45:14 mrness Exp $

inherit distutils

MY_ORIG_PV="${PV%.*}-r${PV##*.}"

DESCRIPTION="APSW - Another Python SQLite Wrapper"
HOMEPAGE="http://www.rogerbinns.com/apsw.html"
SRC_URI="mirror://sourceforge/bitpim/${PN}-${MY_ORIG_PV}.zip"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-lang/python
	>=dev-db/sqlite-3.2.1"
DEPEND="app-arch/unzip
	${RDEPEND}"

S="${WORKDIR}/${PN}-${MY_ORIG_PV}"

PYTHON_MODNAME="apsw"
