# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/rmerge2/rmerge2-0.9.7.ebuild,v 1.2 2002/10/31 18:13:21 karltk Exp $

DESCRIPTION="rmerge2 is a robust version of 'emerge --emptytree' which supports resumption/forcing of builds"
HOMEPAGE=""
LICENSE="GPL-2"
SRC_URI=""
SLOT="0"
DEPEND="sys-apps/portage"
RDEPEND="${DEPEND}"
KEYWORDS="~x86 ~ppc ~sparc ~sparc64 ~alpha"
IUSE=""

src_install() {
	echo ${PV}
	insinto /usr/bin
	insopts -m755
	newins ${FILESDIR}/${PF} rmerge2

	dodir /var/lib/rmerge2
}
