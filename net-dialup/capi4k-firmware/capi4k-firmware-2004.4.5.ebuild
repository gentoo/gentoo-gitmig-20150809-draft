# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/capi4k-firmware/capi4k-firmware-2004.4.5.ebuild,v 1.1 2004/11/13 14:24:06 mrness Exp $

inherit rpm

MY_P=${P/capi4k-firmware/i4lfirm}
DESCRIPTION="ISDN firmware for active ISDN cards"
HOMEPAGE="http://www.isdn4linux.de/"
SRC_URI="ftp://ftp.suse.com/pub/suse/i386/9.1/suse/i586/${MY_P}-0.i586.rpm"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ~ppc"

IUSE=""
DEPEND="app-arch/rpm"
S=${WORKDIR}

src_install() {
	insinto /usr/share/isdn
	insopts -m 0444
	doins usr/lib/isdn/* || die "failed to copy firmware files"
}
