# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/id3-py/id3-py-1.2.ebuild,v 1.1 2003/04/19 00:56:25 blauwers Exp $

DESCRIPTION="Module for manipulating ID3 tags in Python"
SRC_URI="http://id3-py.sourceforge.net/ID3.tar.gz"
HOMEPAGE="http://id3-py.sourceforge.net/"

LICENSE="GPL2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="virtual/python"

inherit distutils

src_install() {
	mydoc="CHANGES"
	distutils_src_install
}
