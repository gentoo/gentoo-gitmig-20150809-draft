# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-alarm/xmms-alarm-0.3.2.ebuild,v 1.2 2003/02/13 13:01:01 vapier Exp $

DESCRIPTION="An alarm plugin for XMMS"
SRC_URI="http://www.snika.uklinux.net/xmms-alarm/${P}.tar.gz"
HOMEPAGE="http://www.snika.uklinux.net/index.php?show=xmms-alarm"

SLOT="0"
KEYWORDS="~x86"
LICENSE="GPL-2"

DEPEND="=x11-libs/gtk+-1.2*
	media-sound/xmms"

src_compile() {
	econf \
		--program-suffix=-dev \
		--program-transform-name=libalarm-dev
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die "install failed"
	dodoc AUTHORS COPYING ChangeLog INSTALL README NEWS
}
