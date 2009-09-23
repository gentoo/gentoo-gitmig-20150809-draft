# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/rote/rote-0.2.8.ebuild,v 1.2 2009/09/23 17:26:01 patrick Exp $

inherit eutils

DESCRIPTION="A simple C library for VT102 terminal emulation"
HOMEPAGE="http://rote.sourceforge.net/"
SRC_URI="mirror://sourceforge/rote/${P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=""

src_install() {
	make DESTDIR=${D} install || die
	dodoc README
}
