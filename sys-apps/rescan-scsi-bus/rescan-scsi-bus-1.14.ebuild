# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/rescan-scsi-bus/rescan-scsi-bus-1.14.ebuild,v 1.1 2004/09/06 22:24:14 vapier Exp $

DESCRIPTION="script to rescan the SCSI bus to add/remove devices without rebooting"
HOMEPAGE="http://www.garloff.de/kurt/linux/"
SRC_URI="mirror://gentoo/rescan-scsi-bus.sh-${PV}.bz2"
#SRC_URI="http://www.garloff.de/kurt/linux/${PN}.sh"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""

DEPEND="app-shells/bash"

S="${WORKDIR}"

src_install() {
	newsbin ${PN}.sh-${PV} ${PN}
}
