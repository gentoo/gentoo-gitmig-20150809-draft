# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/id3-py/id3-py-1.2.ebuild,v 1.16 2006/07/12 15:41:09 agriffis Exp $

inherit distutils

DESCRIPTION="Module for manipulating ID3 tags in Python"
SRC_URI="http://id3-py.sourceforge.net/ID3.tar.gz"
HOMEPAGE="http://id3-py.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ia64 ppc ppc64 sparc x86"
IUSE=""

DEPEND="virtual/python"


src_install() {
	mydoc="CHANGES"
	distutils_src_install
}
