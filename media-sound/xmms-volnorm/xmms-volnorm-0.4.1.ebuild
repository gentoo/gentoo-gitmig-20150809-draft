# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Jochem Prins <j.prins@gmx.net>
# $Header: /var/cvsroot/gentoo-x86/media-sound/xmms-volnorm/xmms-volnorm-0.4.1.ebuild,v 1.1 2002/05/22 14:37:22 seemant Exp $ 

MY_P=${P/xmms-/}
S=${WORKDIR}/${MY_P} 
DESCRIPTION="Plugin for XMMS, music will be played at the same volume even if it
is recorded at a different volume level"
SRC_URI="http://download.sourceforge.net/volnorm/${MY_P}.tar.gz"
HOMEPAGE="http://volnorm.sourceforge.net"

DEPEND=">=media-sound/xmms-1.2.7-r1"

src_compile() {

	econf --enable-one-plugin-dir || die
	emake || die
}

src_install() {
	
	einstall \
		libdir=${D}/usr/lib/xmms/Plugins || die

	# Don't know if this is useful, but let's try it anyway
	dodoc AUTHORS BUGS COPYING ChangeLog NEWS INSTALL README RELEASE TODO
}
