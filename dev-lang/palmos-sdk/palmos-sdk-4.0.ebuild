# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/palmos-sdk/palmos-sdk-4.0.ebuild,v 1.1 2003/12/25 19:19:25 plasmaroo Exp $

inherit rpm

DESCRIPTION="The static libraries and header files needed for developing PalmOS applications."
HOMEPAGE="http://www.palmos.com/"
LICENSE="Palm-SDK"

SLOT="4.0"
KEYWORDS="~x86"
DEPEND="dev-lang/prc-tools"

A1="sdk40.tar.gz"
A2="sdk40upd1.tar.gz"
AD1="sdk40-docs.zip"
AD2="sdk40-examples.tar.gz"
A="${A1} ${A2}"

IUSE=""
BASE="/opt/palmdev/sdk-${SLOT}"
RESTRICT="nostrip"
S=${WORKDIR}

pkg_setup() {

	if ! ( [ -f ${DISTDIR}/${A1} ] && [ -f ${DISTDIR}/${A2} ] ); then
		echo
		eerror "Please go to http://www.palmos.com/cgi-bin/sdk40.cgi"; \
		eerror "and download ${A1} and ${A2} and place them"; \
		eerror "in ${DISTDIR} and emerge this package again."
		die
	fi

	if ( ( [ ! -f ${DISTDIR}/${AD1} ] || [ ! -f ${DISTDIR}/${AD2} ] ) && [ `use doc` ] ); then
		echo
		eerror "Please go to http://www.palmos.com/cgi-bin/sdk40.cgi"
		eerror "and download ${AD1} and ${AD2} and place them in"
		eerror "${DISTDIR} and emerge this package again or disable the \`doc'"
		eerror "USE flag."
		die
	fi

}

src_unpack() {

	unpack ${A}
	rpm_unpack *.rpm
	rm *.rpm

	if [ `use doc` ]; then
		unpack ${AD1}
		unpack ${AD2}
	fi

}

src_install() {

	dodir ${BASE}
	cp -Rf PalmOS-4.0-SDK-Update-1/PalmOS-Unix/PalmOS-Support/* opt/palmdev/sdk-4
	cp -Rf PalmOS-4.0-SDK-Update-1/PalmOS-Unix/Documentation/* opt/palmdev/sdk-4
	cp -PRf opt/palmdev/sdk-4/* ${D}/opt/palmdev/sdk-${SLOT}
	mv Documentation ${D}/opt/palmdev/sdk-${SLOT}
	mv Examples ${D}/opt/palmdev/sdk-${SLOT}/Documentation

}

pkg_postinst()
{
	palmdev-prep || eerror "Could not run \`palmdev-prep'!"
}
