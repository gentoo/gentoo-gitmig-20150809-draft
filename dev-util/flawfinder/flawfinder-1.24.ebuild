# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/flawfinder/flawfinder-1.24.ebuild,v 1.3 2004/06/28 05:26:16 ciaranm Exp $

DESCRIPTION="Examines C/C++ source code for security flaws"
HOMEPAGE="http://www.dwheeler.com/flawfinder/"
SRC_URI="http://www.dwheeler.com/flawfinder/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~mips"
IUSE=""

DEPEND=""
RDEPEND="dev-lang/python"

S=${WORKDIR}/${P}

src_install() {
	dobin ${PN}
	doman ${PN}.1
	dodoc ChangeLog INSTALL.txt README announcement
	dodoc flawfinder.pdf
}
