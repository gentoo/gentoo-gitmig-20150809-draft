# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-infopipe/xmms-infopipe-1.3.ebuild,v 1.6 2004/03/31 00:10:35 pylon Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Publish information about currently playing song in xmms to a temp file"
SRC_URI="http://www.beastwithin.org/users/wwwwolf/code/xmms/${P}.tar.gz"
HOMEPAGE="http://www.beastwithin.org/users/wwwwolf/code/xmms/infopipe.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~alpha ~sparc ~amd64 ~ppc"

DEPEND=">=media-sound/xmms-1.2.7"

src_compile() {
	econf || die "./configure failed"
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README
}
