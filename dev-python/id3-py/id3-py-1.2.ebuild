# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/id3-py/id3-py-1.2.ebuild,v 1.5 2003/07/12 12:49:26 aliz Exp $

DESCRIPTION="Module for manipulating ID3 tags in Python"
SRC_URI="http://id3-py.sourceforge.net/ID3.tar.gz"
HOMEPAGE="http://id3-py.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="virtual/python"

inherit distutils

src_install() {
	mydoc="CHANGES"
	distutils_src_install
}
