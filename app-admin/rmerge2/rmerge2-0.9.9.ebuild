# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/rmerge2/rmerge2-0.9.9.ebuild,v 1.1 2003/05/07 21:07:39 mholzer Exp $

DESCRIPTION="robust version of 'emerge --emptytree' which supports resumption/forcing of builds"
HOMEPAGE="http://www.gentoo.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"

DEPEND="sys-apps/portage"

src_install() {
	insinto /usr/bin
	insopts -m755
	newins ${FILESDIR}/${PF} rmerge2
	dodir /var/lib/rmerge2
}
