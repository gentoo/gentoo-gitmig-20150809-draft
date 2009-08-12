# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/morseall/morseall-0.4.8.ebuild,v 1.2 2009/08/12 18:20:10 williamh Exp $

DESCRIPTION="Allows people who have limitid mobility to control their computer using morse code"
HOMEPAGE="http://morseall.org/"
SRC_URI="http://pehr.net/software/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-amd64 ~x86"
IUSE=""

DEPEND="gnome-extra/at-spi"
RDEPEND="${DEPEND}"

src_install() {
	make DESTDIR="${D}" install || die "install failed"
	dodoc README CHANGES
}
