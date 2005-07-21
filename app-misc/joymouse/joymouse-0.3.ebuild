# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/joymouse/joymouse-0.3.ebuild,v 1.7 2005/07/21 17:20:35 dholm Exp $

DESCRIPTION="An application that translates joystick events to mouse events"
HOMEPAGE="http://sourceforge.net/projects/joymouse-linux"
SRC_URI="mirror://sourceforge/joymouse-linux/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="amd64 ~ppc x86"

DEPEND=""

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i \
		-e 's:$(mandir):$(DESTDIR)$(mandir):g' \
		-e '/^mandir = /s:/man:/share/man:' \
		doc/Makefile.in
}

src_install() {
	make install DESTDIR=${D} || die
	dodoc AUTHORS README
}
