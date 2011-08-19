# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-apps/cenon/cenon-3.8.2.ebuild,v 1.1 2011/08/19 12:38:23 voyageur Exp $

inherit gnustep-2

S=${WORKDIR}/${PN/c/C}

DESCRIPTION="Cenon is a vector graphics tool for GNUstep, OpenStep and MacOSX"
HOMEPAGE="http://www.cenon.info/"
SRC_URI="http://www.vhf-group.com/vhfInterservice/download/source/${PN/c/C}-3.82.tar.bz2"
KEYWORDS="amd64 ppc x86"
SLOT="0"
LICENSE="Cenon"

RDEPEND=">=gnustep-libs/cenonlibrary-3.8.2"

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}/${PN}-3.82"-install.patch
}
