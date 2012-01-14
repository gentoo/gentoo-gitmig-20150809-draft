# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/itstool/itstool-1.1.1.ebuild,v 1.4 2012/01/14 16:50:00 maekke Exp $

EAPI="3"
PYTHON_USE_WITH="xml"
PYTHON_DEPEND="2:2.5"

inherit base python

DESCRIPTION="Translation tool for XML documents that uses gettext files and ITS rules"
HOMEPAGE="http://itstool.org/"
SRC_URI="http://files.itstool.org/itstool/${P}.tar.bz2"

# files in /usr/share/itstool/its are as-is
LICENSE="GPL-3 as-is"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="dev-libs/libxml2[python]"
DEPEND="${RDEPEND}"

pkg_setup() {
	DOCS=(ChangeLog NEWS) # AUTHORS, README are empty
}

src_prepare() {
	python_convert_shebangs -r 2 .
}
