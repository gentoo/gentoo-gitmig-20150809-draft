# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-sid/xmms-sid-0.7.4.ebuild,v 1.2 2004/02/22 22:26:25 agriffis Exp $

S=${WORKDIR}/${P}
DESCRIPTION="C64 SID plugin for XMMS"
HOMEPAGE="http://www.tnsp.org/xmms-sid.php"
SRC_URI="http://www.tnsp.org/xs-files/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~mips "

DEPEND="media-sound/xmms
	=media-libs/libsidplay-1.36*"

src_compile() {
	econf || die "./configure failed"
	emake || make || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS BUGS COPYING ChangeLog INSTALL README* NEWS TODO
}
