# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/gtkpbbuttons/gtkpbbuttons-0.4.6b.ebuild,v 1.7 2002/07/14 19:20:18 aliz Exp $

S=${WORKDIR}/${P}
DESCRIPTION="gtkpbbuttons is a PPC-only program to monitor special Powerbook/iBook keys in Linux"
SRC_URI="http://www.cymes.de/members/joker/projects/pbbuttons/tar/${P}.tar.gz"
HOMEPAGE="http://www.cymes.de/members/joker/projects/pbbuttons/pbbuttons.html"
KEYWORDS="x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND="x11-libs/gtk+ media-libs/audiofile sys-apps/pbbuttonsd"

pkg_setup() {
	if [ ${ARCH} != "ppc" ] ; then
		eerror "Sorry, this is a PPC only package."
		die "Sorry, this as a PPC only pacakge."
	fi
}

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
