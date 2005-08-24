# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-astronomy/tkseti/tkseti-3.06.ebuild,v 1.3 2005/08/24 12:56:18 cryos Exp $

DESCRIPTION="TkSeti is a GUI to control the SETI@Home client for UNIX."
SRC_URI="http://www.timshel.ca/tkseti/${P}.tar.gz"
HOMEPAGE="http://www.timshel.ca/tkseti/"

DEPEND=">=dev-lang/tcl-8.3.3
	dev-lang/tk
	sci-astronomy/setiathome"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~sparc x86"
IUSE=""

src_compile() {
	echo "Nothing to compile for ${P}."
}

src_install () {
	dobin tkseti
	doman tkseti.1
	dodoc CHANGES README DOC
	insinto /usr/share/tkseti/contrib
	doins contrib/*
}
