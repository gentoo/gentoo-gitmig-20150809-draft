# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/openpbs-common/openpbs-common-1.0.0.ebuild,v 1.1 2005/07/05 20:02:19 robbat2 Exp $

inherit eutils

DESCRIPTION="Shared files for all OpenPBS implementations in Gentoo"
HOMEPAGE="http://www.gentoo.org"
SRC_URI=""
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE=""

DEPEND=""
RDEPEND="virtual/pbs"


src_install() {
	newinitd ${FILESDIR}/pbs-init.d pbs
	newconfd ${FILESDIR}/pbs-conf.d pbs
}
