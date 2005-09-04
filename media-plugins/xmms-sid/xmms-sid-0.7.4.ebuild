# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-sid/xmms-sid-0.7.4.ebuild,v 1.8 2005/09/04 10:31:05 flameeyes Exp $

DESCRIPTION="C64 SID plugin for XMMS"
HOMEPAGE="http://www.tnsp.org/xmms-sid.php"
SRC_URI="http://www.tnsp.org/xs-files/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc ~alpha ~hppa"

IUSE=""

DEPEND="media-sound/xmms
	=media-libs/libsidplay-1.36*"

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS BUGS ChangeLog README* NEWS TODO
}
