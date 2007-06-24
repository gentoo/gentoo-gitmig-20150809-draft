# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-libs/steptalk/steptalk-0.9.1.ebuild,v 1.2 2007/06/24 18:03:06 peper Exp $

inherit gnustep

DESCRIPTION="StepTalk is the official GNUstep scripting framework."
HOMEPAGE="http://www.gnustep.org/experience/StepTalk.html"
SRC_URI="ftp://ftp.gnustep.org/pub/gnustep/libs/${P/steptalk/StepTalk}.tar.gz"

# it doesn' compile!  ~ppc ~x86
KEYWORDS=""
LICENSE="LGPL-2.1"
SLOT="0"

IUSE="doc"
DEPEND="${GS_DEPEND}"
RDEPEND="${GS_RDEPEND}"
S="${WORKDIR}/${P/steptalk/StepTalk}"

egnustep_install_domain "System"

src_install() {
	cd ${S}
	egnustep_env
	egnustep_install || die

	if use doc ; then
		egnustep_env
		cd Documentation
		mkdir -p ${TMP}/tmpdocs
		mv *.* ${TMP}/tmpdocs
		mv Reference ${TMP}/tmpdocs
		mkdir -p ${D}$(egnustep_install_domain)/Library/Documentation/Developer/${PN/stept/StepT}
		mv ${TMP}/tmpdocs/* ${D}$(egnustep_install_domain)/Library/Documentation/Developer/${PN/stept/StepT}
		cd ..
	fi
	egnustep_package_config
}
