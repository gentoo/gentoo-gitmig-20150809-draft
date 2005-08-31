# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/antiword/antiword-0.36.1.ebuild,v 1.4 2005/08/31 10:20:10 grobian Exp $

inherit eutils

IUSE="kde"
DESCRIPTION="free MS Word reader"
SRC_URI="http://www.winfield.demon.nl/linux/${P}.tar.gz"
HOMEPAGE="http://www.winfield.demon.nl"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha amd64 ~hppa ppc ~ppc-macos ppc64 sparc x86"

DEPEND="virtual/ghostscript"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-ppc-macos.diff
}

src_compile() {
	emake || die
}

src_install() {
	dobin antiword
	use kde && dobin kantiword

	insinto /usr/share/${PN}
	doins Resources/*

	insinto /usr/share/${PN}/examples
	doins Docs/testdoc.doc Docs/antiword.php

	cd Docs
	doman antiword.1
	dodoc COPYING ChangeLog Exmh Emacs FAQ History Netscape \
	QandA ReadMe Mozilla Mutt
}
