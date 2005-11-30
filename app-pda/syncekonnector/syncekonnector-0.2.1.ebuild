# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/syncekonnector/syncekonnector-0.2.1.ebuild,v 1.1.1.1 2005/11/30 10:02:22 chriswhite Exp $

inherit kde autotools

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

need-kde 3.2

src_unpack() {
	kde_src_unpack
	cp "${FILESDIR}/${P}-configure.in.in" "${S}/src/configure.in.in"
}

src_compile() {
	make -f Makefile.cvs
	kde_src_compile
}
