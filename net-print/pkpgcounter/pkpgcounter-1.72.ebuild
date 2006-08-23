# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/pkpgcounter/pkpgcounter-1.72.ebuild,v 1.4 2006/08/23 21:11:46 chutzpah Exp $

inherit distutils

DESCRIPTION="pkpgcounter is a python generic PDL (Page Description Language) parser which
main feature is to count the number of pages in printable files"
HOMEPAGE="http://www.pykota.com/software/pkpgcounter"
SRC_URI="http://www.pykota.com/software/${PN}/download/tarballs/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="virtual/python"
RDEPEND="${DEPEND}"

DOCS="BUGS NEWS README CREDITS PKG-INFO"

src_install() {
	distutils_src_install

	rm -rf "${D}"/usr/share/doc/pkpgcounter
}
