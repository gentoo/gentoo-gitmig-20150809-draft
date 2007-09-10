# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-libs/steptalk/steptalk-0.10.0-r1.ebuild,v 1.1 2007/09/10 18:08:10 voyageur Exp $

inherit gnustep-2

MY_PN="StepTalk"
DESCRIPTION="StepTalk is the official GNUstep scripting framework."
HOMEPAGE="http://www.gnustep.org/experience/StepTalk.html"
SRC_URI="ftp://ftp.gnustep.org/pub/gnustep/libs/${MY_PN}-${PV}.tar.gz"

KEYWORDS="~amd64 ~ppc ~x86"
LICENSE="LGPL-2.1"
SLOT="0"

S="${WORKDIR}/${MY_PN}"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${P}-gnustep-make-2.patch
}

src_install() {
	gnustep-base_src_install

	if use doc ; then
		egnustep_env
		mkdir -p ${D}${GNUSTEP_SYSTEM_DOC}/Developer/${MY_PN}
		cp -R Documentation/* ${D}${GNUSTEP_SYSTEM_DOC}/Developer/${MY_PN}
	fi
}
