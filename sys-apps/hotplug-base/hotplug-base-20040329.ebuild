# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/hotplug-base/hotplug-base-20040329.ebuild,v 1.2 2004/03/30 00:12:14 gregkh Exp $

inherit eutils

# source maintainers named it hotplug-YYYY_MM_DD instead of hotplug-YYYYMMDD
MY_P=hotplug-${PV:0:4}_${PV:4:2}_${PV:6:2}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Base Hotplug framework"
HOMEPAGE="http://linux-hotplug.sourceforge.net"
SRC_URI="mirror://kernel/linux/utils/kernel/hotplug/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~amd64 ~ia64 ~mips"

src_unpack() {
	unpack ${A}
}

src_install() {
	into /
	dosbin sbin/hotplug
	keepdir /etc/hotplug.d/
}

