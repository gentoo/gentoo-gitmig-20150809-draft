# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-plugins/avi-xmms/avi-xmms-1.2.3.ebuild,v 1.1 2002/08/30 16:50:01 seemant Exp $

inherit flag-o-matic

S=${WORKDIR}/${P}
DESCRIPTION="A xmms plugin for AVI/DivX movies"
SRC_URI="http://www.xmms.org/files/plugins/avi-xmms/${P}.tar.gz"
HOMEPAGE="http://www.xmms.org/plugins_input.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="media-sound/xmms
	media-libs/libsdl"

src_compile() {
	filter-flags -fno-exceptions

	econf || die
	emake || die
}

src_install () {
	make libdir=/usr/lib/xmms/Input DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog README TODO
}
