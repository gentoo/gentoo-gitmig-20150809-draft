# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/pybookreader/pybookreader-0.5.0.ebuild,v 1.2 2010/02/07 20:11:15 pva Exp $

EAPI=2
inherit distutils

MY_P=PyBookReader-${PV}
DESCRIPTION="A book reader for .fb2 .html and plain text (possibly gzipped)"
HOMEPAGE="http://pybookreader.narod.ru/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="dev-python/pygtk
	dev-libs/libxml2[python]"

S=${WORKDIR}/${MY_P}
