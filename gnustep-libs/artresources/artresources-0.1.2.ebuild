# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-libs/artresources/artresources-0.1.2.ebuild,v 1.4 2004/10/31 12:03:54 kloeri Exp $

inherit gnustep

S=${WORKDIR}/

DESCRIPTION="GNUstep ArtResources library for GNUstep Backend library"

SRC_URI="http://w1.423.telia.com/~u42308495/alex/backart/ArtResources-${PV}.tar.bz2"
HOMEPAGE="http://w1.423.telia.com/~u42308495/"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"
SLOT="0"
LICENSE="LGPL-2.1"

PROVIDES="virtual/gnustep-back"

IUSE=""
DEPEND="${GNUSTEP_GUI_DEPEND}
	=media-libs/libart_lgpl-2.3.16"

src_compile() {
	echo "nothing to compile"
}

src_install() {
	egnustep_env
	dodir ${GNUSTEP_SYSTEM_ROOT}/Library/Fonts
	insinto ${GNUSTEP_SYSTEM_ROOT}/Library/Fonts
	cp -a *.nfont ${D}${GNUSTEP_SYSTEM_ROOT}/Library/Fonts
}

