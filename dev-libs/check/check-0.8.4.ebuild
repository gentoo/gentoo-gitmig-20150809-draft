# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/check/check-0.8.4.ebuild,v 1.10 2004/09/22 10:37:45 pvdabeel Exp $

DESCRIPTION="unit test framework for C"
HOMEPAGE="http://sourceforge.net/projects/check/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc x86 ppc-macos macos s390"
IUSE=""

DEPEND="virtual/libc"

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog NEWS README
}
