# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/streamtuner-live365/streamtuner-live365-0.3.0.ebuild,v 1.2 2003/06/12 20:47:03 msterret Exp $

DESCRIPTION="A plugin for Streamtuner. It allow to play live365 streams"
SRC_URI="http://savannah.nongnu.org/download/streamtuner/streamtuner-live365.pkg/${PV}/${P}.tar.gz"
HOMEPAGE="http://www.nongnu.org/streamtuner/"
KEYWORDS="~x86"
SLOT="0"
LICENSE="as-is"

DEPEND=">=net-misc/streamtuner-0.9.0"
	

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

