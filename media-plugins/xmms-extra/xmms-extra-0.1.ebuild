# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-extra/xmms-extra-0.1.ebuild,v 1.2 2003/04/25 14:13:54 vapier Exp $

DESCRIPTION="extra collection of plugins for xmms"
HOMEPAGE="http://www.xmms.org/files/plugins/xmms-extra/"
SRC_URI="http://www.xmms.org/files/plugins/xmms-extra/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

RDEPEND=">=media-sound/xmms-1.2.7"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
}
