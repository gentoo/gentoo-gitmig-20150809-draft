# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/rl/rl-0.2.2.ebuild,v 1.5 2004/06/28 02:00:39 ciaranm Exp $

DESCRIPTION="Randomize lines from text files or stdin"
HOMEPAGE="http://tiefighter.et.tudelft.nl/~arthur/rl/"
SRC_URI="http://tiefighter.et.tudelft.nl/~arthur/rl/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 s390 ~sparc ~mips"

IUSE="debug"
DEPEND="virtual/glibc"

src_compile() {
	local myconf=""

	use debug && myconf="${myconf} --enable-debug"

	econf ${myconf} || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make install DESTDIR=${D} || die "install failed"

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README TODO
}
