# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/rcenter/rcenter-0.6.1.ebuild,v 1.5 2004/03/19 23:34:39 eradicator Exp $

DESCRIPTION="Rcenter - A program to control the EMU10K Remote Control"
HOMEPAGE="http://rooster.stanford.edu/~ben/projects/rcenter.php"
SRC_URI="http://rooster.stanford.edu/~ben/projects/${P}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""
DEPEND="virtual/glibc"

src_compile() {
	emake || die
}

src_install() {
	chmod 755 rcenter
	dobin rcenter
	dodir /usr/share/rcenter
	cp -R config ${D}/usr/share/rcenter/
	dodoc HISTORY LICENSE README
}

pkg_postinst() {
	einfo "Rcenter Installed  - However You need to setup the scripts"
	einfo "for making remote control commands actually work"
	einfo " "
	einfo "The Skel scripts can be copied from /usr/share/rcenter/config to <user>/.rcenter"
	einfo "Where <user> is a person who will use rcenter"
}
