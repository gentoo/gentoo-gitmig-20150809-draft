# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/tw_cli/tw_cli-2.00.00.042.ebuild,v 1.1 2005/02/21 02:05:51 robbat2 Exp $

DESCRIPTION="3ware Command Line Interface"
HOMEPAGE="http://www.3ware.com"
LICENSE="3ware"
SLOT="0"
IUSE="doc"
RESTRICT="fetch"

MY_P="${P}+"

# binary packages
KEYWORDS="-* ~x86 ~amd64"

# upstream does NOT version releases in the filename :-(
SRC_URI_BIN="x86? ( tw_cli-linux-x86.tgz )
			amd64? ( tw_cli-linux-x86_64.tgz )"
SRC_URI="${SRC_URI_BIN}"

DOWNLOAD_URL_APP="http://www.3ware.com/support/dnload_agreeeng.asp?code=2&id=&softtype=CLI&os=Linux"

# these are correct!
S="${WORKDIR}/${MY_P}"
DEPEND=""
RDEPEND="virtual/libc"

supportedcards() {
	einfo "This binary should support all current cards, including, but"
	einfo "not limited to:"
	einfo "PATA: 7210, 7410, 7450, 7810, 7850, 7000-2, 7500-4, 7500-8,"
	einfo "      7500-12, 7006-2, 7506-4, 7506-4LP, 7506-8, 7506-12"
	einfo "SATA: 8500-4, 8500-8, 8500-12, 8006-2, 8506-4, 8506-12,"
	einfo "      8506-8MI, 8506-12MI, 9500S-4LP, 9500S-8, 9500S-12,"
	einfo "      9500S-8MI, 9500S-12MI"
}

pkg_setup() {
	supportedcards
}

pkg_nofetch() {
	einfo "Please visit the following URL to download the application"
	einfo "${DOWNLOAD_URL_APP}"
	einfo "Download the 32-bit version for x86 machines, or the"
	einfo "64-bit version for amd64 machines."
	einfo "Place your downloads into ${DISTDIR}"
}

src_unpack() {
	unpack ${SRC_URI_BIN}
}

src_install() {
	into /
	dosbin tw_cli
	dosbin tw_sched
	insinto /etc
	doins tw_sched.cfg
	into /usr
	newman tw_cli.8.nroff tw_cli.8
	newman tw_sched.8.nroff tw_sched.8
	dohtml *.html
}
