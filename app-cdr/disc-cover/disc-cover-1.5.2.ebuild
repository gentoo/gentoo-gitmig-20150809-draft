# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/disc-cover/disc-cover-1.5.2.ebuild,v 1.2 2004/02/25 13:43:25 bazik Exp $

DESCRIPTION="Creates CD-Covers via Latex by fetching cd-info from freedb.org or local file"
HOMEPAGE="http://home.wanadoo.nl/jano/disc-cover.html"
SRC_URI="http://home.wanadoo.nl/jano/files/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc sparc"
SLOT="0"

DEPEND=">=dev-perl/Audio-CD-disc-cover-0.05
	>=app-text/tetex-1.0.7-r7"

src_compile() {
	pod2man disc-cover > disc-cover.1 || die
}

src_install() {
	dobin disc-cover
	doman disc-cover.1

	dodoc AUTHORS CHANGELOG COPYING TODO

	exeinto /usr/share/disc-cover/
	doexe index.cgi online.cgi

	insinto /usr/share/disc-cover/
	doins busy.png offline.png online.png

	insinto /usr/share/disc-cover/templates
	doins templates/*
}
