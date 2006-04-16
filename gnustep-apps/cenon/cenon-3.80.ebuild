# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-apps/cenon/cenon-3.80.ebuild,v 1.2 2006/04/16 09:15:28 grobian Exp $

inherit gnustep

S=${WORKDIR}/${PN/c/C}

DESCRIPTION="Cenon is a vector graphics tool for GNUstep, OpenStep and MacOSX"
HOMEPAGE="http://www.cenon.info/"
SRC_URI="http://www.vhf-group.com/vhfInterservice/download/source/${P/c/C}.tar.bz2"
KEYWORDS="~x86"
SLOT="0"
LICENSE="Cenon"

DEPEND="${GS_DEPEND}"
RDEPEND="${GS_RDEPEND}
	>=gnustep-libs/cenonlibrary-3.80"

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}/${P}"-install.patch
}

egnustep_install_domain "Local"
