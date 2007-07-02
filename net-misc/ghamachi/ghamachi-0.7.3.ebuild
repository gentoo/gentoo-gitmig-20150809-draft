# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ghamachi/ghamachi-0.7.3.ebuild,v 1.3 2007/07/02 15:00:24 peper Exp $

inherit eutils

# gHamachi GUI
GTK2_VER="0.7.3"

DESCRIPTION="gHamachi is a GUI for the Hamachi tunneling software package."
HOMEPAGE="http://www.penguinbyte.com/software/ghamachi/"
LICENSE="as-is"
SRC_URI="http://purebasic.myftp.org/files/3/projects/${PN}/v.${GTK_VER}/gHamachi_gtk2.tar.gz"
SLOT="0"
KEYWORDS="~x86"

RESTRICT="strip mirror"
DEPEND="net-misc/hamachi
	=x11-libs/gtk+-2*"

src_unpack() {
	unpack gHamachi_gtk2.tar.gz
	mv ${WORKDIR}/README ${WORKDIR}/README.gHamachi
}

src_install() {
	einfo "Installing GUI"
	insinto /usr/bin
	insopts -m0755
	doins ${WORKDIR}/ghamachi
	dodoc ${WORKDIR}/README.gHamachi
}

