# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/powerprefs/powerprefs-0.2.1.ebuild,v 1.12 2003/06/23 00:11:59 rac Exp $

S=${WORKDIR}/${P}
DESCRIPTION="powerprefs is a PPC-only program to interface with special Powerbook/iBook keys in Linux"
SRC_URI="http://www.cymes.de/members/joker/projects/pbbuttons/tar/${P}.tar.gz"
HOMEPAGE="http://www.cymes.de/members/joker/projects/pbbuttons/pbbuttons.html"
KEYWORDS="ppc -x86 -amd64 -sparc "
SLOT="0"
LICENSE="GPL-2"
DEPEND="x11-libs/gtk+"
RDEPEND="sys-apps/pbbuttonsd"

pkg_setup() {
	if [ ${ARCH} != "ppc" ] ; then
		eerror "Sorry, this is a PPC only package."
		die "Sorry, this as a PPC only pacakge."
	fi
}

src_compile() {

	./configure --prefix=/usr || die "sorry, ppc-only package"
	make || die "sorry, powerprefs compile failed"
}

src_install() {

	make \
		prefix=${D}/usr \
		mandir={D}/usr/share/man \
		infodir={D}/usr/share/info \
		install || die "sorry, failed to install powerprefs"

	dodoc README COPYING

}
