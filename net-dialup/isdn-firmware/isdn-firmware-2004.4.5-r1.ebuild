# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/isdn-firmware/isdn-firmware-2004.4.5-r1.ebuild,v 1.2 2004/12/22 22:17:14 mrness Exp $

inherit rpm

MY_P=${P/isdn-firmware/i4lfirm}
DESCRIPTION="ISDN firmware files for active cards"
HOMEPAGE="http://www.isdn4linux.de/"
SRC_URI="ftp://ftp.suse.com/pub/suse/i386/9.1/suse/i586/${MY_P}-0.i586.rpm"

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc s390 sparc x86"

IUSE=""
S="${WORKDIR}/usr/lib/isdn"

src_install() {
	insinto /lib/firmware
	insopts -m 0644
	doins *

	#Compatibility with <=net-dialup/isdn4k-utils-20041006-r3. 
	#Please remove it when it becomes obsolete
	dosym firmware /lib/isdn
}
