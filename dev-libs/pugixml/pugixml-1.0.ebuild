# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/pugixml/pugixml-1.0.ebuild,v 1.1 2012/04/08 07:36:29 radhermit Exp $

EAPI=4

inherit cmake-utils

DESCRIPTION="Light-weight, simple, and fast XML parser for C++ with XPath support"
HOMEPAGE="http://pugixml.org/"
SRC_URI="http://pugixml.googlecode.com/files/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S=${WORKDIR}/scripts

PATCHES=( "${FILESDIR}"/${P}-cmake.patch )
