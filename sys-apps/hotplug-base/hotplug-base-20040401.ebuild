# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/hotplug-base/hotplug-base-20040401.ebuild,v 1.9 2004/07/22 21:56:22 tgall Exp $

inherit eutils

# source maintainers named it hotplug-YYYY_MM_DD instead of hotplug-YYYYMMDD
MY_P=hotplug-${PV:0:4}_${PV:4:2}_${PV:6:2}
DESCRIPTION="Base Hotplug framework"
HOMEPAGE="http://linux-hotplug.sourceforge.net"
SRC_URI="mirror://kernel/linux/utils/kernel/hotplug/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc mips ~alpha arm hppa amd64 ~ia64 ppc64"
IUSE=""

S=${WORKDIR}/${MY_P}

src_install() {
	into /
	dosbin sbin/hotplug || die
	keepdir /etc/hotplug.d
}
