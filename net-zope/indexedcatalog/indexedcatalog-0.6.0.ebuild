# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/indexedcatalog/indexedcatalog-0.6.0.ebuild,v 1.4 2011/04/06 13:33:50 arfrever Exp $

EAPI="3"

inherit distutils

MY_PN=IndexedCatalog
S=${WORKDIR}/${MY_PN}-${PV}

DESCRIPTION="Zope IndexedCatalog"
HOMEPAGE="http://www.async.com.br/projects/${MY_PN}/"
SRC_URI="http://www.async.com.br/projects/${MY_PN}/dist/${MY_PN}-${PV}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="dev-lang/python
	net-zope/zodb"
