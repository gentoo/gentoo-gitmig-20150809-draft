# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/espresso-ab/espresso-ab-1.0.ebuild,v 1.4 2004/06/24 21:58:18 agriffis Exp $

IUSE=""

DESCRIPTION="POSIX compliant version of the espresso logic minimization tool"
HOMEPAGE="http://www.cs.man.ac.uk/amulet/projects/balsa/"
SRC_URI="ftp://ftp.cs.man.ac.uk/pub/amulet/balsa/other-software/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc"

DEPEND="virtual/glibc"

src_compile() {
	econf || die "econf failed"
	emake || die
}

src_install() {
	einstall || die "make install failed"

	dodoc COPYING README
}

