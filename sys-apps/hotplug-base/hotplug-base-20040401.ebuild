# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/hotplug-base/hotplug-base-20040401.ebuild,v 1.11 2004/09/21 22:51:01 vapier Exp $

inherit eutils

# source maintainers named it hotplug-YYYY_MM_DD instead of hotplug-YYYYMMDD
MY_P=hotplug-${PV:0:4}_${PV:4:2}_${PV:6:2}
DESCRIPTION="Base Hotplug framework"
HOMEPAGE="http://linux-hotplug.sourceforge.net"
SRC_URI="mirror://kernel/linux/utils/kernel/hotplug/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="arm alpha amd64 hppa ia64 mips ppc ppc64 s390 sparc x86"
IUSE=""

S=${WORKDIR}/${MY_P}

src_install() {
	into /
	dosbin sbin/hotplug || die
	keepdir /etc/hotplug.d
}
