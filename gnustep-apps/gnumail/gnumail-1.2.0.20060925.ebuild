# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-apps/gnumail/gnumail-1.2.0.20060925.ebuild,v 1.4 2007/08/22 16:24:43 uberlord Exp $

inherit gnustep

MY_PN=${PN/gnum/GNUM}
MY_PV=${PV%.*}

S=${WORKDIR}/${MY_PN}

DESCRIPTION="A fully featured mail application for GNUstep"
HOMEPAGE="http://www.collaboration-world.com/gnumail/"
SRC_URI="http://www.collaboration-world.com/gnumail.data/releases/Stable/${MY_PN}-${MY_PV}pre2.tar.gz"

KEYWORDS="~ppc ~x86 ~x86-fbsd"
LICENSE="GPL-2"
SLOT="0"

IUSE="crypt doc emoticon xface"
DEPEND="${GS_DEPEND}
	=gnustep-libs/pantomime-${PV}
	>=gnustep-base/gnustep-gui-0.11.0
	gnustep-apps/addresses
	virtual/libiconv"
RDEPEND="${GS_RDEPEND}
	crypt? ( app-crypt/gnupg )
	=gnustep-libs/pantomime-${PV}
	>=gnustep-base/gnustep-gui-0.11.0
	gnustep-apps/addresses"

egnustep_install_domain "System"

src_unpack() {
	unpack ${A}

	# FIX encoding
	cd ${S}/Resources/Russian.lproj
	iconv -futf-8 -tutf-16 Localizable.strings > Localizable.strings.utf-16
	mv Localizable.strings.utf-16 Localizable.strings
}

src_compile() {
	egnustep_env
	egnustep_make

	if use xface ; then
		cd Bundles/Face
		egnustep_make
		cd ../..
	fi

	if use crypt ; then
		cd Bundles/PGP
		egnustep_make
		cd ../..
	fi

	if use emoticon ; then
		cd Bundles/Emoticon
		egnustep_make
		cd ../..
	fi
}

src_install() {
	egnustep_env
	egnustep_install
	if use doc ; then
		egnustep_env
		egnustep_doc || die
	fi

	use xface && cp -pPR ${S}/Bundles/Face/Face.bundle ${D}$(egnustep_install_domain)/Library/GNUMail/
	use crypt && cp -pPR ${S}/Bundles/PGP/PGP.bundle ${D}$(egnustep_install_domain)/Library/GNUMail/
	use emoticon && cp -pPR ${S}/Bundles/Emoticon/Emoticon.bundle ${D}$(egnustep_install_domain)/Library/GNUMail/

	egnustep_package_config

	dodoc ${S}/Documentation/*

	# FIX ?
	rm -rf ${D}$(egnustep_install_domain)/Applications/GNUMail.app/Resources/Resources
}
