# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/binflash/binflash-1.56.ebuild,v 1.1 2011/06/26 10:57:11 jlec Exp $

EAPI=4

MY_PN=${PN/bin/nec}

DESCRIPTION="Tool to flash DVD burner with a binary firmware file"
HOMEPAGE="http://binflash.cdfreaks.com"
SRC_URI="http://binflash.cdfreaks.com/download/1/2/${MY_PN}_linux.tgz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RESTRICT="fetch strip"

S="${WORKDIR}"

pkg_nofetch() {
	elog "We cannot download this file for your due to license restrictions."
	elog "Please visit ${HOMEPAGE} and download ${A} into ${DISTDIR}."
}

src_install() {
	into /opt
	dobin ${MY_PN}
}
