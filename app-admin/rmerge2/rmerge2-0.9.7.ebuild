# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/rmerge2/rmerge2-0.9.7.ebuild,v 1.5 2002/12/15 10:44:09 bjb Exp $

DESCRIPTION="rmerge2 is a robust version of 'emerge --emptytree' which supports resumption/forcing of builds"
HOMEPAGE=""
LICENSE="GPL-2"
SRC_URI=""
SLOT="0"
DEPEND="sys-apps/portage"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"
IUSE=""

src_install() {
	echo ${PV}
	insinto /usr/bin
	insopts -m755
	newins ${FILESDIR}/${PF} rmerge2

	dodir /var/lib/rmerge2
}
