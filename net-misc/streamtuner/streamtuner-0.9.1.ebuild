# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/streamtuner/streamtuner-0.9.1.ebuild,v 1.2 2003/06/12 21:49:14 msterret Exp $

DESCRIPTION="Stream directory browser for browsing internetradio streams"
SRC_URI="http://osdn.dl.sourceforge.net/sourceforge/streamtuner/${P}.tar.gz"
HOMEPAGE="http://www.nongnu.org/streamtuner/"
KEYWORDS="~x86"
SLOT="0"
LICENSE="as-is"

DEPEND=">=x11-libs/gtk+-2.0.0
	>=net-ftp/curl-7.7.0"

src_compile() {
    econf || die "./configure failed"
    emake || die
}

src_install () {
    make DESTDIR=${D} \
    sysconfdir=${D}/etc \
    install || die
    dodoc ChangeLog NEWS LICENCE INSTALL TODO
} 
