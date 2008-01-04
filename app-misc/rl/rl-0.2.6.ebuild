# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/rl/rl-0.2.6.ebuild,v 1.3 2008/01/04 17:25:34 nixnut Exp $

DESCRIPTION="Randomize lines from text files or stdin"
HOMEPAGE="http://ch.tudelft.nl/~arthur/rl/"
SRC_URI="http://ch.tudelft.nl/~arthur/rl/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~mips ppc ~s390 ~sparc x86"
IUSE="debug"

DEPEND=""
RDEPEND="${DEPEND}"

src_compile() {
	local myconf=""

	use debug && myconf="${myconf} --enable-debug"

	econf ${myconf} || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make install DESTDIR="${D}" || die "install failed"
	dodoc AUTHORS ChangeLog INSTALL NEWS README TODO
}
