# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-shn/xmms-shn-2.2.4.ebuild,v 1.7 2004/06/24 23:45:27 agriffis Exp $

DESCRIPTION="This input plugin allows xmms to play .shn compressed (lossless) files"
SRC_URI="http://shnutils.etree.org/xmms-shn/source/${P}.tar.bz2"
HOMEPAGE="http://shnutils.etree.org/xmms-shn"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~sparc ~alpha ~hppa ~mips "

IUSE=""

DEPEND="media-sound/xmms"

src_compile() {
	econf || die
	make || die
}

src_install() {
	make DESTDIR=${D} libdir=/usr/lib/xmms/Input install || die
	dodoc AUTHORS COPYING NEWS README
}
