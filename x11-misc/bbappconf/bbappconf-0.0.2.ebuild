# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/bbappconf/bbappconf-0.0.2.ebuild,v 1.2 2003/02/13 17:07:02 vapier Exp $

S=${WORKDIR}/${P}
DESCRIPTION="bbappconf is a utility that allows you to specify window properties in blackbox"
SRC_URI="http://bbtools.windsofstorm.net/sources/${P}.tar.gz"
HOMEPAGE="http://bbtools.windsofstorm.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc "

DEPEND="virtual/blackbox"

src_compile() {
	econf || die
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS BUGS ChangeLog COPYING NEWS README TODO
}
