# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/rl/rl-0.2.3.ebuild,v 1.1 2005/04/02 17:03:58 swegener Exp $

DESCRIPTION="Randomize lines from text files or stdin"
HOMEPAGE="http://tiefighter.et.tudelft.nl/~arthur/rl/"
SRC_URI="http://tiefighter.et.tudelft.nl/~arthur/rl/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~mips ~s390 ~amd64 ~ppc"
IUSE="debug"

DEPEND="virtual/libc"

src_compile() {
	local myconf=""

	use debug && myconf="${myconf} --enable-debug"

	econf ${myconf} || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make install DESTDIR=${D} || die "install failed"
	dodoc AUTHORS ChangeLog INSTALL NEWS README TODO
}
