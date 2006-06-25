# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-libs/netclasses/netclasses-1.06.ebuild,v 1.1 2006/06/25 14:11:45 grobian Exp $

inherit gnustep

DESCRIPTION="An asynchronous networking library for GNUstep"
HOMEPAGE="http://netclasses.aeruder.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

KEYWORDS="~x86"
LICENSE="GPL-2 LGPL-2.1"
SLOT="0"

IUSE=""
DEPEND="${GS_DEPEND}"
RDEPEND="${GS_RDEPEND}"

egnustep_install_domain "Local"

src_compile() {
	cd "${S}"
	econf
	gnustep_src_compile
}
