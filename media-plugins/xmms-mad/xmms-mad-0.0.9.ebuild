# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-mad/xmms-mad-0.0.9.ebuild,v 1.2 2002/10/04 05:51:38 vapier Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A XMMS plugin for MAD"
SRC_URI="http://www.superduper.net/downloads/xmms-mad/${P}.tar.gz"
HOMEPAGE="http://www.superduper.net/xmms-mad/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="media-sound/xmms 
	media-sound/mad"

src_compile() {
	econf || die "./configure failed"
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die "Make failed"
	dodoc AUTHORS COPYING ChangeLog NEWS README
}
