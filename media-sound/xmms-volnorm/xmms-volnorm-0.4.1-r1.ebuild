# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-sound/xmms-volnorm/xmms-volnorm-0.4.1-r1.ebuild,v 1.1 2002/08/08 13:17:10 seemant Exp $ 

MY_P=${P/xmms-/}
S=${WORKDIR}/${MY_P} 
DESCRIPTION="Plugin for XMMS, music will be played at the same volume even if it
is recorded at a different volume level"
SRC_URI="mirror://sourceforge/volnorm/${MY_P}.tar.gz"
HOMEPAGE="http://volnorm.sourceforge.net"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="media-sound/xmms"

src_compile() {

	econf || die
	emake || die
}

src_install() {
	
	einstall \
		libdir=${D}/usr/lib/xmms/Effect || die

	dodoc AUTHORS BUGS COPYING ChangeLog NEWS INSTALL README RELEASE TODO
}
