# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/gtkpbbuttons/gtkpbbuttons-0.5.2.ebuild,v 1.7 2003/06/21 21:19:39 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="gtkpbbuttons is a PPC-only program to monitor special Powerbook/iBook keys in Linux"
SRC_URI="http://www.cymes.de/members/joker/projects/pbbuttons/tar/${P}.tar.gz"
HOMEPAGE="http://www.cymes.de/members/joker/projects/pbbuttons/pbbuttons.html"
KEYWORDS="x86 amd64 -mips -sparc -alpha -arm"
SLOT="0"
LICENSE="GPL-2"

DEPEND="=x11-libs/gtk+-1.2* media-libs/audiofile >=sys-apps/pbbuttonsd-0.5"

src_compile() {
	./configure --prefix=/usr || die "sorry, gtkpbbuttons configure failed"
	make || die "sorry, gtkpbbuttons compile failed"
}

src_install() {
	make \
		prefix=${D}/usr \
		mandir={D}/usr/share/man \
		infodir={D}/usr/share/info \
		install || die "sorry, failed to install gtkpbbuttons"

	dodoc README COPYING
}
