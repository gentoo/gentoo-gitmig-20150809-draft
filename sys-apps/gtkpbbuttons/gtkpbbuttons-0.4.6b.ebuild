# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/gtkpbbuttons/gtkpbbuttons-0.4.6b.ebuild,v 1.14 2003/02/13 15:58:53 vapier Exp $

S=${WORKDIR}/${P}
DESCRIPTION="gtkpbbuttons is a PPC-only program to monitor special Powerbook/iBook keys in Linux"
SRC_URI="http://www.cymes.de/members/joker/projects/pbbuttons/tar/${P}.tar.gz"
HOMEPAGE="http://www.cymes.de/members/joker/projects/pbbuttons/pbbuttons.html"
KEYWORDS="ppc -x86 -sparc "
SLOT="0"
LICENSE="GPL-2"

DEPEND="x11-libs/gtk+ media-libs/audiofile sys-apps/pbbuttonsd"

src_compile() {
	./configure --prefix=/usr || die "sorry, ppc-only package"
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
