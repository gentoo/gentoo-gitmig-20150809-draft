# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/palmos-sdk/palmos-sdk-4.0.ebuild,v 1.6 2006/03/19 22:22:25 halcy0n Exp $

inherit rpm

DESCRIPTION="The static libraries and header files needed for developing PalmOS applications."
HOMEPAGE="http://www.palmos.com/"
LICENSE="Palm-SDK"

SLOT="4.0"
KEYWORDS="~x86"
RDEPEND="dev-lang/prc-tools"
DEPEND="${RDEPEND}
	app-arch/unzip"
# Note: There is an sdk40-docs.tar.gz but it's actually a zip file, so
# might as well just get the zip file.
SRC_URI="sdk40.tar.gz sdk40upd1.tar.gz
	doc? ( sdk40-docs.zip sdk40-examples.tar.gz )"
IUSE="doc"
RESTRICT="nostrip fetch"
S=${WORKDIR}

pkg_nofetch() {
	typeset a

	einfo "Please download the following files from"
	einfo "http://www.palmos.com/cgi-bin/sdk40.cgi"
	einfo "and put them in ${DISTDIR}, then emerge this package again."
	for a in ${A}; do
		einfo "  ${a}"
	done
}

src_unpack() {
	unpack ${A}
	rpm_unpack *.rpm
}

src_install() {
	typeset base=/opt/palmdev/sdk-${SLOT}

	# Copy the updates over top of the existing files
	cp -Rf PalmOS-4.0-SDK-Update-1/PalmOS-Unix/PalmOS-Support/* \
		opt/palmdev/sdk-4 || die
	if use doc; then
		cp -Rf PalmOS-4.0-SDK-Update-1/PalmOS-Unix/Documentation/* \
			Documentation || die
	fi

	# Now install
	dodir ${base%/*} || die
	mv opt/palmdev/sdk-4 ${D}${base} || die
	if use doc; then
		mv Documentation ${D}${base} || die
		mv Examples ${D}${base}/Documentation || die
	fi
}

pkg_postinst() {
	palmdev-prep || eerror "Error running palmdev-prep :-("
}
