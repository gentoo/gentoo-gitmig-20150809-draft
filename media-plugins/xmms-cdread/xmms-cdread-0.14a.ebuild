# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-cdread/xmms-cdread-0.14a.ebuild,v 1.6 2004/06/24 23:37:46 agriffis Exp $

IUSE=""

DESCRIPTION="XMMS plugin to read audio cdroms as data"
HOMEPAGE="ftp://mud.stack.nl/pub/OuterSpace/willem/"
SRC_URI="ftp://mud.stack.nl/pub/OuterSpace/willem/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc"

DEPEND="media-sound/xmms"

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS README ChangeLog INSTALL NEWS TODO
}
