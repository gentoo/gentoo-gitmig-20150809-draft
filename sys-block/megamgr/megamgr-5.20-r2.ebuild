# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-block/megamgr/megamgr-5.20-r2.ebuild,v 1.1 2011/07/07 17:14:45 idl0r Exp $

EAPI="3"

inherit multilib

DESCRIPTION="LSI Logic MegaRAID Text User Interface management tool"
HOMEPAGE="http://www.lsi.com"
SRC_URI="http://www.lsi.com/downloads/Public/MegaRAID%20Common%20Files/ut_linux_${PN##mega}_${PV}.zip"

LICENSE="LSI"
SLOT="0"
# This package can never enter stable, it can't be mirrored and upstream
# can remove the distfiles from their mirror anytime.
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-arch/unzip"

RESTRICT="mirror"

S="${WORKDIR}"

QA_PRESTRIPPED="/opt/bin/megamgr"

pkg_setup() {
	use amd64 && { has_multilib_profile || die "needs multilib profile on amd64"; }
}

src_install() {
	newdoc ut_linux_${PN##mega}_${PV}.txt ${PN}-release-${PV}.txt

	exeinto /opt/bin
	newexe megamgr.bin megamgr || die
}
