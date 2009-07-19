# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/pybookreader/pybookreader-0.5.0.ebuild,v 1.1 2009/07/19 11:38:25 grozin Exp $
EAPI=2
inherit distutils
DESCRIPTION="A book reader for .fb2 .html and plain text (possibly gzipped)"
MY_PN=PyBookReader
MY_P=${MY_PN}-${PV}
S="${WORKDIR}"/${MY_P}
HOMEPAGE="http://${PN}.narod.ru/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
RDEPEND="dev-python/pygtk
	dev-libs/libxml2[python]"
