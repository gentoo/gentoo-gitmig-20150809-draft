# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/openpbs-common/openpbs-common-1.1.0.ebuild,v 1.3 2006/05/23 20:20:41 corsair Exp $

inherit eutils

DESCRIPTION="Shared files for all OpenPBS implementations in Gentoo"
HOMEPAGE="http://www.gentoo.org"
SRC_URI=""
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ppc64 x86"
IUSE=""

DEPEND=""
RDEPEND="virtual/pbs"

src_install() {
	newinitd ${FILESDIR}/pbs-init.d pbs
	newconfd ${FILESDIR}/pbs-conf.d pbs
	newenvd ${FILESDIR}/pbs-env.d 25pbs
}
