# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/syncekonnector/syncekonnector-0.2.1-r1.ebuild,v 1.1 2005/12/21 19:03:09 chriswhite Exp $

inherit eutils kde autotools

DESCRIPTION="Synchronize Windows CE devices with Linux.  KDE Konnector."
HOMEPAGE="http://synce.sourceforge.net/synce/kde/"
SRC_URI="mirror://sourceforge/synce/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=app-pda/synce-libsynce-0.9
	>=app-pda/synce-rra-0.9
	>=app-pda/orange-0.2
	>=app-arch/unshield-0.4
	app-pda/dynamite
	!app-pda/rapip"

need-kde 3.5

src_unpack() {
	kde_src_unpack
	cp "${FILESDIR}/${P}-configure.in.in" "${S}/src/configure.in.in"

	# :/
	mkdir -p ${S}/src/libkdepim
	# >:/
	cp ${FILESDIR}/kpimprefs.h ${S}/src/libkdepim
	# lalala please fix this upstream~
	epatch ${FILESDIR}/${P}-kde3.5.patch
}

src_compile() {
	make -f Makefile.cvs
	kde_src_compile
}
