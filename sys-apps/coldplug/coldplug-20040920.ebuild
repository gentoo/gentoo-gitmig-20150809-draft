# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/coldplug/coldplug-20040920.ebuild,v 1.2 2004/11/10 17:52:48 gregkh Exp $

inherit eutils

# source maintainers named it hotplug-YYYY_MM_DD instead of hotplug-YYYYMMDD
MY_P=hotplug-${PV:0:4}_${PV:4:2}_${PV:6:2}
S=${WORKDIR}/${MY_P}
DESCRIPTION="coldplug init.d program to load modules at bootime"
HOMEPAGE="http://linux-hotplug.sourceforge.net"
SRC_URI="mirror://kernel/linux/utils/kernel/hotplug/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~sparc ~alpha ~hppa ~amd64 ~ia64 ~mips"
IUSE=""

# hotplug needs pcimodules utility provided by pcitutils-2.1.9-r1
DEPEND=">=sys-apps/hotplug-20040920"

src_install() {
	exeinto /etc/init.d
	newexe ${FILESDIR}/coldplug.rc coldplug
}

