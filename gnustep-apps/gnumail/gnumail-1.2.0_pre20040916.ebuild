# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-apps/gnumail/gnumail-1.2.0_pre20040916.ebuild,v 1.3 2004/10/21 19:08:12 fafhrd Exp $

inherit gnustep

S=${WORKDIR}/${PN/gnum/GNUM}

DESCRIPTION="A fully featured mail application for GNUstep"
HOMEPAGE="http://www.collaboration-world.com/gnumail/"
SRC_URI="mirror://gentoo/${P/gnum/GNUM}.tar.gz"
KEYWORDS="~x86 ~ppc"
LICENSE="GPL-2"
SLOT="0"

IUSE="${IUSE} xface crypt emoticon"
DEPEND="${GS_DEPEND}
	gnustep-libs/pantomime
	gnustep-apps/addresses"
RDEPEND="${GS_RDEPEND}
	crypt? app-crypt/gnupg
	gnustep-libs/pantomime
	gnustep-apps/addresses"

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

	use xface && cp -a ${S}/Bundles/Face/Face.bundle ${D}${GENTOO_GNUSTEP_ROOT}/System/Library/GNUMail/
	use crypt && cp -a ${S}/Bundles/PGP/PGP.bundle ${D}${GENTOO_GNUSTEP_ROOT}/System/Library/GNUMail/
	use emoticon && cp -a ${S}/Bundles/Emoticon/Emoticon.bundle ${D}${GENTOO_GNUSTEP_ROOT}/System/Library/GNUMail/

	egnustep_package_config
}
