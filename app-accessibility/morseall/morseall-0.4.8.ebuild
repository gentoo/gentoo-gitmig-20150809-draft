# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/morseall/morseall-0.4.8.ebuild,v 1.1 2006/04/01 06:11:24 eradicator Exp $

DESCRIPTION="Program applicated morse code for blind's"
HOMEPAGE="http://morseall.org/"
SRC_URI="http://pehr.net/software/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-amd64 ~x86"
IUSE=""

DEPEND="gnome-extra/at-spi"

src_install() {
	make DESTDIR="${D}" install || die "install failed"
	dodoc README CHANGES
}
