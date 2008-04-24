# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-block/dellmgr/dellmgr-5.31-r1.ebuild,v 1.1 2008/04/24 08:58:02 wschlich Exp $

inherit rpm

MY_PV=${PV}-0
DESCRIPTION="Dell PERC 2/3/4 RAID controller management tool"
HOMEPAGE="http://linux.dell.com/"
SRC_URI="http://ftp.us.dell.com/ide/perc-cerc-apps-6.03-A06.tar.gz"

LICENSE="Dell"
SLOT="0"
# This package can never enter stable, it can't be mirrored and upstream
# can remove the distfiles from their mirror anytime.
KEYWORDS="~x86"
IUSE=""

RESTRICT="strip mirror test"

S="${WORKDIR}"

src_unpack() {
	unpack ${A}
	rpm_unpack "${S}"/Dellmgr-${MY_PV}.i386.rpm || die "failed to unpack RPM"
}

src_compile() {
	echo "Nothing to compile."
}

src_install() {
	dosbin "${FILESDIR}"/dellmgr-r1
	dosbin usr/sbin/dellmgr.bin
}
