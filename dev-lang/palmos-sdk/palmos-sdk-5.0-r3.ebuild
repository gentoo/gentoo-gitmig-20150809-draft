# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/palmos-sdk/palmos-sdk-5.0-r3.ebuild,v 1.1 2003/12/25 19:19:25 plasmaroo Exp $

DESCRIPTION="The static libraries and header files needed for developing PalmOS applications."
HOMEPAGE="http://www.palmos.com/"
LICENSE="Palm-SDK"

SLOT="5.0R3"
KEYWORDS="~x86"
DEPEND="dev-lang/prc-tools"

A="palmos-sdk-5.0r3-1.tar.gz"
AD="PalmOS_5_SDK_68K_R3_no-install.zip"

IUSE=""
BASE="/opt/palmdev/sdk-${SLOT}"
RESTRICT="nostrip"
S=${WORKDIR}

pkg_setup() {

	if [ ! -f ${DISTDIR}/${A} ]; then
		echo
		eerror "Please go to http://www.palmos.com/cgi-bin/sdk50.cgi"
		eerror "and download ${A} and place it in ${DISTDIR}"
		eerror "and emerge this package again."
		die
	fi

	if ( [ ! -f ${DISTDIR}/${AD} ] && [ `use doc` ] ); then
		echo
		eerror "Please go to http://www.palmos.com/cgi-bin/sdk50.cgi"
		eerror "and download ${AD} and place it in"
		eerror "${DISTDIR} and emerge this package again or disable the \`doc'"
		eerror "USE flag."
		die
	fi

}

src_unpack() {

	unpack ${A}
	if [ `use doc` ]; then
		unpack ${AD}
	fi

}

src_install() {

	dodir ${BASE}
	rm -rf sdk-5r3/CodeWarrior\ Support
	if [ `use doc` ]; then
		rm -rf PalmOS_5_SDK_68K_R3_no-install/CodeWarrior\ Support/\(Project\ Stationery\)/
		rm -rf PalmOS_5_SDK_68K_R3_no-install/CodeWarrior\ Support/Plugins/
		rm -rf PalmOS_5_SDK_68K_R3_no-install/Palm\ OS\ Support/
		rm -rf PalmOS_5_SDK_68K_R3_no-install/Palm\ Tools/
		cp -Rf PalmOS_5_SDK_68K_R3_no-install/* sdk-5r3/
	fi
	cp -PRf sdk-5r3/* ${D}/opt/palmdev/sdk-${SLOT}

}

pkg_postinst()
{
	palmdev-prep || eerror "Could not run \`palmdev-prep'!"
}
