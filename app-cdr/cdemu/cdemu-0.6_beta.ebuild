# Copyright 1999-2004 Gentoo Technologies, Inc., 2002-2003 Mike Frysinger
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/cdemu/cdemu-0.6_beta.ebuild,v 1.3 2004/03/12 23:28:33 vapier Exp $

inherit gcc flag-o-matic python

DESCRIPTION="mount bin/cue cd images"
HOMEPAGE="http://cdemu.org/"
SRC_URI="mirror://sourceforge/cdemu/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"

DEPEND="virtual/kernel"
RDEPEND="dev-lang/python"

src_compile() {
	emake KERN_DIR=/usr/src/linux BUILD_GHETTO=yes || die
}

src_install() {
	make install DESTDIR=${D} || die
	dodoc AUTHORS ChangeLog README TODO
}
