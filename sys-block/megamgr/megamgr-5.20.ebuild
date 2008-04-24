# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-block/megamgr/megamgr-5.20.ebuild,v 1.1 2008/04/24 08:39:39 wschlich Exp $

inherit multilib

DESCRIPTION="LSI Logic MegaRAID Text User Interface management tool"
HOMEPAGE="http://www.lsi.com"
SRC_URI="http://www.lsi.com/files/support/rsa/utilities/megamgr/ut_linux_${PN##mega}_${PV}.zip"

LICENSE="LSI"
SLOT="0"
# This package can never enter stable, it can't be mirrored and upstream
# can remove the distfiles from their mirror anytime.
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-arch/unzip"

RESTRICT="strip mirror test"

S="${WORKDIR}"

src_compile() {
	echo "Nothing to compile."
}

src_install() {
	newdoc ut_linux_${PN##mega}_${PV}.txt ${PN}-release-${PV}.txt
	dosbin "${FILESDIR}"/megamgr megamgr.bin
}
