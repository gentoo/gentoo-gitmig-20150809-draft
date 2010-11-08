# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/filesystemsite/filesystemsite-2.3.ebuild,v 1.1 2010/11/08 14:04:04 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2:2.6"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 2.5 3.*"

inherit distutils

MY_PN="Products.FileSystemSite"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="File system based site"
HOMEPAGE="http://infrae.com/download/silva_all/FileSystemSite"
SRC_URI="${HOMEPAGE}/${PV}/${MY_P}.tar.gz"

LICENSE="BSD ZPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/restrictedpython
	net-zope/accesscontrol
	net-zope/acquisition
	net-zope/datetime
	net-zope/documenttemplate
	net-zope/extensionclass
	net-zope/externalmethod
	net-zope/persistence
	net-zope/pythonscripts
	net-zope/zexceptions
	net-zope/zlog
	>=net-zope/zope-2.12
	net-zope/zope-component
	net-zope/zope-contentprovider
	net-zope/zope-contenttype
	net-zope/zope-event
	net-zope/zope-interface
	net-zope/zope-location
	net-zope/zope-schema
	net-zope/zope-tales
	net-zope/zsqlmethods"
DEPEND="${RDEPEND}
	dev-python/setuptools"

S="${WORKDIR}/${MY_P}"

DOCS="Products/FileSystemSite/HISTORY.txt README.txt"
PYTHON_MODNAME="${MY_PN/.//}"
