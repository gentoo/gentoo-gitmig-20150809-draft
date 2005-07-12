# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/remind/remind-03.00.23-r1.ebuild,v 1.3 2005/07/12 15:47:16 mcummings Exp $

DESCRIPTION="Ridiculously functional reminder program"
HOMEPAGE="http://www.roaringpenguin.com/penguin/open_source_remind.php"
SRC_URI="http://www.roaringpenguin.com/penguin/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~sparc"
IUSE=""

src_install() {
	# stupid broken makefile...
	einstall || die "first einstall failed"
	dobin www/rem2html

	dodoc README ACKNOWLEDGEMENTS COPYRIGHT WINDOWS doc/README.UNIX \
		doc/WHATSNEW* www/README.*
}
