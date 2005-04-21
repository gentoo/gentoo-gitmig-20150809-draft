# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/rioutil/rioutil-1.4.7.ebuild,v 1.1 2005/04/21 11:03:14 dragonheart Exp $

DESCRIPTION="Command line tool for transfering mp3s to and from a Rio 600, 800, Rio Riot, and Nike PSA/Play"
HOMEPAGE="http://rioutil.sourceforge.net/"
SRC_URI="mirror://sourceforge/rioutil/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="sys-libs/zlib
	virtual/libc"

src_install() {
	emake DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog INSTALL NEWS README TODO
}
