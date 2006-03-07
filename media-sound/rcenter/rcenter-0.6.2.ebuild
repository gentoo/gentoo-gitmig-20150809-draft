# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/rcenter/rcenter-0.6.2.ebuild,v 1.12 2006/03/07 15:44:25 flameeyes Exp $

inherit eutils toolchain-funcs

IUSE=""

DESCRIPTION="Rcenter - A program to control the EMU10K Remote Control"
HOMEPAGE="http://rooster.stanford.edu/~ben/projects/rcenter.php"
SRC_URI="http://rooster.stanford.edu/~ben/projects/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
#-sparc: emu10k1 doesn't get recognized on sparc hardware
KEYWORDS="amd64 -sparc x86"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch "${FILESDIR}/${P}-makefile.patch"
}

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" || die
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
	einfo
	einfo "The Skel scripts can be copied from /usr/share/rcenter/config to <user>/.rcenter"
	einfo "Where <user> is a person who will use rcenter"
	einfo "Remeber to use emu-config -i to turn on the remote"
}

