# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/tw_cli/tw_cli-7.7.1.ebuild,v 1.1 2005/02/09 10:55:03 robbat2 Exp $

DESCRIPTION="3ware Command Line Interface"
HOMEPAGE="http://www.3ware.com"
LICENSE="3ware"
SLOT="0"
IUSE="doc"
RESTRICT="fetch"

# binary for x86 only
KEYWORDS="-* ~x86"

# upstream does NOT version releases in the filename :-(
SRC_URI_DOC="doc? ( ${PV}_Release_Notes_Web.pdf )"
SRC_URI_BIN="cli_linux.tgz"
SRC_URI="${SRC_URI_BIN} ${SRC_URI_DOC}"

DOWNLOAD_URL_APP="http://www.3ware.com/support/download.asp?code=8&id=${PV}&softtype=CLI&os=Linux"
DOWNLOAD_URL_DOC="http://www.3ware.com/download/Escalade7000Series/${PV}/${PV}_Release_Notes_Web.pdf"

# these are correct!
S="${WORKDIR}"
DEPEND=""
RDEPEND="virtual/libc"

supportedcards() {
	einfo "This binary supports the following units (the website is wrong):"
	einfo "PATA: 7210, 7410, 7450, 7810, 7850, 7000-2, 7500-4, 7500-8,"
	einfo "      7500-12, 7006-2, 7506-4, 7506-4LP, 7506-8, 7506-12"
	einfo "SATA: 8500-4, 8500-8, 8500-12, 8006-2, 8506-4, 8506-12,"
	einfo "      8506-8MI, 8506-12MI"
}

pkg_setup() {
	supportedcards
}

pkg_nofetch() {
	einfo "Please visit the following URL to download the application"
	einfo "${DOWNLOAD_URL_APP}"
	einfo "Select the following options:"
	einfo "Product: 3ware 7006-2 / 8006-2"
	einfo "Version: ${PV}"
	einfo "Operating System: Linux"
	echo
	if use doc; then
		einfo "Additionally, please fetch this documentation"
		echo
		einfo "${DOWNLOAD_URL_DOC}"
	fi
	einfo "Please your downloads into ${DISTDIR}"
}

src_unpack() {
	unpack ${SRC_URI_BIN}
}

src_install() {
	if use doc; then
		into /usr
		dodoc ${PV}_Release_Notes_Web.pdf
	fi

	into /
	dosbin tw_cli
}
