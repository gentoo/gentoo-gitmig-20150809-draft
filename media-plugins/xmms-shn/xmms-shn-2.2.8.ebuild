# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-shn/xmms-shn-2.2.8.ebuild,v 1.3 2004/03/26 21:20:02 eradicator Exp $

DESCRIPTION="This input plugin allows xmms to play .shn compressed (lossless) files"
HOMEPAGE="http://shnutils.etree.org/xmms-shn"
SRC_URI="http://www.etree.org/shnutils/xmms-shn/source/${P}.tar.gz"

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
