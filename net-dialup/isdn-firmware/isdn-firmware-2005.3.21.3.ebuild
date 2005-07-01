# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/isdn-firmware/isdn-firmware-2005.3.21.3.ebuild,v 1.1 2005/07/01 15:20:12 sbriesen Exp $

inherit rpm versionator

MY_PN="i4lfirm"
MY_PV="$(get_version_component_range 1-3)"
MY_PP="$(get_version_component_range 4)"
MY_P="${MY_PN}-${MY_PV}-${MY_PP}"

DESCRIPTION="ISDN firmware files for active cards"
HOMEPAGE="http://www.isdn4linux.de/"
SRC_URI="ftp://ftp.suse.com/pub/suse/i386/9.3/suse/i586/${MY_P}.i586.rpm"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~s390 ~sparc ~x86"

IUSE=""
S="${WORKDIR}/lib/firmware/isdn"

src_install() {
	insinto /lib/firmware
	insopts -m 0644
	doins *
}
