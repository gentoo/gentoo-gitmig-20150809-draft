# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/cfv/cfv-1.18.1.ebuild,v 1.8 2007/06/17 13:19:57 swegener Exp $

inherit eutils

DESCRIPTION="Utility to test and create .sfv, .csv, .crc and md5sum files"
HOMEPAGE="http://cfv.sourceforge.net/"
SRC_URI="mirror://sourceforge/cfv/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="amd64 ~hppa ppc ~ppc-macos ~sparc x86 ~x86-fbsd"

DEPEND=""
RDEPEND="dev-lang/python
	dev-python/python-fchksum"

src_unpack()  {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-modulefix.patch
}

src_compile() {
	true
}

src_install() {
	dobin cfv || die "dobin failed"
	doman cfv.1 || die "doman failed"
	dodoc README Changelog || die "dodoc failed"
}
