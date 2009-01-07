# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libmimic/libmimic-1.0.4.ebuild,v 1.4 2009/01/07 21:48:57 armin76 Exp $

DESCRIPTION="Video encoding/decoding library for the codec used by msn"
HOMEPAGE="http://farsight.sourceforge.net"
SRC_URI="mirror://sourceforge/farsight/${P}.tar.gz"
LICENSE="LGPL-2"
KEYWORDS="~alpha ~amd64 ~ia64 ~sparc ~x86"
SLOT="0"
IUSE=""
DEPEND=">=dev-libs/glib-2"

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS ChangeLog README
}
