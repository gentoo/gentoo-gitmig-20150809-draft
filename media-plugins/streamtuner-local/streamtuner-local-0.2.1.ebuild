# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/streamtuner-local/streamtuner-local-0.2.1.ebuild,v 1.2 2003/06/12 20:47:27 msterret Exp $

DESCRIPTION="A plugin for Streamtuner. It allow to play and browse local mp3 files"
SRC_URI="http://savannah.nongnu.org/download/streamtuner/streamtuner-local.pkg/${PV}/${P}.tar.gz"
HOMEPAGE="http://www.nongnu.org/streamtuner/"
KEYWORDS="~x86"
SLOT="0"
LICENSE="as-is"

DEPEND=">=net-misc/streamtuner-0.9.0
	>=media-libs/id3lib-3.8.0"

src_compile() {
    econf || die "./configure failed"
    emake || die
}

src_install () {
    make DESTDIR=${D} \
    sysconfdir=${D}/etc \
    install || die
    dodoc COPYING ChangeLog NEWS README INSTALL
}
