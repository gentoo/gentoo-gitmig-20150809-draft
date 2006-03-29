# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-shn/xmms-shn-2.4.0.ebuild,v 1.6 2006/03/29 19:01:56 corsair Exp $

DESCRIPTION="This input plugin allows xmms to play .shn compressed (lossless) files"
HOMEPAGE="http://www.etree.org/shnutils/xmms-shn/"
SRC_URI="http://www.etree.org/shnutils/xmms-shn/source/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
#-sparc: 2.4.0: Playing .shn causes xmms to segfault
KEYWORDS="alpha amd64 ~hppa ~mips ~ppc ~ppc64 -sparc x86"
IUSE=""

DEPEND="media-sound/xmms"

src_install() {
	make DESTDIR=${D} libdir=$(xmms-config --input-plugin-dir) install || die
	dodoc AUTHORS NEWS README
}
