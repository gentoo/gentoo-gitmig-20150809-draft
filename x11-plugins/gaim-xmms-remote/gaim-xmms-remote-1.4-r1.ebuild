# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gaim-xmms-remote/gaim-xmms-remote-1.4-r1.ebuild,v 1.1 2004/08/06 14:37:16 rizzo Exp $

IUSE="debug"

inherit eutils
use debug && inherit debug

DESCRIPTION="Gaim XMMS Remote is a Gaim plugin that lets you control XMMS from within gaim."

HOMEPAGE="http://guifications.sourceforge.net/Gaim-XMMS-Remote/"
SRC_URI="mirror://sourceforge/guifications/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64 ~sparc"

DEPEND=">=net-im/gaim-0.81
	media-sound/xmms"

#RDEPEND=""

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/gxr-1.4-gaim-0.81.patch
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README VERSION
}
