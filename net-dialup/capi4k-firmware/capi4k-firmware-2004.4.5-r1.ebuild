# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/capi4k-firmware/capi4k-firmware-2004.4.5-r1.ebuild,v 1.1 2004/11/20 13:14:29 mrness Exp $

inherit rpm

MY_P=${P/capi4k-firmware/i4lfirm}
DESCRIPTION="ISDN firmware for active ISDN cards"
HOMEPAGE="http://www.isdn4linux.de/"
SRC_URI="ftp://ftp.suse.com/pub/suse/i386/9.1/suse/i586/${MY_P}-0.i586.rpm"

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc s390 sparc x86"

IUSE=""
DEPEND="app-arch/rpm2targz"
S=${WORKDIR}

src_install() {
	dodir /lib/firmware /usr/lib/isdn
	insinto /lib/firmware
	insopts -m 0644
	cd ${S}/usr/lib/isdn || die "source firmware dir not found"
	local FIRMWARE_FILE MAIN_PN=${PN%%-*}
	for FIRMWARE_FILE in * ; do
		newins ${FIRMWARE_FILE} ${MAIN_PN}_${FIRMWARE_FILE} && \
			dosym /lib/firmware/${MAIN_PN}_${FIRMWARE_FILE} /usr/lib/isdn/${FIRMWARE_FILE} || \
			die "failed to install firmware file ${FIRMWARE_FILE}"
	done
}
