# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/streamtuner-local/streamtuner-local-0.2.1.ebuild,v 1.6 2004/06/24 23:35:07 agriffis Exp $

IUSE=""

DESCRIPTION="A plugin for Streamtuner. It allow to play and browse local mp3 files"
SRC_URI="http://savannah.nongnu.org/download/streamtuner/streamtuner-local.pkg/${PV}/${P}.tar.gz"
HOMEPAGE="http://www.nongnu.org/streamtuner/"
KEYWORDS="x86"
SLOT="0"
LICENSE="as-is"

DEPEND=">=net-misc/streamtuner-0.9.0
	>=media-libs/id3lib-3.8.0"

src_install () {
	make DESTDIR=${D} \
	sysconfdir=${D}/etc \
	install || die
	dodoc COPYING ChangeLog NEWS README INSTALL
}
