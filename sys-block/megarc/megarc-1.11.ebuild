# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-block/megarc/megarc-1.11.ebuild,v 1.1 2008/04/23 21:32:43 wschlich Exp $

inherit multilib

DESCRIPTION="LSI Logic MegaRAID Text User Interface management tool"
HOMEPAGE="http://www.lsi.com"
SRC_URI="http://www.lsi.com/files/support/rsa/utilities/megaconf/ut_linux_${PN}_${PV}.zip"

LICENSE="LSI"
SLOT="0"
# This package can never enter stable, it can't be mirrored and upstream
# can remove the distfiles from their mirror anytime.
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND="app-arch/unzip
	doc? ( app-text/antiword )"

RESTRICT="strip mirror test"

S="${WORKDIR}"

src_compile() {
	useq doc && antiword ut_linux.doc > ${PN}-manual.txt
}

src_install() {
	useq doc && dodoc ${PN}-manual.txt
	newdoc ut_linux_${PN}_${PV}.txt ${PN}-release-${PV}.txt
	dosbin "${FILESDIR}"/megarc megarc.bin
}
