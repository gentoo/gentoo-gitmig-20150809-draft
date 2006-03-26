# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-libs/artresources/artresources-0.1.2.ebuild,v 1.13 2006/03/26 09:27:13 grobian Exp $

inherit gnustep

S=${WORKDIR}/

DESCRIPTION="GNUstep ArtResources library for GNUstep Backend library"

# 26 Mar 2006: upstream appears to be gone
SRC_URI="http://w1.423.telia.com/~u42308495/alex/backart/ArtResources-${PV}.tar.bz2"
HOMEPAGE="http://w1.423.telia.com/~u42308495/alex"
KEYWORDS="x86 ppc sparc ~alpha amd64"
SLOT="0"
LICENSE="LGPL-2.1"

PROVIDES="virtual/gnustep-back"

IUSE=""
DEPEND="gnustep-base/gnustep-gui
	>=media-libs/libart_lgpl-2.3.16"

egnustep_install_domain "System"

src_compile() {
	echo "nothing to compile"
}

src_install() {
	egnustep_env
	dodir $(egnustep_system_root)/Library/Fonts
	insinto $(egnustep_system_root)/Library/Fonts
	cp -pPR *.nfont ${D}$(egnustep_system_root)/Library/Fonts
	chown -R root:0 ${D}$(egnustep_system_root)/Library/Fonts
}

