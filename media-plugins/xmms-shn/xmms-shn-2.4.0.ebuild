# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-shn/xmms-shn-2.4.0.ebuild,v 1.2 2004/09/03 08:59:38 eradicator Exp $

IUSE=""

DESCRIPTION="This input plugin allows xmms to play .shn compressed (lossless) files"
HOMEPAGE="http://shnutils.etree.org/xmms-shn"
SRC_URI="http://www.etree.org/shnutils/xmms-shn/source/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
#-sparc: 2.4.0: Playing .shn causes xmms to segfault
KEYWORDS="x86 ~ppc -sparc ~alpha ~hppa ~mips amd64"

DEPEND="media-sound/xmms"

src_install() {
	make DESTDIR=${D} libdir=/usr/lib/xmms/Input install || die
	dodoc AUTHORS COPYING NEWS README
}
