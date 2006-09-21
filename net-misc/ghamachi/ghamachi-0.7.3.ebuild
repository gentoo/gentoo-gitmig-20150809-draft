# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ghamachi/ghamachi-0.7.3.ebuild,v 1.1 2006/09/21 14:35:21 caleb Exp $

inherit eutils

# gHamachi GUI
GTK_VER="0.7.3"
GTK2_VER="0.7.3"

DESCRIPTION="gHamachi is a GUI for the Hamachi tunneling software package."
HOMEPAGE="http://www.penguinbyte.com/software/ghamachi/"
LICENSE="as-is"
SRC_URI="gtk2? ( http://purebasic.myftp.org/files/3/projects/${PN}/v.${GTK_VER}/gHamachi_gtk2.tar.gz )
	!gtk2? ( http://purebasic.myftp.org/files/3/projects/${PN}/v.${GTK2_VER}/gHamachi_gtk1.2.tar.gz )"
SLOT="0"
KEYWORDS="~x86"
IUSE="gtk2"
RESTRICT="nostrip nomirror"
DEPEND="net-misc/hamachi
	gtk2? ( >=x11-libs/gtk+-2* )
	!gtk2? ( =x11-libs/gtk+-1.2* ) "

src_unpack() {

	# Installing gHamachi readme
	if use gtk2; then
		unpack gHamachi_gtk2.tar.gz
		mv ${WORKDIR}/README ${WORKDIR}/README.gHamachi
	else
		unpack gHamachi_gtk1.2.tar.gz
		mv ${WORKDIR}/README ${WORKDIR}/README.gHamachi
	fi
}

#src_compile() { 
#	
#	# No compilation
#}

src_install() {
	einfo "Installing GUI"
	insinto /usr/bin
	insopts -m0755
	doins ${WORKDIR}/ghamachi
	dodoc ${WORKDIR}/README.gHamachi
}

