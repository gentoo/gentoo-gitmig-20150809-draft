# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/tkseti/tkseti-3.06.ebuild,v 1.11 2004/03/22 08:57:31 phosphan Exp $

S="${WORKDIR}/${P}"
DESCRIPTION="TkSeti is a GUI to control the SETI@Home client for UNIX."
SRC_URI="http://www.cuug.ab.ca/~macdonal/tkseti/${P}.tar.gz"
HOMEPAGE="http://www.cuug.ab.ca/~macdonal/tkseti/tkseti.html"

DEPEND=""

RDEPEND=">=dev-lang/tcl-8.3.3
	 dev-lang/tk
	 app-sci/setiathome"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 sparc "

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
