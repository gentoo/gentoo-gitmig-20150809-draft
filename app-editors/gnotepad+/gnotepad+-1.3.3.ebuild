# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/gnotepad+/gnotepad+-1.3.3.ebuild,v 1.7 2004/11/22 05:10:53 vapier Exp $

inherit eutils

DESCRIPTION="simple HTML and text editor"
HOMEPAGE="http://gnotepad.sourceforge.net/"
SRC_URI="http://download.sourceforge.net/gnotepad/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~sparc ~x86"
IUSE=""

DEPEND="=x11-libs/gtk+-1.2*"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-destdir.patch
}

src_install() {
	make install DESTDIR="${D}" || die
	dodoc AUTHORS ChangeLog HACKING NEWS README TODO
}
