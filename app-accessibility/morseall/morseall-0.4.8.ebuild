# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/morseall/morseall-0.4.8.ebuild,v 1.3 2011/08/19 11:30:44 nirbheek Exp $

EAPI="2"

DESCRIPTION="Allows people who have limitid mobility to control their computer using morse code"
HOMEPAGE="http://morseall.org/"
SRC_URI="http://pehr.net/software/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-amd64 ~x86"
IUSE=""

DEPEND="gnome-extra/at-spi:1"
RDEPEND="${DEPEND}"

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc README CHANGES
}
