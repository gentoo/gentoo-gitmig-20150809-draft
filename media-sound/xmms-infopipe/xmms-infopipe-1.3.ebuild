# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/xmms-infopipe/xmms-infopipe-1.3.ebuild,v 1.1 2002/07/09 13:49:05 aliz Exp $

DESCRIPTION="Publish information about currently playing song in xmms to a temp file"

HOMEPAGE="http://www.beastwithin.org/users/wwwwolf/code/xmms/infopipe.html"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND=">=media-sound/xmms-1.2.7"

SRC_URI="http://www.beastwithin.org/users/wwwwolf/code/xmms/${P}.tar.gz"

S=${WORKDIR}/${P}

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die
	#make || die
}

src_install () {

	make DESTDIR=${D} install || die

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README

}



