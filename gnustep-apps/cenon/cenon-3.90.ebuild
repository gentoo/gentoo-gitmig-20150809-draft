# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-apps/cenon/cenon-3.90.ebuild,v 1.1 2009/09/21 14:45:00 voyageur Exp $

EAPI=2
inherit gnustep-2

S=${WORKDIR}/${PN/c/C}

DESCRIPTION="Cenon is a vector graphics tool for GNUstep, OpenStep and MacOSX"
HOMEPAGE="http://www.cenon.info/"
SRC_URI="http://www.vhf-group.com/vhf-interservice/download/source/${P/c/C}.tar.bz2"
KEYWORDS="~amd64 ~ppc ~x86"
SLOT="0"
LICENSE="Cenon"
IUSE=""

RDEPEND=">=gnustep-libs/cenonlibrary-3.82"

src_prepare() {
	epatch "${FILESDIR}"/${P}-install.patch
}
