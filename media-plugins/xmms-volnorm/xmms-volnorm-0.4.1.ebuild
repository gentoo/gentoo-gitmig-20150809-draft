# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-volnorm/xmms-volnorm-0.4.1.ebuild,v 1.4 2003/09/07 00:02:15 msterret Exp $

MY_P=${P/xmms-/}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Plugin for XMMS, music will be played at the same volume even if it
is recorded at a different volume level"
SRC_URI="http://download.sourceforge.net/volnorm/${MY_P}.tar.gz"
HOMEPAGE="http://volnorm.sourceforge.net"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="media-sound/xmms"

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
