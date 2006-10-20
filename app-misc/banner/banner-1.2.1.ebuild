# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/banner/banner-1.2.1.ebuild,v 1.12 2006/10/20 05:31:19 nyhm Exp $

DESCRIPTION="The well known banner program for linux"
HOMEPAGE="http://cedar-solutions.com"
SRC_URI="http://cedar-solutions.com/software/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc ~mips amd64"
IUSE=""

DEPEND="virtual/libc
	!games-misc/bsd-games"

src_install() {
	einstall || die
	dodoc README AUTHORS INSTALL
}
