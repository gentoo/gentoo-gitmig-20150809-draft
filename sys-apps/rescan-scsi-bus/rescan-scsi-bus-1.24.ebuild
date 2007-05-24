# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/rescan-scsi-bus/rescan-scsi-bus-1.24.ebuild,v 1.2 2007/05/24 07:02:07 robbat2 Exp $

inherit versionator

DESCRIPTION="Script to rescan the SCSI bus without rebooting"
HOMEPAGE="http://www.garloff.de/kurt/linux/"
SCRIPT_NAME="${PN}.sh"
SRC_URI="mirror://gentoo/${SCRIPT_NAME}-${PV}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc ~hppa ~sparc"
IUSE=""

DEPEND=""
RDEPEND=">=sys-apps/sg3_utils-1.24
		 sys-apps/module-init-tools
		 app-shells/bash"

S="${WORKDIR}"

src_unpack() {
	cp -f ${DISTDIR}/${A} ${WORKDIR}/${SCRIPT_NAME}
}

src_compile() {
	einfo "Nothing to compile"
}

src_install() {
	into /usr
	dosbin ${SCRIPT_NAME}
	dosym ${SCRIPT_NAME} /sbin/${PN}
}
