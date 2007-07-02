# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/palmos-sdk/palmos-sdk-5.0-r3.ebuild,v 1.7 2007/07/02 14:44:59 peper Exp $

DESCRIPTION="The static libraries and header files needed for developing PalmOS applications."
HOMEPAGE="http://www.palmos.com/"
LICENSE="Palm-SDK"

SLOT="5.0R3"
KEYWORDS="~x86"
RDEPEND="dev-lang/prc-tools"
DEPEND="${RDEPEND}
	app-arch/unzip"
SRC_URI="palmos-sdk-5.0r3-1.tar.gz PalmOS_5_SDK_68K_R3_no-install.zip"
IUSE="doc"
RESTRICT="strip fetch"
S=${WORKDIR}

pkg_nofetch() {
	typeset a

	einfo "Please download the following files from"
	einfo "http://www.palmos.com/cgi-bin/sdk50.cgi"
	einfo "and put them in ${DISTDIR}, then emerge this package again."
	for a in ${A}; do
		einfo "  ${a}"
	done
}

src_install() {
	typeset base=/opt/palmdev/sdk-${SLOT}

	rm -rf sdk-5r3/CodeWarrior\ Support || die
	if use doc; then
		rm -rf "PalmOS_5_SDK_68K_R3_no-install/CodeWarrior Support/(Project Stationery)" || die
		rm -rf "PalmOS_5_SDK_68K_R3_no-install/CodeWarrior Support/Plugins" || die
		rm -rf "PalmOS_5_SDK_68K_R3_no-install/Palm OS Support" || die
		rm -rf "PalmOS_5_SDK_68K_R3_no-install/Palm Tools" || die
		cp -Rf PalmOS_5_SDK_68K_R3_no-install/* sdk-5r3 || die
	fi

	dodir ${base%/*} || die
	mv sdk-5r3 ${D}${base} || die
}

pkg_postinst() {
	palmdev-prep || eerror "Error running palmdev-prep :-("
}
