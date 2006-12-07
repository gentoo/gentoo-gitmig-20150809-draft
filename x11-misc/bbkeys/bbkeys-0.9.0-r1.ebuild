# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/bbkeys/bbkeys-0.9.0-r1.ebuild,v 1.3 2006/12/07 02:24:16 flameeyes Exp $

DESCRIPTION="Use keyboard shortcuts in the blackbox wm"
HOMEPAGE="http://bbkeys.sourceforge.net"
SRC_URI="mirror://sourceforge/bbkeys/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=x11-wm/blackbox-0.70.0"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install () {
	make DESTDIR="${D}" install || die "make install failed"
	rm -rf "${D}/usr/share/doc"
	dodoc AUTHORS BUGS ChangeLog NEWS README
}
