# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-block/tw_cli/tw_cli-2.00.00.042.ebuild,v 1.2 2005/04/08 23:53:43 robbat2 Exp $

DESCRIPTION="3ware Command Line Interface"
HOMEPAGE="http://www.3ware.com"
LICENSE="3ware"
SLOT="0"
# binary packages
KEYWORDS="-* x86 ~amd64"
IUSE="doc"
# stripping seems to break this sometimes
RESTRICT="fetch nostrip nomirror"
# binary packages
DEPEND=""
RDEPEND="virtual/libc"

MY_P="${P}+"
# upstream does NOT version releases in the filename :-(
SRC_URI="x86? ( tw_cli-linux-x86.tgz )
		amd64? ( tw_cli-linux-x86_64.tgz )"
DOWNLOAD_URL_APP="http://www.3ware.com/support/dnload_agreeeng.asp?code=2&id=&softtype=CLI&os=Linux"
S="${WORKDIR}/${MY_P}"

supportedcards() {
	einfo "This binary supports all current cards, including, but not"
	einfo "limited to:"
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
	einfo "Please visit the following URL to download the tarball"
	einfo "${DOWNLOAD_URL_APP}"
	einfo "Download the 32-bit version for x86 machines, or the"
	einfo "64-bit version for amd64 machines."
	einfo "Place your downloads into ${DISTDIR}"
	supportedcards
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
