# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gaim-xmms-remote/gaim-xmms-remote-1.8.ebuild,v 1.1 2004/10/29 20:08:59 rizzo Exp $

inherit debug

DESCRIPTION="control XMMS from within Gaim"
HOMEPAGE="http://guifications.sourceforge.net/Gaim-XMMS-Remote/"
SRC_URI="mirror://sourceforge/guifications/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"
IUSE=""

DEPEND=">=net-im/gaim-1.0.0
	media-sound/xmms"

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog INSTALL NEWS README VERSION
}
