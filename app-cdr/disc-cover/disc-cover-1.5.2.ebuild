# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/disc-cover/disc-cover-1.5.2.ebuild,v 1.8 2004/10/05 11:22:55 pvdabeel Exp $

DESCRIPTION="Creates CD-Covers via Latex by fetching cd-info from freedb.org or local file"
HOMEPAGE="http://home.wanadoo.nl/jano/disc-cover.html"
SRC_URI="http://home.wanadoo.nl/jano/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc"
IUSE=""

DEPEND=">=dev-perl/Audio-CD-disc-cover-0.05
	virtual/tetex"

src_compile() {
	pod2man disc-cover > disc-cover.1 || die
}

src_install() {
	dobin disc-cover || die
	doman disc-cover.1

	dodoc AUTHORS CHANGELOG TODO

	exeinto /usr/share/disc-cover/
	doexe index.cgi online.cgi

	insinto /usr/share/disc-cover/
	doins busy.png offline.png online.png

	insinto /usr/share/disc-cover/templates
	doins templates/*
}
